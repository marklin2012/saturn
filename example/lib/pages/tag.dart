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
        title: Text('Tag'),
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
              size: STTagSize.big,
            ),
            SizedBox(height: 10),
            STTag(
              text: "标签3",
              size: STTagSize.big,
              shape: STTagShape.roundRect,
            ),
            SizedBox(height: 10),
            STTag(
              text: "标签4",
              size: STTagSize.big,
              shape: STTagShape.rightRoundRect,
            ),
            // Text('正常'),
            SizedBox(height: 10),
            STTag(
              text: "标签5",
              onCloseTap: (value) {
                print(value);
              },
            ),
            SizedBox(height: 24),
            STTag(
              text: "大",
              size: STTagSize.big,
            ),
            SizedBox(height: 10),
            STTag(
              text: "正常",
              type: STTagType.primary,
            ),
            SizedBox(height: 10),
            STTag(
              text: "小",
              size: STTagSize.small,
            ),
            SizedBox(height: 10),
            STTag(
              text: "主要",
            ),
            SizedBox(height: 10),
            STTag(
              text: "成功",
              type: STTagType.success,
            ),
            SizedBox(height: 10),
            STTag(
              text: "错误",
              type: STTagType.error,
            ),
            SizedBox(height: 10),
            STTag(
              text: "警告",
              type: STTagType.warning,
            ),
          ],
        ),
      ),
    );
  }
}
