import 'package:flutter/material.dart';
import 'package:saturn/web/st_layout/st_footer.dart';
import 'package:saturn/web/st_layout/st_header.dart';
import 'package:saturn/web/st_layout/st_sider.dart';

class STLayout extends StatelessWidget {
  final STHeader? header;
  final STFooter? footer;
  final Widget content;
  final STSider? sider;
  final STSider? rightSider;
  final Color backgroundColor;
  const STLayout(
      {Key? key,
      this.header,
      this.footer,
      required this.content,
      this.sider,
      this.backgroundColor = Colors.white,
      this.rightSider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (sider != null) sider!,
          Expanded(
            child: Flex(
              direction: Axis.vertical,
              children: [
                if (header != null) header!,
                Expanded(child: content),
                if (footer != null) footer!
              ],
            ),
          ),
          if (rightSider != null) rightSider!,
        ],
      ),
    );
  }
}
