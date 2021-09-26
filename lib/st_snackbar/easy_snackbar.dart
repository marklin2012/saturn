import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saturn/st_snackbar/common.dart';

import '../utils/platform.dart';

class EasySnackbar extends StatefulWidget {
  final Widget message;
  final Widget title;
  final Widget closeButton;
  final Widget icon;
  final bool autoClose;
  final Alignment alignment;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final double radius;
  final int disappearMilliseconds;

  static BuildContext _curContext;
  static OverlayEntry _curOverlayEntry;

  static void show({
    @required BuildContext context,
    @required Widget title,
    Widget message,
    Widget closeButton,
    Widget icon,
    bool autoClose,
    Alignment alignment,
    EdgeInsets margin,
    EdgeInsets padding,
    Color backgroundColor,
    double radius,
    int disappearMilliseconds = STSnackbarConstant.defaultDisappearMilliseconds,
  }) {
    if (_curContext != null) {
      hide(context);
    }

    final snackbar = EasySnackbar(
      title: title,
      message: message,
      closeButton: closeButton,
      icon: icon,
      autoClose: autoClose,
      alignment: alignment,
      margin: margin,
      padding: padding,
      backgroundColor: backgroundColor,
      radius: radius,
      disappearMilliseconds: disappearMilliseconds,
    );

    final OverlayState overlayState = Overlay.of(context);
    _curOverlayEntry =
        OverlayEntry(builder: (BuildContext context) => snackbar);
    overlayState.insert(_curOverlayEntry);
    _curContext = context;
  }

  static void hide(
    BuildContext context,
  ) {
    _curOverlayEntry.remove();
    _curContext = null;
  }

  const EasySnackbar({
    Key key,
    this.message,
    this.title,
    this.icon,
    this.autoClose,
    this.disappearMilliseconds,
    this.closeButton,
    this.alignment,
    this.padding,
    this.backgroundColor,
    this.margin,
    this.radius,
  }) : super(key: key);

  @override
  _EasySnackbarState createState() => _EasySnackbarState();
}

class _EasySnackbarState extends State<EasySnackbar> {
  Timer timer;
  Alignment _alignment;
  EdgeInsets _margin;
  EdgeInsets _padding;
  Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    bool isCurAutoClose = true;
    if (widget.autoClose != null) {
      isCurAutoClose = widget.autoClose;
    }
    _margin = widget.margin;
    _padding = widget.padding ?? const EdgeInsets.all(10);
    _alignment = widget.alignment ?? Alignment.bottomCenter;
    _backgroundColor =
        widget.backgroundColor ?? STSnackbarConstant.defaultBackgroundColor;

    if (isCurAutoClose) {
      timer = Timer(Duration(milliseconds: widget.disappearMilliseconds), () {
        EasySnackbar.hide(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.radius ?? 0),
      color: _backgroundColor,
    );

    final Widget columnWidget = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) widget.title,
          if (widget.message != null) const SizedBox(height: 4),
          if (widget.message != null) widget.message
        ]);

    Widget innerWidget;

    if (getIsWeb()) {
      innerWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) widget.icon,
          if (widget.icon != null) const SizedBox(width: 12),
          columnWidget
        ],
      );
    } else {
      innerWidget = Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) widget.icon,
            if (widget.icon != null) const SizedBox(width: 12),
            Expanded(child: columnWidget)
          ],
        ),
      );
    }

    final Widget content = Align(
      alignment: _alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        decoration: boxDecoration,
        margin: _margin ??
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        padding: _padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            innerWidget,
            if (getIsWeb()) const SizedBox(width: 30),
            if (widget.closeButton != null)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  EasySnackbar.hide(context);
                },
                child: widget.closeButton,
              )
          ],
        ),
      ),
    );

    return content;
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
