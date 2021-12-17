import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';

const double _minHeight = 162.0;

class STEmptyData extends StatelessWidget {
  const STEmptyData({
    Key key,
    this.icon,
    this.content,
    this.customBtn,
    this.defaultTitle = '暂无内容',
    this.titleStyle,
    this.contentStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 70.0),
    this.backgroundColor = STColor.backgroundColor,
  }) : super(key: key);

  final Widget icon;
  final String defaultTitle;
  final TextStyle titleStyle;
  final String content;
  final TextStyle contentStyle;
  final Widget customBtn;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      constraints: BoxConstraints(
        minHeight: _minHeight,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      alignment: Alignment.center,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: icon,
            ),
          Text(
            defaultTitle,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 16.0,
                  color: STColor.firRankFont,
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (content != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                content,
                style: contentStyle ??
                    const TextStyle(
                      fontSize: 14.0,
                      color: STColor.secRankFont,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          if (customBtn != null)
            Padding(
              padding: const EdgeInsets.only(top: 62.0),
              child: customBtn,
            ),
        ],
      ),
    );
  }
}
