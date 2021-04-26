import 'package:flutter/material.dart';
import 'package:saturn/st_cascader/cascader_item.dart';
import 'package:saturn/st_cascader/cascader_pop.dart';
import 'package:saturn/st_select/select_show_dialog.dart';

const _defaultContentHeight = 262.0;
const _defaultHolderString = '请选择';
const _defaultHolderTextStyle =
    TextStyle(color: Color(0xFFBBBBBB), fontSize: 16);
const _defaultTextStyle = TextStyle(color: Color(0xFF000000), fontSize: 16);
const _defaultSelectColor = Color(0xFF095BF9);

class STCascader extends StatefulWidget {
  final double verticalOffset;
  final List<String> initValue;
  final ValueChanged<List<String>> onChanged;
  final List<STCascaderItem> items;

  const STCascader({
    Key key,
    this.verticalOffset = 8.0,
    this.initValue,
    this.onChanged,
    this.items,
  })  : assert(items.length > 0),
        super(key: key);

  @override
  _STCascaderState createState() => _STCascaderState();
}

class _STCascaderState extends State<STCascader> {
  bool _showSelected = false;
  final GlobalKey _selectKey = GlobalKey(debugLabel: 'cascader'); // 控件的key
  Offset _originPoint;
  String _valueStr;

  @override
  void initState() {
    super.initState();
    _valueStr = _defaultHolderString;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _findRenderObject();
    });
  }

  void _findRenderObject() {
    final RenderBox renderBox = _selectKey.currentContext.findRenderObject();
    _originPoint = renderBox.localToGlobal(Offset.zero);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSelected = !_showSelected;
        setState(() {});
        showDialog(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return ShowSelectDialog(
              offset: Offset(
                _originPoint.dx,
                _originPoint.dy + widget.verticalOffset,
              ),
              menu: STCascaderPop(
                items: widget.items,
                onChanged: (value) {
                  _oprationOnChanged(value);
                  if (widget.onChanged != null) {
                    widget.onChanged(value);
                  }
                },
              ),
              height: _defaultContentHeight,
            );
          },
        ).then((value) {
          _showSelected = !_showSelected;
          setState(() {});
        });
      },
      child: Container(
        key: _selectKey,
        height: 48.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: _defaultSelectColor),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                _valueStr,
                style: _getTextStyle(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 13),
              child: _showSelected
                  ? const Icon(Icons.arrow_drop_down,
                      size: 24, color: Colors.black)
                  : const Icon(Icons.arrow_drop_up,
                      size: 24, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _oprationOnChanged(List<String> values) {
    String _temp = '';
    for (final item in values) {
      if (item != null) {
        _temp += ' $item';
      }
    }
    _valueStr = _temp.substring(1);
    setState(() {});
  }

  TextStyle _getTextStyle() {
    if (_valueStr == _defaultHolderString) {
      return _defaultHolderTextStyle;
    } else {
      return _defaultTextStyle;
    }
  }
}
