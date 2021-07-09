import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:saturn/st_icons/st_icons.dart';
import 'package:saturn/st_video/video_control.dart';
import 'package:saturn/st_video/video_progress.dart';
import 'package:saturn/st_video/video_sound.dart';
import 'package:saturn/st_video/video_util.dart';
import 'package:saturn/utils/debounce.dart';

import 'package:video_player/video_player.dart';

const _defaultFix10 = 10.0;
const _defaultFix12 = 12.0;
const _defaultFix16 = 16.0;
const _defaultStatusSize = 40.0;
const _defaultTimeTextStyle = TextStyle(
    color: Colors.white, fontSize: 12.0, decoration: TextDecoration.none);
const _defaultLiveString = 'Live';

class STVideoFullScreen extends StatefulWidget {
  const STVideoFullScreen({
    Key key,
    @required this.playerController,
    @required this.isLive,
    @required this.soundValue,
    @required this.videoStatus,
    @required this.progressValue,
    @required this.timeStr,
    @required this.showChangeSound,
    @required this.showControl,
  }) : super(key: key);

  final VideoPlayerController playerController;
  final bool isLive;
  final STVideoStatus videoStatus;
  final double soundValue;
  final double progressValue;
  final String timeStr;
  final bool showChangeSound; // 是否显示声音调整
  final bool showControl; // 是否显示控制层

  @override
  _STVideoFullScreenState createState() => _STVideoFullScreenState();
}

class _STVideoFullScreenState extends State<STVideoFullScreen> {
  ValueNotifier<STVideoStatus> _statusNotifier; //监听播放状态
  ValueNotifier<double> _progressNotifier; // 监听进度
  ValueNotifier<String> _timeNotifier; // 监听时间显示
  Duration _total = const Duration();
  bool _showChangeSound; // 是否显示声音调整
  double _soundValue;
  double _safeWidth;
  double _safeHeight;
  bool _showControl; // 是否显示控制层

  bool _isOvered = false; // 是否结束

