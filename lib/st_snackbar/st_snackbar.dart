import 'package:flutter/material.dart';
import 'package:saturn/st_snackbar/common.dart';

class STSnackbar extends StatefulWidget {
  final String message;
  final String title;
  final String buttonText;
  final Color buttonTextColor;
  final bool buttonHaveBackground;
  final String image;
  final IconData icon;
  final Color iconColor;
  final STSnackbarLocationType locationType;
  final double topPadding;
  final double bottomPadding;

  final VoidCallback onButtonTap;

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
      this.locationType,
      this.topPadding,
      this.bottomPadding,
      this.onButtonTap})
      : super(key: key);

  static void show({
    @required BuildContext context,
    @required String title,
    String message,
    String buttonText,
    Color buttonTextColor,
    bool buttonHaveBackground = false,
    String image,
    IconData icon,
    Color iconColor = Colors.white,
    STSnackbarLocationType locationType = STSnackbarLocationType.center,
    double topPadding = STSnackbarConstant.defaultTopBottomPadding,
    double bottomPadding = STSnackbarConstant.defaultTopBottomPadding,
    VoidCallback onButtonTap,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
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
            locationType: locationType,
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            onButtonTap: onButtonTap,
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

    double curTopPadding = 0;
    double curBottomPadding = 0;
    AlignmentGeometry alignment;
    switch (widget.locationType) {
      case STSnackbarLocationType.top:
        alignment = Alignment.topCenter;
        curTopPadding = widget.topPadding;
        break;
      case STSnackbarLocationType.center:
        alignment = Alignment.center;
        break;
      case STSnackbarLocationType.bottom:
        alignment = Alignment.bottomCenter;
        curBottomPadding = widget.bottomPadding;
        break;
    }
    return Align(
        alignment: alignment,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, curTopPadding, 0, curBottomPadding),
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
            )));
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
