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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text("基本用法",
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: STDialogConstant.titleFontSize,
                          decoration: TextDecoration.none)),
                ),
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  STTag(
                    text: "标签1",
                    size: STTagSize.big,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "标签2",
                    type: STTagType.primary,
                    shape: STTagShape.outline,
                    size: STTagSize.big,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "标签3",
                    size: STTagSize.big,
                    shape: STTagShape.roundRect,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "标签4",
                    size: STTagSize.big,
                    shape: STTagShape.rightRoundRect,
                  ),
                ],
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text("含关闭操作",
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: STDialogConstant.titleFontSize,
                          decoration: TextDecoration.none)),
                ),
              ),
              SizedBox(height: 20),
              // Text('正常'),
              STTag(
                text: "标签5",
                onCloseTap: (value) {
                  print(value);
                },
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text("显示状态",
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: STDialogConstant.titleFontSize,
                          decoration: TextDecoration.none)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  STTag(
                    text: "主要",
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "成功",
                    type: STTagType.success,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "错误",
                    type: STTagType.error,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "警告",
                    type: STTagType.warning,
                  ),
                ],
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text("尺寸大小",
                      softWrap: true,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: STDialogConstant.titleFontSize,
                          decoration: TextDecoration.none)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  STTag(
                    text: "大",
                    size: STTagSize.big,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "正常",
                    type: STTagType.primary,
                  ),
                  SizedBox(width: 10),
                  STTag(
                    text: "小",
                    size: STTagSize.small,
                  ),
                  SizedBox(width: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
