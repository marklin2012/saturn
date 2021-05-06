import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_video/video_common.dart';
import 'package:saturn/st_video/video_control.dart';
import 'package:saturn/st_video/video_progress.dart';
import 'package:saturn/st_video/video_sound.dart';

enum STVideoRowType { single, two }

const _defaultHeight = 240.0;
const _defaultFix10 = 10.0;
const _defaultFix12 = 12.0;
const _defaultFix16 = 16.0;
const _defaultTimeTextStyle = TextStyle(color: Colors.white, fontSize: 12.0);

class STVideo extends StatefulWidget {
  const STVideo({
    Key key,
    this.height,
    this.margin,
    this.path,
    this.type,
  }) : super(key: key);
  final double height;
  final EdgeInsets margin;
  final String path;
  final STVideoRowType type;

  @override
  _STVideoState createState() => _STVideoState();
}

class _STVideoState extends State<STVideo> {
  double _height;
  double _width;
  double _progressWidth;
  EdgeInsets _margin;
  STVideoRowType _type;
  STVideoStatus _status;
  bool _showChangeSound;
  double _progressValue;
  double _soundValue;
  String _timeStr;

  @override
  void initState() {
    super.initState();
    _margin = widget.margin ?? const EdgeInsets.all(5);
    _height = widget.height ?? _defaultHeight;
    _type = widget.type ?? STVideoRowType.single;
    _status = STVideoStatus.loading;
    _timeStr = '0:00/0:46';
    _showChangeSound = false;
    _progressValue = 0;
    _soundValue = 0.5;
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width - _margin.left - _margin.right;
    _progressWidth = _width - _margin.left - _margin.right - 2 * _defaultFix12;
    if (_type == STVideoRowType.single) {
      _progressWidth = _width -
          _margin.left -
          _margin.right -
          3 * _defaultFix12 -
          3 * _defaultFix10 -
          3 * _defaultFix16 -
          60;
    }
    return Container(
      margin: _margin,
      height: _height,
      child: Stack(
        children: [
          _getVideoWidget(),
          _getStatusWidget(),
          _getBottomWidget(),
        ],
      ),
    );
  }

  Widget _getVideoWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x88000000),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      height: _height,
      width: _width,
    );
  }

  Widget _getStatusWidget() {
    const _size = Size(80, 60);
    return Positioned(
      left: (_width - _size.width) / 2,
      top: (_height - _size.height) / 2,
      child: STVideoControl(
        type: _status,
        bordered: true,
        backgroundColor: const Color(0x88000000),
        onChanged: (STVideoStatus value) {
          setState(() {
            _status = value;
          });
        },
      ),
    );
  }

  Widget _getBottomWidget() {
    Widget _bottom;
    double _bottomHeight;
    if (_type == STVideoRowType.single) {
      _bottomHeight = 114.0;
      _bottom = Container(
        margin: _margin,
        padding:
            const EdgeInsets.only(left: _defaultFix12, right: _defaultFix10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _getPlayWidget(),
            STVideoProgress(
              height: _defaultFix16,
              width: _progressWidth,
              value: _progressValue,
              onChanged: (double value) {
                setState(() {
                  _progressValue = value;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: _defaultFix12, right: _defaultFix10),
              height: _defaultFix16,
              alignment: Alignment.bottomCenter,
              child: Text(_timeStr, style: _defaultTimeTextStyle),
            ),
            if (!_showChangeSound) _getDefaultSoundIcon(),
            if (_showChangeSound)
              GestureDetector(
                onTap: () {
                  // 显示声音调整的组件
                  setState(() {
                    _showChangeSound = !_showChangeSound;
                  });
                },
                child: STVideoSound(
                  axis: Axis.vertical,
                  value: _soundValue,
                  iconColor: Colors.white,
                  onChanged: (double value) {
                    setState(() {
                      _soundValue = value;
                    });
                  },
                ),
              ),
            _getFullScreen(),
          ],
        ),
      );
    } else {
      _bottomHeight = 56.0;
      _bottom = Container(
        margin: _margin,
        height: _bottomHeight,
        padding: const EdgeInsets.symmetric(horizontal: _defaultFix12),
        child: Column(
          children: [
            STVideoProgress(
              width: _progressWidth,
              height: _defaultFix16,
              value: _progressValue,
              onChanged: (double value) {
                setState(() {
                  _progressValue = value;
                });
              },
            ),
            const SizedBox(height: _defaultFix10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _getPlayWidget(),
                    GestureDetector(
                      onTap: () {
                        // 显示声音调整的组件
                        setState(() {
                          _showChangeSound = !_showChangeSound;
                        });
                      },
                      child: STVideoSound(
                        value: _soundValue,
                        iconColor: Colors.white,
                        onChanged: (double value) {
                          setState(() {
                            _soundValue = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: _defaultFix16,
                      alignment: Alignment.center,
                      child: Text(_timeStr, style: _defaultTimeTextStyle),
                    ),
                    _getFullScreen(),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Positioned(
        left: 0,
        right: 0,
        bottom: _defaultFix10,
        height: _bottomHeight,
        child: _bottom);
  }

  Widget _getPlayWidget() {
    return GestureDetector(
      onTap: () {
        // 切换播放
        if (_status == STVideoStatus.play) {
          _status = STVideoStatus.pause;
          setState(() {});
        } else if (_status == STVideoStatus.pause) {
          _status = STVideoStatus.play;
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.only(right: _defaultFix10),
        height: _defaultFix16,
        child: _getPlayIcon(),
      ),
    );
  }

  Widget _getPlayIcon() {
    if (_status == STVideoStatus.play) {
      return const Icon(
        STIcons.direction_swapu_d,
        size: _defaultFix16,
        color: Colors.white,
      );
    } else {
      return const Icon(
        STIcons.direction_caretright,
        size: _defaultFix16,
        color: Colors.white,
      );
    }
  }

  Widget _getDefaultSoundIcon() {
    return GestureDetector(
      onTap: () {
        // 显示声音调整的组件
        setState(() {
          _showChangeSound = !_showChangeSound;
        });
      },
      child: VideoCommon()
          .getSoundIcon(_soundValue, Axis.vertical, Colors.white, 16.0),
    );
  }

  Widget _getFullScreen() {
    return GestureDetector(
      onTap: () {
        // 切换全屏
      },
      child: Container(
        padding: const EdgeInsets.only(left: _defaultFix10),
        child: const Icon(
          STIcons.commonly_fullscreen,
          size: _defaultFix16,
          color: Colors.white,
        ),
      ),
    );
  }
}
