import 'package:flutter/material.dart';

import 'common.dart';

class STMessage extends StatefulWidget {
  final String title;
  final String message;
  final String explainInfo;
  final String explain;
  final String icon;

  const STMessage({
    Key key,
    this.title,
    @required this.message,
    this.explainInfo,
    this.explain,
    this.icon,
  }) : super(key: key);

  static void show(
      {@required BuildContext context,
      String title,
      String message,
      String explainInfo,
      String explain,
      String icon}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          final _message = STMessage(
              title: title,
              message: message,
              explainInfo: explainInfo,
              explain: explain,
              icon: icon);
          return GestureDetector(
            onTap: () {
              STMessage.hide(context);
            },
            child: _message,
          );
          ;
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  _STMessageState createState() => _STMessageState();
}

class _STMessageState extends State<STMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget;

    TextStyle titleStyle = const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: STMessageConstant.titleFontSize,
        decoration: TextDecoration.none);

    TextStyle messageStyle = const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: STMessageConstant.messageFontSize,
        decoration: TextDecoration.none);

    TextStyle explainStyle = const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
        fontSize: STMessageConstant.explainFontSize,
        decoration: TextDecoration.none);

    Image imageWidget;
    if (widget.icon != null) {
      imageWidget = Image.asset(widget.icon,
          width: STMessageConstant.iconWidth,
          height: STMessageConstant.iconWidth,
          fit: BoxFit.contain);
    }

    Text titleWidget;
    if (widget.title != null) {
      titleWidget = Text(widget.title, softWrap: false, style: titleStyle);
    }

    final Text messageWidget =
        Text(widget.message, softWrap: true, style: messageStyle);

    final bool haveExplain =
        (widget.explain != null) && (widget.explainInfo != null);
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: STMessageConstant.defaultWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STMessageConstant.cornerRadius),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        imageWidget,
                        const SizedBox(
                          width: 8,
                        ),
                        if (haveExplain)
                          Text(widget.explain, style: explainStyle)
                        else if (widget.title != null)
                          titleWidget
                        else
                          messageWidget,
                      ],
                    ),
                    if (haveExplain)
                      Text(widget.explainInfo, style: explainStyle)
                  ],
                ),
                if (haveExplain)
                  titleWidget
                else if (widget.title != null)
                  messageWidget,
                if (haveExplain) messageWidget,
              ],
            ),
          ),
        ));
  }
}
