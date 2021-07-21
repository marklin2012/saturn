import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saturn/st_button/st_button.dart';

import 'package:saturn/st_icons/st_icons.dart';
import 'package:saturn/st_video/video_fullscreen.dart';
import 'package:saturn/st_video/video_util.dart';
import 'package:saturn/st_video/video_control.dart';
import 'package:saturn/st_video/video_progress.dart';
import 'package:saturn/st_video/video_sound.dart';
import 'package:saturn/utils/debounce.dart';

import 'package:video_player/video_player.dart';

enum STVideoPlayType { asset, network }

const _defaultFix8 = 8.0;
const _defaultFix10 = 10.0;
const _defaultFix12 = 12.0;
const _defaultFix16 = 16.0;
const _defaultStatusSize = 44.0;
const _defaultLiveString = 'Live';
const _defaultTimeTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12.0,
);

class STVideoBase extends StatefulWidget {
  const STVideoBase({
    Key key,
    this.height,
    this.margin,
    this.path,
    this.isLive = false,
    this.playType = STVideoPlayType.network,
    this.doubleControlRow = false,
    this.isLooping = true,
    this.isAutoPlay = true,
  }) : super(key: key);

  final double height;
  final EdgeInsets margin;
  final String path;
  final STVideoPlayType playType;
  final bool isLive;
  final bool doubleControlRow; // 是否双行控制栏
  final bool isLooping; // 是否循环播放
  final bool isAutoPlay; // 是否自动播放

  @override
  _STVideoBaseState createState() => _STVideoBaseState();
}

class _STVideoBaseState extends State<STVideoBase> {
  double _height;
  double _width;
  double _progressWidth;
  EdgeInsets _margin;
  bool _showControl = true; // 是否显示控制层
  bool _showVolume; // 是否显示声音调整
  double _volume; // 音量

  VideoPlayerController _playerController;
  Future _initializeVideoPlayerFuture;

  ValueNotifier<STVideoStatus> _statusNotifier; //监听播放状态
  ValueNotifier<double> _progressNotifier; // 监听进度
  ValueNotifier<String> _timeNotifier; // 监听时间显示
  Duration _total = const Duration();

  bool _isOvered = false; // 是否结束

