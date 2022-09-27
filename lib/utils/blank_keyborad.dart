import 'package:flutter/material.dart';

class BlankPutKeyborad extends StatelessWidget {
  const BlankPutKeyborad({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (onTap == null) return;
        onTap!();
      },
      child: child,
    );
  }
}