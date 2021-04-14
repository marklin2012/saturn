import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_show_dialog.dart';
import 'package:saturn/st_select/st_select.dart';

class STSelectTexts extends StatefulWidget {
  final Widget child;
  final String title;
  final STSelectTextsData initialValue;
  final List<STSelectTextsData> list;
  final Function(STSelectTextsData value) onSelected;

  const STSelectTexts({
    Key key,
    this.child,
    this.title,
    this.initialValue,
    this.list,
    this.onSelected,
  }) : super(key: key);

  @override
  _STSelectTextsState createState() => _STSelectTextsState();
}

class _STSelectTextsState extends State<STSelectTexts> {
  static const _selectTextsHeight = 302.0;
  static const _selectTitleHeight = 48.0;
  static const _selectTextStyle =
      TextStyle(color: Color(0xFF000000), fontSize: 16);
  static const _textStyle = TextStyle(color: Color(0xFF555555), fontSize: 16);

  STSelectTextsData _selectedValues;
  STSelectTextsData _tempValues;
  double _width;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _tempValues ??= widget.initialValue;
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierColor: Colors.transparent,
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ShowSelectDialog(
              menu: _getShowMenu(context),
              offset: Offset(0, _height - _selectTextsHeight),
              height: _selectTextsHeight,
            );
          },
        );
      },
      child: widget.child,
    );
  }

  Widget _getShowMenu(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Column(
        children: [
          _getTitleChild(context),
          Row(
            children: [
              _getListView(1),
              _getListView(2),
              _getListView(3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getListView(int number) {
    final _titles = <String>[];
    String _initialTitle;
    if (number == 1) {
      _initialTitle = _tempValues.firTitle;
    } else if (number == 2) {
      _initialTitle = _tempValues.secTitle;
    } else {
      _initialTitle = _tempValues.thrTitle;
    }
    for (final item in widget.list) {
      if (number == 1) {
        _titles.add(item.firTitle);
      } else if (number == 2) {
        _titles.add(item.secTitle);
      } else {
        _titles.add(item.thrTitle);
      }
    }
    if (_titles.isEmpty) return null;
    return Container(
      height: _selectTextsHeight - _selectTitleHeight,
      width: _width / 3,
      padding: const EdgeInsets.all(0),
      color: Colors.green,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: _titles.length,
        itemBuilder: (context, index) {
          final _isSelected = _titles[index] == _initialTitle;
          return GestureDetector(
            onTap: () {
              _onTapAction(number, index);
            },
            child: Container(
              height: 44,
              alignment: Alignment.center,
              color: _isSelected
                  ? const Color(0xFFEFF3F9)
                  : const Color(0xFFFAFCFF),
              child: Text(_titles[index],
                  style: _isSelected ? _selectTextStyle : _textStyle),
            ),
          );
        },
      ),
    );
  }

  void _onTapAction(int number, int index) {
    if (widget.list.length <= index) return;
    if (number == 1) {
      _tempValues.firTitle = widget.list[index].firTitle;
    } else if (number == 2) {
      _tempValues.secTitle = widget.list[index].secTitle;
    } else {
      _tempValues.thrTitle = widget.list[index].thrTitle;
    }
  }

  Widget _getTitleChild(BuildContext context) {
    return SizedBox(
      height: _selectTitleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              '取消',
              style: TextStyle(color: Color(0xFF888888), fontSize: 17.0),
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(color: Color(0xFF000000), fontSize: 18),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _selectedValues = _tempValues;
              widget.onSelected(_selectedValues);
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFF000000), fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}
