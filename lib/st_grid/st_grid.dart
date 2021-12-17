import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';

class STGridView extends StatelessWidget {
  const STGridView({
    Key key,
    @required this.gridDelegate,
    @required this.itemBuilder,
    this.itemCount,
    this.padding,
    this.backgroundColor,
    this.decoration,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  final Color backgroundColor;

  final BoxDecoration decoration;

  final SliverGridDelegate gridDelegate;

  final Widget Function(BuildContext, int) itemBuilder;

  final int itemCount;

  final EdgeInsetsGeometry padding;

  final ScrollController controller;

  final Axis scrollDirection;

  final bool reverse;

  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(bottom: 10),
      decoration: decoration ??
          BoxDecoration(color: backgroundColor ?? STColor.thrRankGrey),
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: gridDelegate,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          controller: controller ?? ScrollController(),
          scrollDirection: scrollDirection,
          reverse: reverse,
          physics: physics,
        ),
      ),
    );
  }
}
