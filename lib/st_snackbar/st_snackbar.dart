import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saturn/st_snackbar/common.dart';

import '../utils/string.dart';

class STSnackbarSharedInstance {
  BuildContext _curContext;
  OverlayEntry _curOverlayEntry;

  factory STSnackbarSharedInstance() => _sharedInstance();

  static STSnackbarSharedInstance _instance;

  STSnackbarSharedInstance._();

  static STSnackbarSharedInstance _sharedInstance() {
    return _instance ??= STSnackbarSharedInstance._();
  }

  void show(
      {@required BuildContext context,
      @required String title,
      String message,
      bool hasCloseButton = true,
      String buttonText,
      Color buttonTextColor,
      bool isButtonHasBackground = false,
      Widget icon,
      VoidCallback onButtonTap,
      bool autoClose,
      int disappearMilliseconds =
          STSnackbarConstant.defaultDisappearMilliseconds,
      bool hasSafeArea = true}) {
    if (_curContext != null) {
      hide(context);
    }

    final snackbar = STSnackbar(
      title: title,
      message: message,
      hasCloseButton: hasCloseButton,
      buttonText: buttonText,
      buttonTextColor: buttonTextColor,
      isButtonHasBackground: isButtonHasBackground,
      icon: icon,
      onButtonTap: onButtonTap,
      autoClose: autoClose,
      disappearMilliseconds: disappearMilliseconds,
      hasSafeArea: hasSafeArea,
    );

    final OverlayState overlayState = Overlay.of(context);
    _curOverlayEntry =
        OverlayEntry(builder: (BuildContext context) => snackbar);
    overlayState.insert(_curOverlayEntry);
    _curContext = context;
  }

  void hide(
    BuildContext context,
  ) {
    _curOverlayEntry.remove();
    _curContext = null;
  }
}

class STSnackbar extends StatefulWidget {
  final String message;
  final String title;
  final bool hasCloseButton;
  final String buttonText;
  final Color buttonTextColor;
  final bool isButtonHasBackground;
  final Widget icon;
  final VoidCallback onButtonTap;
  final bool autoClose;
  final int disappearMilliseconds;
  final bool hasSafeArea;

  const STSnackbar(
      {Key key,
      this.message,
      this.title,
      this.hasCloseButton,
      this.buttonText,
      this.buttonTextColor,
      this.isButtonHasBackground,
      this.icon,
      this.onButtonTap,
      this.autoClose,
      this.disappearMilliseconds,
      this.hasSafeArea})
      : super(key: key);

  @override
  _STSnackbarState createState() => _STSnackbarState();
}

class _STSnackbarState extends State<STSnackbar> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    bool isCurAutoClose = false;
    if (widget.autoClose == null) {
      if (isNullOrEmpty(widget.buttonText)) {
        isCurAutoClose = true;
      }
    } else if (widget.autoClose == true) {
      isCurAutoClose = true;
    }

    if (isCurAutoClose) {
      timer = Timer(Duration(milliseconds: widget.disappearMilliseconds), () {
        STSnackbarSharedInstance().hide(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerMaxWidth =
        screenWidth * STSnackbarConstant.maxWidthPercent;

    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(STSnackbarConstant.cornerRadius),
      color: STSnackbarConstant.defaultBackgroundColor,
    );

    Text titleWidget;
    if (!isNullOrEmpty(widget.title)) {
      titleWidget = Text(
        widget.title,
        softWrap: true,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: STSnackbarConstant.titleFontSize,
            decoration: TextDecoration.none),
      );
    }

    Text messageWidget;
    if (!isNullOrEmpty(widget.message)) {
      messageWidget = Text(
        widget.message,
        softWrap: true,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: STSnackbarConstant.messageFontSize,
            decoration: TextDecoration.none),
      );
    }

    Color curButtonTextColor;
    if (widget.buttonTextColor == null) {
      if (widget.isButtonHasBackground) {
        curButtonTextColor = Colors.white;
      } else {
        curButtonTextColor = STSnackbarConstant.blueColor;
      }
    } else {
      curButtonTextColor = widget.buttonTextColor;
    }

    Widget buttonWidget;
    if (widget.hasCloseButton) {
      if (!isNullOrEmpty(widget.buttonText)) {
        buttonWidget = TextButton(
          onPressed: () {
            if (widget.onButtonTap != null) {
              widget.onButtonTap();
            } else {
              STSnackbarSharedInstance().hide(context);
            }
          },
          child: Container(
              padding:
                  const EdgeInsets.all(STSnackbarConstant.textButtonPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    STSnackbarConstant.buttonCornerRadius),
                color: widget.isButtonHasBackground
                    ? STSnackbarConstant.blueColor
                    : Colors.transparent,
              ),
              child: Text(widget.buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: curButtonTextColor,
                      fontSize: 16,
                      decoration: TextDecoration.none))),
        );
      } else {
        buttonWidget = TextButton(
          onPressed: () {
            if (widget.onButtonTap != null) {
              widget.onButtonTap();
            } else {
              STSnackbarSharedInstance().hide(context);
            }
          },
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        );
      }
    }

    final Widget content = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: BoxConstraints(maxWidth: containerMaxWidth),
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) widget.icon,
                    if (widget.icon != null) const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (titleWidget != null) titleWidget,
                            if (messageWidget != null) messageWidget
                          ]),
                    )
                  ],
                ),
              ),
              if (buttonWidget != null) buttonWidget
            ],
          ),
        ),
      ),
    );

    if (widget.hasSafeArea) {
      return SafeArea(child: content);
    } else {
      return content;
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
