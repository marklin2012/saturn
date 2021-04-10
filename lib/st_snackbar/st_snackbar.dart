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

  const STSnackbar(
      {Key key,
      this.message,
      this.title,
      this.buttonText,
      this.buttonTextColor,
      this.buttonHaveBackground,
      this.image,
      this.icon,
      this.iconColor})
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
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          final snackbar = new STSnackbar(
              title: title,
              message: message,
              buttonText: buttonText,
              buttonTextColor: buttonTextColor,
              buttonHaveBackground: buttonHaveBackground,
              image: image,
              icon: icon,
              iconColor: iconColor);
          return GestureDetector(
            onTap: () {
              STSnackbar.hide(context);
            },
            child: snackbar,
          );
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
    double screenWidth = MediaQuery.of(context).size.width;
    double containerMaxWidth = screenWidth * STSnackbarConstant.maxWidthPercent;

    BoxDecoration boxDecoration = BoxDecoration(
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

    FlatButton buttonWidget;
    if (!isNullOrEmpty(widget.buttonText)) {
      buttonWidget = FlatButton(
        child: Text(widget.buttonText,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: curButtonTextColor,
                fontSize: 16,
                decoration: TextDecoration.none)),
        color: widget.buttonHaveBackground
            ? STSnackbarConstant.blueColor
            : Colors.transparent,
        onPressed: () {},
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

    return Center(
        child: Container(
      constraints: BoxConstraints(maxWidth: containerMaxWidth),
      decoration: boxDecoration,
      child: Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (imageWidget != null) imageWidget,
                if (imageWidget != null) SizedBox(width: 14),
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
    ));
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
