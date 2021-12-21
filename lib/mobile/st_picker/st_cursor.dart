import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';

class STCursor extends StatefulWidget {
  const STCursor({
    Key? key,
    this.color = const Color(0xFF095BF9),
    this.width = 2.0,
    this.height = 22.0,
    this.decoration = const BoxDecoration(
      color: STColor.secRankBlue,
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  }) : super(key: key);

  final Color color;
  final double width;
  final double height;
  final BoxDecoration decoration;

  @override
  _STCursorState createState() => _STCursorState();
}

class _STCursorState extends State<STCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;
  BoxDecoration? _boxDecoration;

  @override
  void initState() {
    super.initState();
    _boxDecoration = widget.decoration;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {
          _opacity = _controller.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: _boxDecoration,
      ),
    );
  }
}
