import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_pagination/st_page_input.dart';

const _maxShowPage = 7;
const _normalHeight = 32.0;
const _smallHeight = 24.0;
const _rightMagin = EdgeInsets.only(right: 8.0);
const _disableBGColor = Color(0xFFF5F5F5);
const _disableSelectedBGColor = STColor.secRankGrey;
const _disbaleBorderColor = Color(0xFFD9D9D9);

// ignore: must_be_immutable
class STPaginationPage extends StatelessWidget {
  STPaginationPage({
    Key? key,
    this.current = 1,
    this.pageSize = 10,
    this.disabled = false,
    this.total = 100,
    this.type = STPaginationType.normal,
    this.turnPages,
    this.onChanged,
  }) : super(key: key);

  final int current; // 默认的当前页数
  final int pageSize; // 默认的每页条数
  final bool disabled;
  final int total; // 数据总数
  final STPaginationType type;
  final List<String>? turnPages; // 左右翻页的文字
  final Function(int current)? onChanged; // pageSize 变化的回调

  late int _current;
  late int _pageLength;
  late List<int> _showPages;

  bool get isSmall => type == STPaginationType.small;
  bool get isSimple => type == STPaginationType.simple;

  void _init() {
    final _temp = total / pageSize;
    _pageLength = _temp.ceil();
    _current = current;
    if (current > _pageLength) {
      _current = _pageLength;
    }
    if (!isSimple) _getShowPages();
  }