  @override
  void initState() {
    super.initState();
    _margin = widget.margin ?? const EdgeInsets.all(4.0);
    _height = widget.height;
    _showVolume = false;
    _volume = 0.5;
    _statusNotifier = ValueNotifier(STVideoStatus.loading);
    _progressNotifier = ValueNotifier(0);
    _timeNotifier = ValueNotifier('0:00/0:00');

    switch (widget.playType) {
      case STVideoPlayType.asset:
        _playerController = VideoPlayerController.asset(widget.path);
        break;
      case STVideoPlayType.network:
        _playerController = VideoPlayerController.network(widget.path);
        break;
      default:
    }
    _playerController.addListener(() {
      // 当前进度
      final _current = _playerController.value.position;
      _timeNotifier.value = getTimeString(_total, _current);
      _progressNotifier.value = getProgressValue(_total, _current);
      if (!_playerController.value.isPlaying) {
        _statusNotifier.value = STVideoStatus.pause;
      }
      _isOvered = _current == _total;
    });
    _initializeVideoPlayerFuture = _playerController.initialize();
    _playerController.setLooping(widget.isLooping);
    _initializeVideoPlayerFuture.then((_) {
      _total = _playerController.value.duration; // 总时长
      _playerController.setVolume(_volume);
      if (widget.isAutoPlay) {
        _playerController.play();
        _statusNotifier.value = STVideoStatus.play;
      } else {
        _statusNotifier.value = STVideoStatus.pause;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _playerController.dispose();
    STDebounce().cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width - _margin.left - _margin.right;
    _progressWidth = _width - _margin.left - _margin.right - 2 * _defaultFix12;
    if (!widget.doubleControlRow) {
      _progressWidth = _width -
          _margin.left -
          _margin.right -
          3 * _defaultFix12 -
          3 * _defaultFix10 -
          3 * _defaultFix16 -
          80;
    }
    _autoHide();
    return Container(
      margin: _margin,
      height: _height,
      child: Stack(
        children: [
          _getVideoWidget(),
          if (_showControl) _getStatusWidget(),
          if (_showControl) _getBottomWidget(),
        ],
      ),
    );
  }

  Widget _getVideoWidget() {
    return Hero(
      tag: STVideoConst.videoHeroTag,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _showControl = !_showControl;
          });
          if (_showControl) _autoHide();
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0x88000000),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          height: _height,
          width: _width,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) debugPrint(snapshot.error);
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _playerController.value.aspectRatio,
                  child: VideoPlayer(_playerController),
                );
              } else {
                return const Opacity(opacity: 1.0);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getStatusWidget() {
    return ValueListenableBuilder(
      valueListenable: _statusNotifier,
      builder: (context, STVideoStatus value, child) {
        return Positioned(
          left: (_width - _defaultStatusSize) / 2,
          top: (_height - _defaultStatusSize) / 2,
          child: STVideoControl(
            size: _defaultStatusSize,
            status: value,
            doubleControlRow: widget.doubleControlRow,
            onChanged: (STVideoStatus status) {
              setState(() {
                _statusNotifier.value = status;
                if (_statusNotifier.value == STVideoStatus.pause) {
                  _playerController.pause();
                } else if (_statusNotifier.value == STVideoStatus.play) {
                  if (_isOvered) {
                    _playerController.seekTo(const Duration());
                  }
                  _playerController.play();
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
    Widget _bottom;
    double _bottomHeight;
    if (!widget.doubleControlRow) {
      _bottomHeight = 102.0;
      _bottom = Container(
        height: _bottomHeight,
        padding: const EdgeInsets.only(left: _defaultFix12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _getProgressWidget(),
            Container(
              height: _defaultFix16,
              alignment: Alignment.bottomCenter,
              child: _getTimeTextWidget(),
            ),
            if (!_showVolume) _getDefaultSoundIcon(),
            if (_showVolume)
              STVideoSound(
                axis: Axis.vertical,
                value: _volume,
                iconColor: Colors.white,
                onChanged: (double value) {
                  setState(() {
                    _volume = value;
                    _playerController.setVolume(1.0 - _volume);
                  });
                  _autoHide();
                },
                showVolumed: () {
                  // 显示声音调整的组件
                  setState(() {
                    _showVolume = !_showVolume;
                  });
                  _autoHide();
                },
              ),
            _getFullScreen(),
          ],
        ),
      );
    } else {
      _bottomHeight = 44.0;
      _bottom = SizedBox(
        height: _bottomHeight,
        child: Column(
          children: [
            _getProgressWidget(),
            const SizedBox(height: _defaultFix8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _getPlayWidget(),
                    STVideoSound(
                      value: _volume,
                      iconColor: Colors.white,
                      onChanged: (double value) {
                        setState(() {
                          _volume = value;
                        });
                        _autoHide();
                      },
                      showVolumed: () {
                        // 显示声音调整的组件
                        setState(() {
                          _showVolume = !_showVolume;
                        });
                        _autoHide();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: _defaultFix16,
                      alignment: Alignment.center,
                      child: _getTimeTextWidget(),
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
        bottom: _defaultFix8,
        height: _bottomHeight,
        child: _bottom);
  }

  Widget _getPlayWidget() {
    return STButton.icon(
      icon: _getPlayIcon(),
      backgroundColor: Colors.transparent,
      size: STButtonSize.small,
      padding: const EdgeInsets.symmetric(horizontal: _defaultFix12),
      onTap: () {
        // 切换播放
        if (_statusNotifier.value == STVideoStatus.play) {
          _statusNotifier.value = STVideoStatus.pause;
          _playerController.pause();
        } else if (_statusNotifier.value == STVideoStatus.pause) {
          _statusNotifier.value = STVideoStatus.play;
          if (_isOvered) {
            _playerController.seekTo(const Duration());
          }
          _playerController.play();
        }
        _autoHide();
      },
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
              _playerController.seekTo(
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
    return STButton.icon(
      icon: getVolumeIcon(_volume, Axis.vertical, Colors.white, 16.0),
      size: STButtonSize.small,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      onTap: () {
        // 显示声音调整的组件
        setState(() {
          _showVolume = !_showVolume;
        });
        _autoHide();
      },
    );
  }

  Widget _getFullScreen() {
    return STButton.icon(
      icon: const Icon(
        STIcons.commonly_fullscreen,
        size: _defaultFix16,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: _defaultFix10),
      backgroundColor: Colors.transparent,
      onTap: () {
        // 切换全屏
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return STVideoFullScreen(
                  playerController: _playerController,
                  isLive: widget.isLive,
                  progressValue: _progressNotifier.value,
                  showChangeSound: _showVolume,
                  soundValue: _volume,
                  timeStr: _timeNotifier.value,
                  videoStatus: _statusNotifier.value,
                  showControl: _showControl,
                );
              },
            ),
          );
        });
      },
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
