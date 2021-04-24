import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            STTag(text: "标签", type: STTagType.normal),
            SizedBox(height: 10),
            STTag(text: "标签", isBorder: true, type: STTagType.normal),
            SizedBox(height: 10),
            STTag(
                text: "标签",
                corner: STTagCorner.circle,
                type: STTagType.warning),
            SizedBox(height: 10),
            STTag(
                text: "标签",
                corner: STTagCorner.rightHalf,
                type: STTagType.success),
            SizedBox(height: 10),
            STTag(text: "标签", needClose: true, type: STTagType.failure),
          ],
        ),
      ),
    );
  }
}
