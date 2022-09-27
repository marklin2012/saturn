import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_message/common.dart';
import 'package:saturn/utils/platform.dart';
import 'package:saturn/utils/string.dart';

class STMessage extends StatefulWidget {
  final String? title;
  final String? message;
  final Widget? icon;
  final Widget? content;
  final bool? showShadow;
  final bool? autoClose;
  final int? disappearMilliseconds;
  final STMessageLocation? location;
  final STMessageType? type;

  static BuildContext? _curContext;
  static late OverlayEntry _curOverlayEntry;

  static void show({
    required BuildContext context,
    String? title,
    String? message,
    Widget? icon,
    Widget? content,
    bool showShadow = true,
    bool autoClose = true,
    int disappearMilliseconds = STMessageConstant.defaultDisappearMilliseconds,
    STMessageLocation location = STMessageLocation.top,
    STMessageType type = STMessageType.none,
  }) {
    if (_curContext != null) {
      hide(context);
    }

    final _message = STMessage(
      title: title,
      message: message,
      icon: icon,
      content: content,
      showShadow: showShadow,
      autoClose: autoClose,
      disappearMilliseconds: disappearMilliseconds,
      location: location,
      type: type,
    );

    final OverlayState overlayState = Overlay.of(context)!;
    _curOverlayEntry =
        OverlayEntry(builder: (BuildContext context) => _message);
    overlayState.insert(_curOverlayEntry);
    _curContext = context;
  }

  static void hide(
    BuildContext context,
  ) {
    _curOverlayEntry.remove();
    _curContext = null;
  }

  const STMessage(
      {Key? key,
      this.title,
      this.message,
      this.icon,
      this.content,
      this.showShadow,
      this.autoClose,
      this.disappearMilliseconds,
      this.location,
      this.type,})
      : super(key: key);

  @override
  _STMessageState createState() => _STMessageState();
}

class _STMessageState extends State<STMessage> {
  Timer? timer;
  TextStyle? titleTextStyle;
  TextStyle? messageTextStyle;
  late Offset containerShadowOffset;
  late EdgeInsets iconTitlePadding;

  @override
  void initState() {
    super.initState();

    if (widget.autoClose!) {
      timer = Timer(Duration(milliseconds: widget.disappearMilliseconds!), () {
        STMessage.hide(context);
      });
    }

    titleTextStyle = const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: STMessageConstant.titleFontSize,
        decoration: TextDecoration.none,);

    messageTextStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: STMessageConstant.messageFontSize,
      decoration: TextDecoration.none,
    );

    containerShadowOffset = const Offset(5.0, 5.0);

    iconTitlePadding =
        const EdgeInsets.only(right: STMessageConstant.iconMessageDistance);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth;

    double defaultWidth;
    if (getIsWeb()) {
      defaultWidth = screenWidth * STMessageConstant.defaultWidthPercent / 2.0;
    } else {
      defaultWidth = screenWidth * STMessageConstant.defaultWidthPercent;
    }
    containerWidth = defaultWidth;

    Text? titleWidget;
    if (!isNullOrEmpty(widget.title)) {
      titleWidget = Text(widget.title!, softWrap: true, style: titleTextStyle);
    }

    Text? messageWidget;
    if (!isNullOrEmpty(widget.message)) {
      messageWidget = Text(
        widget.message!,
        softWrap: true,
        style: messageTextStyle,
      );
    }

    Widget? iconWidget = widget.icon;
    if (iconWidget == null && widget.type != STMessageType.none) {
      iconWidget = iconFromAlertType(widget.type);
    }

    return SafeArea(
      child: Align(
        alignment: getAligmentFromLocation(widget.location),
        child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STMessageConstant.cornerRadius),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color:
                      widget.showShadow! ? Colors.black12 : Colors.transparent,
                  offset: containerShadowOffset,
                  blurRadius: 5.0,
                  spreadRadius: 2.0,),
            ],
          ),
          child: widget.content ??
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (iconWidget != null)
                                Padding(
                                    padding: iconTitlePadding,
                                    child: iconWidget,),
                              if (titleWidget != null)
                                Expanded(child: titleWidget),
                              if (titleWidget == null && messageWidget != null)
                                Expanded(child: messageWidget)
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (titleWidget != null && messageWidget != null)
                      const SizedBox(height: 2),
                    if (titleWidget != null && messageWidget != null)
                      messageWidget,
                  ],
                ),
              ),
        ),
      ),
    );
  }

  AlignmentGeometry getAligmentFromLocation(STMessageLocation? location) {
    switch (widget.location) {
      case STMessageLocation.center:
        return Alignment.center;
      case STMessageLocation.bottom:
        return Alignment.bottomCenter;
      default:
        return Alignment.topCenter;
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  Widget iconFromAlertType(STMessageType? type) {
    IconData? iconData;
    Color? iconColor;
    switch (type) {
      case STMessageType.success:
        iconData = Icons.check_circle;
        iconColor = STMessageConstant.colorSuccess;
        break;
      case STMessageType.error:
        iconData = Icons.cancel;
        iconColor = STMessageConstant.colorError;
        break;
      case STMessageType.warning:
        iconData = Icons.error;
        iconColor = STMessageConstant.colorWarnning;
        break;
      case STMessageType.info:
        iconData = Icons.info;
        iconColor = STMessageConstant.colorInfo;
        break;
      default:
    }
    return Icon(
      iconData,
      size: STMessageConstant.iconWidth,
      color: iconColor,
    );
  }
}
