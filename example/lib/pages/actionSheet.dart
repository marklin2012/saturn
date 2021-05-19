import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ActionSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text("list vertical 不许选择"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  title: "是不是",
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  hasCancelButton: false,
                  hasConfirmButton: false,
                  canSelect: false,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  isOptionAligmentCenter: true,
                  options: [
                    STActionSheetOption(
                      title: "好的",
                    ),
                    STActionSheetOption(
                      title: "好的",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "好的",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                  ]);
            },
          ),
          FlatButton(
            child: Text("list vertical单选"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  title: "是不是",
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  hasCancelButton: true,
                  isSingleSelect: true,
                  directionType: STActionSheetDirectionType.vertical,
                  isOptionAligmentCenter: false,
                  options: [
                    STActionSheetOption(
                      title: "好的",
                    ),
                    STActionSheetOption(
                      title: "好的",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "好的",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                  ]);
            },
          ),
          FlatButton(
            child: Text("list vertical"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  title: "是不是",
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  hasCancelButton: true,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  options: [
                    STActionSheetOption(
                      title: "好的",
                    ),
                    STActionSheetOption(
                      title: "好的",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "好的",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "是不是",
                      icon: "assets/images/basketball_check.png",
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      icon: "assets/images/basketball_check.png",
                    ),
                  ]);
            },
          ),
          FlatButton(
            child: Text("list horizontal 不许选择"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述说明信息",
                  hasCancelButton: true,
                  hasConfirmButton: true,
                  canSelect: false,
                  cancelTitle: "取消",
                  directionType: STActionSheetDirectionType.horizontal,
                  options: [
                    [
                      STActionSheetOption(
                          title: "好的",
                          icon: "assets/images/basketball_check.png",
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      )
                    ],
                  ]);
            },
          ),
          FlatButton(
            child: Text("list horizontal 单选"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述说明信息",
                  hasCancelButton: false,
                  hasConfirmButton: false,
                  isSingleSelect: true,
                  cancelTitle: "取消",
                  directionType: STActionSheetDirectionType.horizontal,
                  onConfirmTap: (text, selectArr) {
                    print(selectArr);
                  },
                  options: [
                    [
                      STActionSheetOption(
                          title: "好的",
                          icon: "assets/images/basketball_check.png",
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      )
                    ],
                    [
                      STActionSheetOption(
                          title: "好的",
                          icon: "assets/images/basketball_check.png",
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                      ),
                    ],
                  ]);
            },
          ),
          FlatButton(
            child: Text("list horizontal"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述说明信息",
                  hasCancelButton: true,
                  hasConfirmButton: true,
                  cancelTitle: "取消",
                  directionType: STActionSheetDirectionType.horizontal,
                  onConfirmTap: (text, selectArr) {
                    print(selectArr);
                  },
                  options: [
                    [
                      STActionSheetOption(
                          title: "好的",
                          icon: "assets/images/basketball_check.png",
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      ),
                      STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                      )
                    ],
                  ]);
            },
          ),
        ],
      ),
    );
  }
}