import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_mix_item.dart';
import 'package:saturn/st_select/select_show_dialog.dart';
import 'package:saturn/utils/include.dart';

const _defaultBorderColor = Color(0xFFC4C5C7);
const _defaultHeight = 48.0;

class STSelectMix extends StatefulWidget {
  final STSelectMixItem initValue;
  final List<STSelectMixItem> items;
  final Color selectedColor;
  final Function(STSelectMixItem) onChanged;
  final double verticalOffset;
  final bool isConCheck; // 是否需要勾选

  const STSelectMix({
    Key key,
    this.initValue,
    this.items,
    this.selectedColor = const Color(0xFF095BF9),
    this.onChanged,
    this.verticalOffset = 8.0,
    this.isConCheck = false,
  }) : super(key: key);

  @override
  _STSelectMixState createState() => _STSelectMixState();
}

class _STSelectMixState extends State<STSelectMix> {
  bool _showSelected = false;
  final GlobalKey _selectKey = GlobalKey(debugLabel: 'selectMix'); // 控件的key
  Offset _originPoint;

  @override
  void initState() {
    super.initState();
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
              menu: _getMenu(),
              offset: Offset(
                _originPoint.dx,
                _originPoint.dy +
                    widget.verticalOffset +
                    (getIsWeb() ? _defaultHeight : 0),
              ),
              height: 42.0 * 6,
            );
          },
        ).then((value) {
          _showSelected = !_showSelected;
          setState(() {});
        });
      },
      child: Container(
        key: _selectKey,
        height: _defaultHeight,
        decoration: BoxDecoration(
          border: Border.all(
              color:
                  _showSelected ? widget.selectedColor : _defaultBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Text(
                widget.initValue != null ? widget.initValue.title : '',
                style: const TextStyle(color: Color(0xFF000000), fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
              child: _showSelected
                  ? const Icon(Icons.arrow_drop_up)
                  : const Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMenu() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0x88888888),
          ),
        ],
      ),
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, int index) {
          final data = widget.items[index];
          final _isSelected = _getSelected(data);
          return GestureDetector(
            onTap: () {
              if (data.disabled) return;
              if (widget.onChanged != null) {
                widget.onChanged(widget.items[index]);
                Navigator.pop(context);
              }
            },
            child: Container(
              height: 41.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        if (data.icon != null)
                          Icon(
                            data.icon,
                            color: _getColor(data, isSelected: _isSelected),
                          ),
                        if (data.icon != null) const SizedBox(width: 12),
                        Text(
                          data.title,
                          style: TextStyle(
                            color: _getColor(data, isSelected: _isSelected),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isConCheck)
                    Container(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: _isSelected
                          ? Icon(Icons.check, color: widget.selectedColor)
                          : null,
                    ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, int index) {
          return SizedBox(
            height: 1,
            child: Container(color: const Color(0xFFDFE2E7)),
          );
        },
        itemCount: widget.items.length,
      ),
    );
  }

  bool _getSelected(STSelectMixItem data) {
    if (widget.initValue == null) return false;
    return data.key == widget.initValue.key;
  }

  Color _getColor(STSelectMixItem data, {bool isSelected = false}) {
    if (data.disabled) {
      return const Color(0xFFC4C5C7);
    } else if (isSelected) {
      return widget.selectedColor;
    } else {
      return const Color(0xFF000000);
    }
  }
}
