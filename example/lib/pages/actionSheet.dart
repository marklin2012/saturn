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
              );
            },
          ),
          FlatButton(
            child: Text("list vertical 不许选择"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  title: "是不是",
                  icon: Image.asset("assets/images/basketball_check.png",
                      fit: BoxFit.fitWidth),
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
                      iconWidget: Image.asset(
                          "assets/images/basketball_check.png",
                          fit: BoxFit.fitWidth),
                    ),
                    STActionSheetOption(
                      title: "不好",
                      message: "描述说明信息",
                      iconWidget: Image.asset(
                          "assets/images/basketball_check.png",
                          fit: BoxFit.fitWidth),
                    ),
                    STActionSheetOption(
                      title: "好的",
                      iconWidget: Image.asset(
                          "assets/images/basketball_check.png",
                          fit: BoxFit.fitWidth),
                    ),
                    STActionSheetOption(
                        title: "是不是",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
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
                  icon: Image.asset("assets/images/basketball_check.png",
                      fit: BoxFit.fitWidth),
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
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "好的",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "是不是",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
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
                  icon: Image.asset("assets/images/basketball_check.png",
                      fit: BoxFit.fitWidth),
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
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "好的",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "是不是",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
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
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth),
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                          title: "是不是",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth))
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
                  onConfirmTap: (selectArr) {
                    print(selectArr);
                  },
                  options: [
                    [
                      STActionSheetOption(
                          title: "好的",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth),
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                          title: "是不是",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth))
                    ],
                    [
                      STActionSheetOption(
                          title: "好的",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth),
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                          title: "是不是",
                          iconWidget: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
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
                onConfirmTap: (selectArr) {
                  print(selectArr);
                },
                options: [
                  [
                    STActionSheetOption(
                        title: "好的",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth),
                        onTap: () {
                          print("好的");
                        }),
                    STActionSheetOption(
                        title: "是不是",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "不好",
                        message: "描述说明信息",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth))
                  ],
                  [
                    STActionSheetOption(
                        title: "好的",
                        iconWidget: Image.asset(
                            "assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth),
                        onTap: () {
                          print("好的");
                        }),
                    STActionSheetOption(
                        title: "是不是", iconWidget: Icon(Icons.ac_unit)),
                  ]
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
