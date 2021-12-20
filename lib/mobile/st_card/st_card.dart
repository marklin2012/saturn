import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';

enum STCardType { basic, easy, icon }

const _defaultImageHeight = 192.0;
const _defaultTitleHeight = 48.0;
const _defaultContentHeight = 82.0;
const _defaultBackgroundColor = Color(0xFFFAFCFF);
const _defaultLineColor = Color(0xFFEFF3F9);
const _defaultImageBGColor = Color(0xFFDFE2E7);
const _spaceHeight = 8.0;

class STCard extends StatelessWidget {
  const STCard({
    Key key,
    this.type = STCardType.easy,
    this.shadowed = false,
    this.child,
    this.title,
    this.subTitle,
    this.titleStyle = const TextStyle(
        fontSize: 18.0, color: Color(0xFF000000), fontWeight: FontWeight.w500),
    this.subTitleStyle =
        const TextStyle(fontSize: 16.0, color: Color(0xFF000000)),
    this.opration,
    this.backgroundColor = _defaultBackgroundColor,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
  }) : super(key: key);

  final STCardType type; // 类型
  final EdgeInsets margin; //外边距
  final bool shadowed; // 是否有阴影
  final Color backgroundColor; // 背景颜色
  final Widget child; // 内容,icon时即为图片
  final String title; // 主标题
  final String subTitle; // 子标题
  final TextStyle titleStyle; // 主标题样式
  final TextStyle subTitleStyle; // 子标题样式
  final Widget opration; // 操作按钮

  @override
  Widget build(BuildContext context) {
    final List<Widget> _subWidgets = <Widget>[];
    if (type == STCardType.basic) {
      final _title = title ?? '卡片名称';
      final _titleW = Container(
        height: _defaultTitleHeight,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_title, style: titleStyle),
            opration,
          ],
        ),
      );
      _subWidgets.add(_titleW);
      _subWidgets.add(Container(height: 1, color: _defaultLineColor));
      _subWidgets.add(child);
    } else if (type == STCardType.icon) {
      final _imageW = Container(
        decoration: const BoxDecoration(
          color: _defaultImageBGColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
        ),
        height: _defaultImageHeight,
        alignment: Alignment.center,
        child: child ??
            const Icon(STIcons.commonly_picture,
                size: 110, color: Colors.white),
      );
      final _title = title ?? 'PHOTO BY HEATH';
      final _subTitle =
          subTitle ?? '"${DateTime.now().toString().substring(0, 16)}"';
      final _botW = Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        height: _defaultContentHeight,
        color: _defaultBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_title, style: titleStyle),
            const SizedBox(height: _spaceHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_subTitle, style: subTitleStyle),
                opration,
              ],
            ),
          ],
        ),
      );
      _subWidgets.add(_imageW);
      _subWidgets.add(_botW);
    } else {
      _subWidgets.add(child);
    }
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          if (shadowed)
            const BoxShadow(
              blurRadius: 5,
              color: Color(0x20000000),
            )
        ],
      ),
      child: Column(
        children: _subWidgets,
      ),
    );
  }
}
