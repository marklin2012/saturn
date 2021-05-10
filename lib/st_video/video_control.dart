import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_icons/st_icons.dart';

enum STVideoStatus { play, pause, fail, loading }

class STVideoControl extends StatelessWidget {
  const STVideoControl(
      {Key key,
      this.type = STVideoStatus.loading,
      this.bordered = false,
      this.size = const Size(80.0, 60.0),
      this.backgroundColor = const Color(0xFFFAFCFF),
      this.activeColor = Colors.white,
      this.onChanged})
      : super(key: key);

  final STVideoStatus type; //状态
  final bool bordered; // 是否有边框
  final Size size; // 宽高
  final Color backgroundColor; //背景颜色
  final Color activeColor; //边框和图片颜色
  final ValueChanged<STVideoStatus> onChanged; // 状态改变

  @override
  Widget build(BuildContext context) {
    Widget _child;
    if (type == STVideoStatus.play) {
      _child = Icon(STIcons.status_timeout, size: 27, color: activeColor);
    } else if (type == STVideoStatus.pause) {
      _child = Icon(STIcons.status_playcircle, size: 27, color: activeColor);
    } else if (type == STVideoStatus.fail) {
      _child = Icon(STIcons.status_closecircle, size: 21, color: activeColor);
    } else {
      _child = const STLoading(
        icon: Icon(
          STIcons.status_loading,
          color: Colors.white,
          size: 26,
        ),
        alwaysLoading: true,
        text: '',
      );
    }
    return GestureDetector(
      onTap: () {
        if (type == STVideoStatus.pause && onChanged != null) {
          onChanged(STVideoStatus.play);
        } else if (type == STVideoStatus.play && onChanged != null) {
          onChanged(STVideoStatus.pause);
        }
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: bordered ? Border.all(color: activeColor) : null,
        ),
        alignment: Alignment.center,
        child: _child,
      ),
    );
  }
}
