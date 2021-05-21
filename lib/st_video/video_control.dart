import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:saturn/st_icons/st_icons.dart';
import 'package:saturn/st_loading/st_loading.dart';

enum STVideoStatus { play, pause, fail, loading }

class STVideoControl extends StatelessWidget {
  const STVideoControl(
      {Key key,
      this.status = STVideoStatus.loading,
      this.size = 40.0,
      this.doubleControlRow = false,
      this.activeColor = Colors.white,
      this.onChanged})
      : super(key: key);

  final STVideoStatus status; //状态
  final double size;
  final Color activeColor; //边框和图片颜色
  final bool doubleControlRow; // 是否双行
  final ValueChanged<STVideoStatus> onChanged; // 状态改变

  @override
  Widget build(BuildContext context) {
    Widget _child;
    if (status == STVideoStatus.play && !doubleControlRow) {
      _child = Icon(STIcons.commonly_timeout, size: 36, color: activeColor);
    } else if (status == STVideoStatus.pause && !doubleControlRow) {
      _child = Icon(STIcons.commonly_begin, size: 36, color: activeColor);
    } else if (status == STVideoStatus.loading && !doubleControlRow) {
      _child = const STLoading(
        icon: Icon(
          STIcons.status_loading,
          color: Colors.white,
          size: 36,
        ),
        alwaysLoading: true,
        text: '',
      );
    } else if (status == STVideoStatus.fail) {
      _child = Icon(STIcons.status_closecircle, size: 30, color: activeColor);
    } else {
      _child = const Opacity(opacity: 1.0);
    }
    return GestureDetector(
      onTap: () {
        if (status == STVideoStatus.pause && onChanged != null) {
          onChanged(STVideoStatus.play);
        } else if (status == STVideoStatus.play && onChanged != null) {
          onChanged(STVideoStatus.pause);
        }
      },
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        child: _child,
      ),
    );
  }
}
