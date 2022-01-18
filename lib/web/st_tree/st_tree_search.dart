import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class STTreeSearch extends StatefulWidget {
  const STTreeSearch({
    Key? key,
    this.controller,
    this.width = 395,
    this.height = 32,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? controller;
  final double width;
  final double height;
  final Function(String)? onChanged;

  @override
  _STTreeSearchState createState() => _STTreeSearchState();
}

class _STTreeSearchState extends State<STTreeSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
        border: Border.all(color: STColor.thrRankGrey),
      ),
      child: Row(
        children: [
          Expanded(
            child: STInput(
              height: widget.height,
              placeholder: '搜索',
              decoration: const BoxDecoration(),
              controller: _controller,
            ),
          ),
          STMouseRegion(
            child: GestureDetector(
              onTap: () {
                if (_controller.text.isEmpty) return;
                _tapAction();
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: STColor.thrRankGrey),
                  ),
                ),
                width: widget.height,
                height: widget.height,
                child: const Icon(
                  STIcons.commonly_search_outline,
                  size: 14,
                  color: STColor.fourRankFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapAction() {
    STDebounce().start(
      key: 'STTreeSearch',
      func: () {
        if (widget.onChanged == null) return;
        widget.onChanged!(_controller.text);
      },
      time: 100,
    );
  }
}
