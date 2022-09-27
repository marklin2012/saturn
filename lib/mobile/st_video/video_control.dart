import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/st_button.dart';

import 'package:saturn/mobile/st_icons/st_icons.dart';
import 'package:saturn/mobile/st_loading/st_loading.dart';

enum STVideoStatus { play, pause, fail, loading }

const _defaultSize = 36.0;
const _defaultFailSize = 30.0;

class STVideoControl extends StatelessWidget {
  const STVideoControl(
      {Key? key,
      this.status = STVideoStatus.loading,
      this.size = 40.0,
      this.doubleControlRow = false,
      this.activeColor = Colors.white,
      this.onChanged,})
      : super(key: key);

  final STVideoStatus status; //状态
  final double size;
  final Color activeColor; //边框和图片颜色
  final bool doubleControlRow; // 是否双行
  final ValueChanged<STVideoStatus>? onChanged; // 状态改变

  @override
  Widget build(BuildContext context) {
    Widget _child;
    EdgeInsets _padding = EdgeInsets.all(size - _defaultSize);
    if (status == STVideoStatus.play && !doubleControlRow) {
      _child = Icon(STIcons.commonly_pause_outline,
          size: _defaultSize, color: activeColor,);
    } else if (status == STVideoStatus.pause && !doubleControlRow) {
      _child = Icon(STIcons.commonly_play_outline,
          size: _defaultSize, color: activeColor,);
    } else if (status == STVideoStatus.loading && !doubleControlRow) {
      _child = const STLoading(
        icon: Icon(
          STIcons.status_loading,
          color: Colors.white,
          size: _defaultSize,
        ),
        alwaysLoading: true,
        text: '',
      );
    } else if (status == STVideoStatus.fail) {
      _child = Icon(STIcons.status_closecircle,
          size: _defaultFailSize, color: activeColor,);
      _padding = EdgeInsets.all(size - _defaultFailSize);
    } else {
      _child = const Opacity(opacity: 1.0);
    }
    return STButton.icon(
      icon: _child,
      backgroundColor: Colors.transparent,
      padding: _padding,
      onTap: () {
        if (status == STVideoStatus.pause && onChanged != null) {
          onChanged!(STVideoStatus.play);
        } else if (status == STVideoStatus.play && onChanged != null) {
          onChanged!(STVideoStatus.pause);
        }
      },
    );
  }
}
