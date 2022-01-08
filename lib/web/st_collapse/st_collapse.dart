import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

enum STCollapseType {
  accordion,
  simple,
  ghost,
  normal,
}

class STCollapse extends StatefulWidget {
  const STCollapse({
    Key? key,
    this.type = STCollapseType.normal,
    this.activeFold,
    this.disabled = false,
    required this.items,
    // this.onChanged,
  }) : super(key: key);

  final STCollapseType type; // 模式
  final List<bool>? activeFold; // 初始折叠面板集
  final bool disabled;
  final List<STCollapseData> items; // 面板内容集
  // final Function(List<bool>)? onChanged;

  @override
  _STCollapseState createState() => _STCollapseState();
}

class _STCollapseState extends State<STCollapse> {
  late List<bool> _activeFold;

  bool get _isGhost => widget.type == STCollapseType.ghost;
  bool get _isSimple => widget.type == STCollapseType.simple;

  @override
  void initState() {
    super.initState();
    _activeFold = widget.activeFold ?? [];
    for (final _ in widget.items) {
      _activeFold.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [];
    for (int i = 0; i < widget.items.length; i++) {
      final _isFold = _activeFold[i];
      final _data = widget.items[i];
      var _bottomSide = _data.borderBottomSide;
      var _isLastItem = false;
      if (i == widget.items.length - 1) {
        _isLastItem = true;
      }
      if (_isGhost || (_isLastItem && _isFold)) {
        _bottomSide = false;
      }
      final _panel = STCollapsePanel(
        header: _data.header,
        borderBottomSide: _bottomSide,
        disabled: _data.disabled,
        isFold: _isFold,
        showArrow: _data.showArrow,
      );
      _children.add(
        GestureDetector(
          onTap: () {
            if (_data.disabled) return;
            _tapAction(i);
          },
          child: _panel,
        ),
      );
      if (!_isFold && _data.content != null) {
        var _padding = const EdgeInsets.all(16.0);
        var _color = Colors.white;
        var _border =
            const Border(bottom: BorderSide(color: STColor.thrRankGrey));
        if (_isGhost) {
          _padding = const EdgeInsets.fromLTRB(16, 0, 16, 16);
          _color = STColor.backgroundColor;
          _border = const Border();
        } else if (_isSimple) {
          _padding = const EdgeInsets.fromLTRB(16, 0, 16, 16);
          _color = STColor.backgroundColor;
        } else if (_isLastItem) {
          _border = const Border();
        }
        final _content = Container(
          padding: _padding,
          decoration: BoxDecoration(
            color: _color,
            border: _border,
          ),
          child: Text(
            _data.content!,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: STColor.secRankFont,
            ),
          ),
        );
        _children.add(_content);
      } else if (!_isFold && _data.datas != null) {
        final _accordion = Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: STCollapse(items: _data.datas!),
        );
        _children.add(_accordion);
      }
    }
    var _showBorder = true;
    if (_isGhost || _isSimple) {
      _showBorder = false;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: _showBorder
            ? Border.all(color: STColor.thrRankGrey)
            : const Border(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
  }

  void _tapAction(int index) {
    STDebounce().start(
      key: 'STCollapsePanelDebounceKey',
      func: () {
        final _isFlod = _activeFold[index];
        if (widget.type == STCollapseType.accordion) {
          for (int i = 0; i < _activeFold.length; i++) {
            if (index != i) {
              _activeFold[i] = true;
            } else {
              _activeFold[i] = !_isFlod;
            }
          }
        } else {
          _activeFold[index] = !_isFlod;
        }
        setState(() {});
      },
      time: 100,
    );
  }
}

class STCollapseData {
  final bool borderBottomSide; // 是否有底部下划线
  final bool disabled; // 是否可用
  final String header; // 面板内容
  final String? content; // 折叠内容
  final bool isFold; // 是否折叠
  final bool showArrow; // 是否显示箭头
  final List<STCollapseData>? datas; // 嵌套数据

  const STCollapseData({
    this.borderBottomSide = true,
    this.disabled = false,
    required this.header,
    this.content,
    this.isFold = true,
    this.showArrow = true,
    this.datas,
  });
}

const _disableColor = STColor.fourRankFont;

class STCollapsePanel extends StatelessWidget {
  const STCollapsePanel({
    Key? key,
    this.height = 46.0,
    this.backgroundColor = STColor.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.headerColor = STColor.firRankFont,
    this.borderBottomSide = true,
    this.disabled = false,
    required this.header,
    this.isFold = true,
    this.showArrow = true,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final EdgeInsets padding;
  final Color headerColor;
  final bool borderBottomSide; // 是否有底部下划线
  final bool disabled; // 是否可用
  final String header; // 面板内容
  final bool isFold; // 是否折叠
  final bool showArrow; // 是否显示箭头

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: borderBottomSide
              ? const BorderSide(color: STColor.thrRankGrey)
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          if (showArrow) _buildArrow(),
          Expanded(
            child: Text(
              header,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: disabled ? _disableColor : headerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    final _color = disabled ? _disableColor : headerColor;
    Widget _icon;
    if (isFold) {
      _icon = Icon(
        STIcons.direction_rightoutlined,
        size: 14,
        color: _color,
      );
    } else {
      _icon = Icon(
        STIcons.direction_downoutlined,
        size: 14,
        color: _color,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: _icon,
    );
  }
}
