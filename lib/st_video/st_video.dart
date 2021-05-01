import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_video/video_common.dart';
import 'package:saturn/st_video/video_control.dart';
import 'package:saturn/st_video/video_progress.dart';
import 'package:saturn/st_video/video_sound.dart';

enum STVideoRowType { single, two }

const _defaultHeight = 240.0;
const _defaultSingleBottomH = 18.0;
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
      _bottomHeight = 120.0;
      _bottom = Container(
        margin: _margin,
        padding: const EdgeInsets.only(left: 12.0, right: 14.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // 切换播放
              },
              child: _status == STVideoStatus.play
                  ? const Icon(
                      STIcons.direction_swapu_d,
                      size: _defaultSingleBottomH,
                      color: Colors.white,
                    )
                  : const Icon(
                      STIcons.direction_caretright,
                      size: _defaultSingleBottomH,
                      color: Colors.white,
                    ),
            ),
            STVideoProgress(
              height: _defaultSingleBottomH,
              value: _progressValue,
              onChanged: (double value) {
                setState(() {
                  _progressValue = value;
                });
              },
            ),
            Container(
              height: _defaultSingleBottomH,
              alignment: Alignment.center,
              child: Text(_timeStr, style: _defaultTimeTextStyle),
            ),
            if (!_showChangeSound)
              GestureDetector(
                onTap: () {
                  // 显示声音调整的组件
                  setState(() {
                    _showChangeSound = !_showChangeSound;
                  });
                },
                child: VideoCommon()
                    .getSoundIcon(_soundValue, Axis.vertical, Colors.white),
              ),
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
            GestureDetector(
              onTap: () {
                // 切换全屏
              },
              child: const Icon(
                STIcons.commonly_fullscreen,
                size: _defaultSingleBottomH,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      _bottomHeight = 56.0;
      _bottom = Container(
        margin: _margin,
        height: _bottomHeight,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            STVideoProgress(
              width: _width - 24.0 - _margin.left - _margin.right,
              height: _defaultSingleBottomH,
              value: _progressValue,
              onChanged: (double value) {
                setState(() {
                  _progressValue = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 切换播放
                      },
                      child: _status == STVideoStatus.play
                          ? const Icon(
                              STIcons.direction_swapu_d,
                              size: _defaultSingleBottomH,
                              color: Colors.white,
                            )
                          : const Icon(
                              STIcons.direction_caretright,
                              size: _defaultSingleBottomH,
                              color: Colors.white,
                            ),
                    ),
                    const SizedBox(width: 10.5),
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
                      height: _defaultSingleBottomH,
                      alignment: Alignment.center,
                      child: Text(_timeStr, style: _defaultTimeTextStyle),
                    ),
                    const SizedBox(width: 10.5),
                    GestureDetector(
                      onTap: () {
                        // 切换全屏
                      },
                      child: const Icon(
                        STIcons.commonly_fullscreen,
                        size: _defaultSingleBottomH,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Positioned(
        left: 0, right: 0, bottom: 10.0, height: _bottomHeight, child: _bottom);
  }
}