  @override
  void initState() {
    super.initState();

    _total = widget.playerController.value.duration; // 总时长
    _showChangeSound = widget.showChangeSound;
    _soundValue = widget.soundValue;
    _showControl = widget.showControl;

    final _status = widget.videoStatus;
    _statusNotifier = ValueNotifier(_status);
    final _progress = widget.progressValue;
    _progressNotifier = ValueNotifier(_progress);
    final _timeStr = widget.timeStr;
    _timeNotifier = ValueNotifier(_timeStr);

    widget.playerController.addListener(() {
      final _current = widget.playerController.value.position; // 当前进度
      _timeNotifier.value = getTimeString(_total, _current);
      _progressNotifier.value = getProgressValue(_total, _current);
      _isOvered = _current == _total;
      if (!widget.playerController.value.isPlaying) {
        _statusNotifier.value = STVideoStatus.pause;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    _safeWidth = mq.size.width - mq.padding.left - mq.padding.right;
    _safeHeight = mq.size.height - mq.padding.top - mq.padding.bottom;

    _autoHide();
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _showControl = !_showControl;
                  setState(() {});
                  if (_showControl) _autoHide();
                },
                child: Hero(
                  tag: STVideoConst.videoHeroTag,
                  child: AspectRatio(
                      aspectRatio: widget.playerController.value.aspectRatio,
                      child: VideoPlayer(widget.playerController)),
                ),
              ),
            ),
            if (_showControl) _getStatusWidget(),
            if (_showControl) _getBottomWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getStatusWidget() {
    return ValueListenableBuilder(
      valueListenable: _statusNotifier,
      builder: (context, STVideoStatus value, child) {
        return Positioned(
          left: (_safeWidth - _defaultStatusSize) / 2,
          top: (_safeHeight - _defaultStatusSize) / 2,
          child: STVideoControl(
            status: value,
            onChanged: (STVideoStatus status) {
              setState(() {
                _statusNotifier.value = status;
                if (_statusNotifier.value == STVideoStatus.pause) {
                  widget.playerController.pause();
                } else if (_statusNotifier.value == STVideoStatus.play) {
                  if (_isOvered) {
                    widget.playerController.seekTo(const Duration());
                  }
                  widget.playerController.play();
                }
              });
              _autoHide();
            },
          ),
        );
      },
    );
  }

  Widget _getBottomWidget() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: _defaultFix10,
      height: 114.0,
      child: Container(
        padding:
            const EdgeInsets.only(left: _defaultFix12, right: _defaultFix10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // _getPlayWidget(),
            _getProgressWidget(),
            Container(
              padding: const EdgeInsets.only(
                  left: _defaultFix12, right: _defaultFix10),
              height: _defaultFix16,
              alignment: Alignment.bottomCenter,
              child: _getTimeTextWidget(),
            ),
            if (!_showChangeSound) _getDefaultSoundIcon(),
            if (_showChangeSound)
              GestureDetector(
                onTap: () {
                  // 显示声音调整的组件
                  setState(() {
                    _showChangeSound = !_showChangeSound;
                  });
                  _autoHide();
                },
                child: STVideoSound(
                  axis: Axis.vertical,
                  value: _soundValue,
                  iconColor: Colors.white,
                  onChanged: (double value) {
                    setState(() {
                      _soundValue = value;
                      widget.playerController.setVolume(1.0 - _soundValue);
                    });
                    _autoHide();
                  },
                ),
              ),
            _getFullScreen(),
          ],
        ),
      ),
    );
  }

  Widget _getPlayWidget() {
    return GestureDetector(
      onTap: () {
        // 切换播放
        if (_statusNotifier.value == STVideoStatus.play) {
          _statusNotifier.value = STVideoStatus.pause;
          widget.playerController.pause();
        } else if (_statusNotifier.value == STVideoStatus.pause) {
          _statusNotifier.value = STVideoStatus.play;
          if (_isOvered) {
            widget.playerController.seekTo(const Duration());
          }
          widget.playerController.play();
        }
        _autoHide();
      },
      child: Container(
        padding: const EdgeInsets.only(right: _defaultFix10),
        height: _defaultFix16,
        child: _getPlayIcon(),
      ),
    );
  }

  Widget _getPlayIcon() {
    return ValueListenableBuilder(
      valueListenable: _statusNotifier,
      builder: (context, STVideoStatus value, child) {
        if (value == STVideoStatus.play) {
          return const Icon(
            STIcons.commonly_timeout,
            size: _defaultFix16,
            color: Colors.white,
          );
        } else {
          return const Icon(
            STIcons.commonly_begin,
            size: _defaultFix16,
            color: Colors.white,
          );
        }
      },
    );
  }

  Widget _getProgressWidget() {
    final _progressWidth = _safeWidth -
        3 * _defaultFix12 -
        3 * _defaultFix10 -
        3 * _defaultFix16 -
        85;
    return ValueListenableBuilder(
      valueListenable: _progressNotifier,
      builder: (context, double value, child) {
        return STVideoProgress(
          height: _defaultFix16,
          width: _progressWidth,
          value: value,
          onChanged: (double changeValue) {
            setState(() {
              _progressNotifier.value = changeValue;
              widget.playerController.seekTo(
                  Duration(seconds: (changeValue * _total.inSeconds).toInt()));
            });
            _autoHide();
          },
        );
      },
    );
  }

  Widget _getTimeTextWidget() {
    if (widget.isLive) {
      return Row(
        children: [
          Container(
            width: 6,
            height: 6,
            padding: const EdgeInsets.only(right: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          const Text(_defaultLiveString, style: _defaultTimeTextStyle),
        ],
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: _timeNotifier,
        builder: (context, String value, child) {
          return Text(value, style: _defaultTimeTextStyle);
        },
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
        _autoHide();
      },
      child: getVolumeIcon(_soundValue, Axis.vertical, Colors.white, 16.0),
    );
  }

  Widget _getFullScreen() {
    return GestureDetector(
      onTap: () {
        // 退出全屏
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: _defaultFix10),
        child: const Icon(
          STIcons.commonly_exitfullscreen,
          size: _defaultFix16,
          color: Colors.white,
        ),
      ),
    );
  }

  // 自动隐藏
  void _autoHide() {
    STDebounce().debounce(() {
      if (_showControl) {
        _showControl = false;
        setState(() {});
      }
    });
  }
}
