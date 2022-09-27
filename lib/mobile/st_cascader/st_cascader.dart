import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_cascader/cascader_item.dart';
import 'package:saturn/mobile/st_cascader/cascader_pop.dart';
import 'package:saturn/mobile/st_select/select_show_dialog.dart';
import 'package:saturn/utils/include.dart';

const _defaultHolderString = '请选择';
const _defaultHolderTextStyle =
    TextStyle(color: Color(0xFFBBBBBB), fontSize: 16);
const _defaultTextStyle = TextStyle(color: Color(0xFF000000), fontSize: 16);
const _defaultSelectColor = Color(0xFF095BF9);
const _defaultBorderColor = Color(0xFFC4C5C7);

class STCascader extends StatefulWidget {
  final double verticalOffset; // 弹出的视图距离触发内容的垂直方向偏移量
  final List<String>? initValue; // 初始值
  final ValueChanged<List<String>>? onChanged;
  final List<STCascaderItem> items; // 内容集
  final double height; // 触发内容的高度

  const STCascader({
    Key? key,
    this.verticalOffset = 8.0,
    this.initValue,
    this.onChanged,
    required this.items,
    this.height = 48.0,
  })  : assert(items.length > 0),
        super(key: key);

  @override
  _STCascaderState createState() => _STCascaderState();
}

class _STCascaderState extends State<STCascader> {
  bool _showSelected = false;
  final GlobalKey _selectKey = GlobalKey(debugLabel: 'cascader'); // 控件的key
  late Offset _originPoint;
  String? _valueStr;

  @override
  void initState() {
    super.initState();
    _valueStr = _defaultHolderString;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _findRenderObject();
    });
  }

  void _findRenderObject() {
    final RenderBox renderBox =
        _selectKey.currentContext!.findRenderObject() as RenderBox;
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
                _originPoint.dy +
                    widget.verticalOffset +
                    (getIsWeb() ? widget.height : 0),
              ),
              menu: STCascaderPop(
                items: widget.items,
                onChangedValue: (List<String> value) {
                  _oprationOnChanged(value);
                },
                onChangedKey: (List<String> keys) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(keys);
                  }
                },
              ),
              limitHorizontal: false,
            );
          },
        ).then((value) {
          _showSelected = !_showSelected;
          setState(() {});
        });
      },
      child: Container(
        key: _selectKey,
        height: widget.height,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: _showSelected ? _defaultSelectColor : _defaultBorderColor,),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                _valueStr!,
                style: _getTextStyle(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 13),
              child: _showSelected
                  ? const Icon(Icons.arrow_drop_up,
                      size: 24, color: Colors.black,)
                  : const Icon(Icons.arrow_drop_down,
                      size: 24, color: Colors.black,),
            ),
          ],
        ),
      ),
    );
  }

  void _oprationOnChanged(List<String> values) {
    String _temp = '';
    for (final item in values) {
      _temp += ' $item';
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