  @override
  Widget build(BuildContext context) {
    _init();
    if (isSimple) return _buildSimple();
    final List<Widget> _children = [];
    _children.add(_buildLeftOrRightOnePage(true));
    for (final page in _showPages) {
      if (-1 == page || 0 == page) {
        _children.add(_buildLeftOrRightMorePage(page));
      } else {
        _children.add(_buildTextPage(page));
      }
    }
    _children.add(_buildLeftOrRightOnePage(false));
    return SizedBox(
      height: isSmall ? 24.0 : 32.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
  }

  void _getShowPages() {
    _showPages = [];
    // -1 表示为左省略符
    // 0 表示右省略符
    if (_pageLength > _maxShowPage) {
      _showPages.add(1);
      if (_current - 3 > 1) {
        _showPages.add(-1);
      }
      if (_current < 4 || _current > _pageLength - 3) {
        if (_current < 4) {
          _showPages.add(2);
          _showPages.add(3);
          _showPages.add(4);
          _showPages.add(5);
        } else {
          _showPages.add(_pageLength - 4);
          _showPages.add(_pageLength - 3);
          _showPages.add(_pageLength - 2);
          _showPages.add(_pageLength - 1);
        }
      } else {
        _showPages.add(_current - 2);
        _showPages.add(_current - 1);
        _showPages.add(_current);
        _showPages.add(_current + 1);
        _showPages.add(_current + 2);
      }

      if (_current + 3 < _pageLength) {
        _showPages.add(0);
      }
      _showPages.add(_pageLength);
    } else {
      for (int i = 1; i <= _pageLength; i++) {
        _showPages.add(i);
      }
    }
  }

  void _callback() {
    if (disabled || onChanged == null) return;
    onChanged!(_current);
  }

  Widget _buildLeftOrRightOnePage(bool isLeft) {
    bool _btnDisabled = false;
    if (isLeft && _current == 1) {
      _btnDisabled = true;
    } else if (!isLeft && _current == _pageLength) {
      _btnDisabled = true;
    }
    var _iconData = STIcons.direction_rightoutlined;
    if (isLeft) {
      _iconData = STIcons.direction_leftoutlined;
    }

    bool _isShowText = false;
    if (turnPages != null && turnPages!.length == 2) {
      _isShowText = true;
    }
    var _margin = _rightMagin;
    var _padding = const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0);
    var _decoration = BoxDecoration(
      color: disabled ? _disableBGColor : Colors.white,
      borderRadius: BorderRadius.circular(2.0),
      border: Border.all(
        color: disabled ? _disbaleBorderColor : STColor.thrRankGrey,
      ),
    );
    var _width = _normalHeight;
    if (isSmall) {
      _margin = EdgeInsets.zero;
      _padding = const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0);
      _decoration = const BoxDecoration();
      _width = _smallHeight;
    } else if (isSimple) {
      _decoration = const BoxDecoration();
    }
    return STMouseRegion(
      child: GestureDetector(
        onTap: () {
          if (_btnDisabled) return;
          if (isLeft) {
            if (_current - 1 > 1) {
              _current -= 1;
            } else {
              _current = 1;
            }
          } else {
            if (_current + 1 < _pageLength) {
              _current += 1;
            } else {
              _current = _pageLength;
            }
          }
          _callback();
        },
        child: Container(
          margin: _margin,
          padding: _isShowText ? _padding : null,
          decoration: _decoration,
          alignment: _isShowText ? null : Alignment.center,
          width: _isShowText ? null : _width,
          child: _isShowText
              ? Text(
                  isLeft ? turnPages!.first : turnPages!.last,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: disabled
                        ? STColor.fourRankFont
                        : _btnDisabled
                            ? STColor.thrRankGrey
                            : Colors.black,
                  ),
                )
              : Icon(
                  _iconData,
                  size: 14,
                  color: disabled
                      ? STColor.fourRankFont
                      : _btnDisabled
                          ? STColor.thrRankGrey
                          : Colors.black,
                ),
        ),
      ),
    );
  }

  Widget _buildLeftOrRightMorePage(int flag) {
    var _margin = _rightMagin;
    var _color = Colors.white;
    var _width = _normalHeight;
    if (isSmall) {
      _margin = EdgeInsets.zero;
      _color = Colors.transparent;
      _width = _smallHeight;
    }

    /// flage -1 向左跳5
    /// 0 向右跳5
    return STMouseRegion(
      child: GestureDetector(
        onTap: () {
          if (flag == -1) {
            if (_current - 5 > 1) {
              _current -= 5;
            } else {
              _current = 1;
            }
          } else {
            if (_current + 5 < _pageLength) {
              _current += 5;
            } else {
              _current = _pageLength;
            }
          }
          _callback();
        },
        child: Container(
          margin: _margin,
          color: disabled ? STColor.fourRankGrey : _color,
          alignment: Alignment.center,
          width: _width,
          child: const Icon(
            STIcons.commonly_pointmenu_outline,
            size: 14,
            color: STColor.secRankGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildTextPage(int page) {
    final _selected = page == _current;

    var _margin = _rightMagin;
    var _decoration = BoxDecoration(
      color: disabled
          ? _selected
              ? _disableSelectedBGColor
              : _disableBGColor
          : Colors.white,
      borderRadius: BorderRadius.circular(2.0),
      border: Border.all(
        color: disabled
            ? _selected
                ? _disableSelectedBGColor
                : _disbaleBorderColor
            : _selected
                ? STColor.firRankBlue
                : STColor.thrRankGrey,
      ),
    );
    var _width = _normalHeight;
    if (isSmall) {
      _margin = EdgeInsets.zero;
      _decoration = BoxDecoration(
        color: disabled
            ? _selected
                ? _disableBGColor
                : Colors.transparent
            : _selected
                ? Colors.white
                : Colors.transparent,
        borderRadius: _selected ? BorderRadius.circular(2.0) : null,
        border: _selected
            ? Border.all(
                color: disabled ? _disbaleBorderColor : STColor.firRankBlue,
              )
            : null,
      );
      _width = _smallHeight;
    }

    return STMouseRegion(
      child: GestureDetector(
        onTap: () {
          _current = page;
          _callback();
        },
        child: Container(
          margin: _margin,
          decoration: _decoration,
          alignment: Alignment.center,
          width: _width,
          child: Text(
            page.toString(),
            style: TextStyle(
              color: disabled
                  ? _selected
                      ? Colors.white
                      : STColor.fourRankFont
                  : _selected
                      ? STColor.firRankBlue
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSimple() {
    final List<Widget> _children = [];
    _children.add(_buildLeftOrRightOnePage(true));
    _children.add(_buildSimpleInput());
    _children.add(
      Text(
        ' / $_pageLength',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
    _children.add(_buildLeftOrRightOnePage(false));
    return SizedBox(
      height: 32.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
  }

  Widget _buildSimpleInput() {
    return STpageInput(
      width: 42,
      disabled: disabled,
      page: _current.toString(),
      onChanged: (String page) {
        if (int.tryParse(page) == null) return;
        final _tempPage = int.tryParse(page)!;
        _current = _tempPage;
        _callback();
      },
    );
  }
}
