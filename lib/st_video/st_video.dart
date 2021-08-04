import 'package:flutter/material.dart';
import 'package:saturn/st_video/video_basic.dart';

const _defaultHeight = 240.0;

class STVideo extends StatelessWidget {
  final double height;
  final EdgeInsets margin;
  final String path;
  final String url;
  final STVideoPlayType playType; // 播放类型
  final bool isLive; // 是否直播
  final bool doubleControlRow; // 是否双行控制栏
  final bool isLooping; // 是否循环播放
  final bool isAutoPlay; // 是否自动播放
  final bool isShowControl; // 是否显示控制层

  const STVideo({
    Key key,
    this.height = _defaultHeight,
    this.margin,
    this.path,
    this.url,
    this.playType,
    this.isLive = false,
    this.doubleControlRow = false,
    this.isLooping = true,
    this.isAutoPlay = true,
    this.isShowControl = true,
  }) : super(key: key);

  const STVideo.asset({
    Key key,
    this.height = _defaultHeight,
    this.margin,
    @required this.path,
    this.playType = STVideoPlayType.asset,
    this.isLive = false,
    this.doubleControlRow = false,
    this.url,
    this.isLooping = true,
    this.isAutoPlay = true,
    this.isShowControl = true,
  }) : super(key: key);

  const STVideo.network({
    Key key,
    this.height = _defaultHeight,
    this.margin,
    this.path,
    this.playType = STVideoPlayType.network,
    this.isLive = false,
    this.doubleControlRow = false,
    this.isLooping = true,
    this.isAutoPlay = true,
    this.isShowControl = true,
    @required this.url,
  }) : super(key: key);

  const STVideo.live({
    Key key,
    this.height = _defaultHeight,
    this.margin,
    this.path,
    this.playType = STVideoPlayType.network,
    this.isLive = true,
    this.doubleControlRow = false,
    this.isLooping = true,
    this.isAutoPlay = true,
    this.isShowControl = true,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return STVideoBase(
      key: key,
      height: height,
      margin: margin,
      path: playType == STVideoPlayType.asset ? path : url,
      playType: playType,
      isLive: isLive,
      doubleControlRow: doubleControlRow,
      isAutoPlay: isAutoPlay,
      isLooping: isLooping,
      isShowControl: isShowControl,
    );
  }
}
