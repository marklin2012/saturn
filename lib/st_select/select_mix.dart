import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_show_dialog.dart';
import 'package:saturn/st_select/st_select.dart';

class STSelectMix extends StatefulWidget {
  final STSelectMixData initialValue;
  final List<STSelectMixData> list;
  final Color selectedColor;
  final Function(STSelectMixData value) onSelected;
  final double verticalOffset;

  const STSelectMix({
    Key key,
    this.initialValue,
    this.list,
    this.selectedColor = const Color(0xFF095BF9),
    this.onSelected,
    this.verticalOffset = 8.0,
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
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ShowSelectDialog(
              menu: _getMenu(),
              offset: Offset(
                _originPoint.dx,
                _originPoint.dy + widget.verticalOffset,
              ),
              height: 42.0 * 6,
            );
          },
        );
      },
      child: Container(
        key: _selectKey,
        height: 48.0,
        decoration: BoxDecoration(
          border: Border.all(color: widget.selectedColor),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.initialValue != null)
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  widget.initialValue.title,
                  style:
                      const TextStyle(color: Color(0xFF000000), fontSize: 16),
                ),
              ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
              child: _showSelected
                  ? const Icon(Icons.arrow_drop_down)
                  : const Icon(Icons.arrow_drop_up),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMenu() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: Color(0x88888888),
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, int index) {
          final data = widget.list[index];
          final _isSelected = _getSelected(data);
          return GestureDetector(
            onTap: () {
              if (data.disabled) return;
              if (widget.onSelected != null) {
                _showSelected = !_showSelected;
                widget.onSelected(widget.list[index]);
                Navigator.pop(context);
              }
            },
            child: Container(
              height: 41.0,
              alignment: Alignment.center,
              color: const Color(0xFFFFFFFF),
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
                  Container(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: _isSelected
                        ? const Icon(Icons.check, color: Color(0xFF095BF9))
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
        itemCount: widget.list.length,
      ),
    );
  }

  bool _getSelected(STSelectMixData data) {
    return data.title == widget.initialValue.title;
  }

  Color _getColor(STSelectMixData data, {bool isSelected = false}) {
    if (data.disabled) {
      return const Color(0xFFC4C5C7);
    } else if (isSelected) {
      return const Color(0xFF095BF9);
    } else {
      return const Color(0xFF000000);
    }
  }
}
