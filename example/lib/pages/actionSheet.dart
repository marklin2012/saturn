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
            child: Text("list vertical"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  title: "是不是",
                  icon: "assets/images/basketball_check.png",
                  message: "描述说明信息",
                  hasTextField: true,
                  hasCancelButton: true,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  options: [
                    STActionSheetOption(
                      title: "好的",
                      hasSeparateLine: true,
                      isAligmentCenter: true,
                    ),
                    STActionSheetOption(
                      title: "好的",
                      hasSeparateLine: true,
                      isAligmentCenter: false,
                      isRadio: true,
                    ),
                    STActionSheetOption(
                        title: "是不是",
                        icon: "assets/images/basketball_check.png",
                        hasSeparateLine: true,
                        isAligmentCenter: true),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        icon: "assets/images/basketball_check.png",
                        hasSeparateLine: true,
                        isAligmentCenter: false),
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
            child: Text("list horizontal"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述说明信息",
                  hasTextField: true,
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
        ],
      ),
    );
  }
}
