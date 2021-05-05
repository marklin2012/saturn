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
            STTag(
              text: "标签1",
              size: STTagSize.big,
            ),
            SizedBox(height: 10),
            STTag(
              text: "标签2",
              type: STTagType.primary,
              shape: STTagShape.outline,
              size: STTagSize.small,
            ),
            SizedBox(height: 10),
            STTag(text: "标签3", type: STTagType.warning),
            SizedBox(height: 10),
            STTag(text: "标签4", type: STTagType.success),
            SizedBox(height: 10),
            STTag(text: "标签5", type: STTagType.error),
            SizedBox(height: 10),
            STTag(text: "标签6", shape: STTagShape.rightRoundRect),
            SizedBox(height: 10),
            STTag(
                text: "标签7",
                type: STTagType.success,
                shape: STTagShape.roundRect),
            SizedBox(height: 10),
            STTag(
              text: "标签8",
              type: STTagType.error,
              // shape: STTagShape.rightRoundRect,
              onCloseTap: (value) {
                print(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
