import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_avatar/st_avatar_show.dart';

enum STAvatarSize {
  min,
  second,
  secondary,
  max,
}

enum STAvatarClip {
  circle,
  rect,
}

class STAvatarData {
  final IconData? iconData;
  final double? iconSize;
  final String? content;
  final ImageProvider<Object>? image;
  final Color color;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double fontSize;
  final bool isMore; // 标识组合显示时，是否超过4个 显示+

  const STAvatarData({
    this.iconData,
    this.iconSize,
    this.content,
    this.image,
    this.color = Colors.black,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.fontSize = 14.0,
    this.isMore = false,
  });
}

const _space = 8.0;
const _hoverColor = Color.fromARGB(127, 0, 0, 0);
const _hoverIcon = Icon(
  STIcons.commonly_eye_outline,
  color: Colors.white,
  size: 20,
);
const _hoverText = Text(
  '预览',
  style: TextStyle(
    fontSize: 14.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  ),
);

class STAvatar extends StatefulWidget {
  const STAvatar({
    Key? key,
    required this.datas,
    this.size = STAvatarSize.second,
    this.clip = STAvatarClip.circle,
    this.canHover = true,
    this.onChanged,
  }) : super(key: key);

  final List<STAvatarData> datas;
  final STAvatarSize size;
  final STAvatarClip clip;
  final bool canHover;
  final Function(STAvatarData)? onChanged;

  @override
  _STAvatarState createState() => _STAvatarState();
}

class _STAvatarState extends State<STAvatar> {
  bool get _isCom => widget.datas.length > 1;
  double get _height {
    switch (widget.size) {
      case STAvatarSize.min:
        return 24.0;
      case STAvatarSize.second:
        return 32.0;
      case STAvatarSize.secondary:
        return 40.0;
      case STAvatarSize.max:
        return 64.0;
    }
  }

  var _totalLength = 0;
  var _length = 0;
  var _isMore = false;
  var _moreStr = '';
  late ValueNotifier<bool> _hoverNoti;
  final _showMoreKey = GlobalKey(debugLabel: 'showMoreKey');
  late Offset _showMoreOffset;
  late OverlayState? _overlayState;
  OverlayEntry? _entry;

  @override
  void initState() {
    super.initState();
    _hoverNoti = ValueNotifier(false);
    _totalLength = widget.datas.length;
    _length = _totalLength;
    if (_length > 4) {
      _moreStr = '+${_length - 3}';
      _isMore = true;
      _length = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    _overlayState = Overlay.of(context);
    final List<Widget> _children = [];
    for (int i = 0; i < _length; i++) {
      var _data = widget.datas[i];
      if (_isMore && i == _length - 1) {
        _data = STAvatarData(
          content: _moreStr,
          backgroundColor: const Color(0xFFFFA927),
          color: Colors.white,
          borderColor: Colors.white,
          isMore: true,
        );
      }
      final _positoned = Positioned(
        left: _height * i - _space * i,
        top: 0,
        bottom: 0,
        width: _height,
        child: _buildRegion(_data),
      );
      _children.add(_positoned);
    }
    return SizedBox(
      height: _height,
      width: _height * _length - _space * (_length - 1),
      child: Stack(
        children: _children,
      ),
    );
  }

  Widget _buildRegion(STAvatarData data) {
    return STMouseRegion(
      onHover: (PointerHoverEvent hover) {
        if (_isCom) return;
        _hoverNoti.value = true;
      },
      onExit: (PointerExitEvent exit) {
        if (_isCom) return;
        _hoverNoti.value = false;
      },
      child: _buildStack(data),
    );
  }

  Widget _buildStack(STAvatarData data) {
    return ValueListenableBuilder(
      valueListenable: _hoverNoti,
      builder: (ctx, bool hover, _) {
        return Stack(
          children: [
            _buildSingle(data),
            if (hover)
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: _buildHover(data),
              ),
          ],
        );
      },
    );
  }

  Widget _buildHover(STAvatarData data) {
    return GestureDetector(
      onTap: () {
        _tapAction(data);
      },
      child: Container(
        height: _height,
        width: _height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _hoverColor,
          borderRadius: BorderRadius.circular(
            data.borderRadius ??
                (widget.clip == STAvatarClip.circle ? _height / 2 : 4.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _hoverIcon,
            if (widget.size == STAvatarSize.max)
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: _hoverText,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingle(STAvatarData data) {
    return GestureDetector(
      onTap: () {
        if (data.isMore) {
          // 显示未展示的头像
          _showMore();
        } else {
          _tapAction(data);
        }
      },
      child: Container(
        height: _height,
        width: _height,
        key: data.isMore ? _showMoreKey : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: data.backgroundColor,
          image: data.image != null
              ? DecorationImage(
                  image: data.image!,
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(
            data.borderRadius ??
                (widget.clip == STAvatarClip.circle ? _height / 2 : 4.0),
          ),
          border: Border.all(
            color: data.borderColor ?? Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (data.iconData != null)
              Center(
                child: Icon(
                  data.iconData,
                  color: data.color,
                  size: _height - 10.0,
                ),
              ),
            if (data.content != null)
              Text(
                data.content ?? '',
                style: TextStyle(
                  fontSize: data.fontSize,
                  color: data.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _tapAction(STAvatarData data) {
    STDebounce().start(
      key: 'STAvatarDebounceKey',
      func: () {
        if (widget.onChanged == null) {
          _hide();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (cnt) => STAvatarShow(data: data),
            ),
          );
        } else {
          widget.onChanged!(data);
        }
      },
      time: 100,
    );
  }

  void _showMore() {
    STDebounce().start(
      key: 'STAvatarDebounceKey',
      func: () {
        _positonShowMore();
        _realShowMore();
      },
      time: 100,
    );
  }

  void _positonShowMore() {
    final _renderObj = _showMoreKey.currentContext?.findRenderObject();
    if (_renderObj != null && _renderObj is RenderBox) {
      final _renderBox = _renderObj;
      _showMoreOffset = _renderBox.localToGlobal(Offset.zero);
    }
  }

  void _realShowMore() {
    final _entryWith =
        (_totalLength - 3) * _height + 40 + (_totalLength - 4) * 2;
    final _left = _showMoreOffset.dx - (_entryWith - _height) / 2;
    final _entryHeight = _height + 40;
    final _top = _showMoreOffset.dy - _entryHeight - 10;
    _entry = OverlayEntry(
      builder: (ctx) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                _hide();
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: _left,
              top: _top,
              child: _buildEntryConent(),
            ),
          ],
        );
      },
    );
    _overlayState?.insert(_entry!);
  }

  Widget _buildEntryConent() {
    final List<Widget> _children = [];
    for (int i = 3; i < _totalLength; i++) {
      final _data = widget.datas[i];
      final _widget = _buildRegion(_data);
      _children.add(_widget);
      if (i != _totalLength - 1) {
        _children.add(const SizedBox(width: 2.0));
      }
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: .5,
            color: Color.fromARGB(25, 0, 0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
  }
}
