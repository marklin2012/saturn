import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saturn/st_snackbar/common.dart';

import '../utils/string.dart';

class STSnackbar extends StatefulWidget {
  final String message;
  final String title;
  final String buttonText;
  final Color buttonTextColor;
  final bool buttonHaveBackground;
  final String image;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onButtonTap;
  final bool autoClose;
  final int disappearTime;

  const STSnackbar(
      {Key key,
      this.message,
      this.title,
      this.buttonText,
      this.buttonTextColor,
      this.buttonHaveBackground,
      this.image,
      this.icon,
      this.iconColor,
      this.onButtonTap,
      this.autoClose,
      this.disappearTime})
      : super(key: key);

  static void show(
      {@required BuildContext context,
      @required String title,
      String message,
      String buttonText,
      Color buttonTextColor,
      bool buttonHaveBackground = false,
      String image,
      IconData icon,
      Color iconColor = Colors.white,
      VoidCallback onButtonTap,
      bool autoClose,
      int disappearTime = STSnackbarConstant.defaultDisappearTime}) {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        builder: (context) {
          final snackbar = STSnackbar(
            title: title,
            message: message,
            buttonText: buttonText,
            buttonTextColor: buttonTextColor,
            buttonHaveBackground: buttonHaveBackground,
            image: image,
            icon: icon,
            iconColor: iconColor,
            onButtonTap: onButtonTap,
            autoClose: autoClose,
            disappearTime: disappearTime,
          );

          return snackbar;
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

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
      timer = Timer(Duration(milliseconds: widget.disappearTime * 1000), () {
        STSnackbar.hide(context);
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
            color: Colors.grey,
            fontSize: STSnackbarConstant.messageFontSize,
            decoration: TextDecoration.none),
      );
    }

    Color curButtonTextColor;
    if (widget.buttonTextColor == null) {
      if (widget.buttonHaveBackground) {
        curButtonTextColor = Colors.white;
      } else {
        curButtonTextColor = STSnackbarConstant.blueColor;
      }
    } else {
      curButtonTextColor = widget.buttonTextColor;
    }

    TextButton buttonWidget;
    if (!isNullOrEmpty(widget.buttonText)) {
      buttonWidget = TextButton(
        onPressed: () {
          if (widget.onButtonTap != null) {
            widget.onButtonTap();
          } else {
            STSnackbar.hide(context);
          }
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(
                STSnackbarConstant.textButtonPadding,
                STSnackbarConstant.textButtonPadding,
                STSnackbarConstant.textButtonPadding,
                STSnackbarConstant.textButtonPadding),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(STSnackbarConstant.buttonCornerRadius),
              color: widget.buttonHaveBackground
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
    }

    Widget imageWidget;
    if (widget.icon == null) {
      if (!isNullOrEmpty(widget.image)) {
        imageWidget = Image.asset(widget.image, fit: BoxFit.fitWidth);
      }
    } else {
      imageWidget = Icon(
        widget.icon,
        color: widget.iconColor,
      );
    }

    return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
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
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                      if (imageWidget != null) imageWidget,
                      if (imageWidget != null) const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (titleWidget != null) titleWidget,
                              if (messageWidget != null) messageWidget
                            ]),
                      )
                    ])),
                    if (buttonWidget != null) buttonWidget
                  ],
                )),
          ),
        ));
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
