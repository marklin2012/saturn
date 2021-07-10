import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ActionSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ActionSheet'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // FlatButton(
          //   child: Text("list vertical 不许选择"),
          //   color: Colors.blue,
          //   onPressed: () {
          //     STActionSheet.show(
          //       context: context,
          //     );
          //   },
          // ),
          FlatButton(
            child: Text("list vertical文字"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述类标题描述类标题描述类标题描述",
                  hasCancelButton: false,
                  hasConfirmButton: true,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  isOptionAligmentCenter: true,
                  options: [
                    STActionSheetOption(
                      title: "选项一",
                    ),
                    STActionSheetOption(
                      title: "选项二",
                    ),
                    STActionSheetOption(
                      title: "选项三",
                    ),
                    STActionSheetOption(
                      title: "选项四",
                    ),
                    STActionSheetOption(
                      title: "选项五",
                    ),
                    // STActionSheetOption(
                    //   title: "好的",
                    //   isRadio: true,
                    // ),
                    // STActionSheetOption(
                    //   title: "是不是",
                    //   icon: Image.asset("assets/images/basketball_check.png",
                    //       fit: BoxFit.fitWidth),
                    // ),
                    // STActionSheetOption(
                    //   title: "不好",
                    //   message: "描述说明信息",
                    //   icon: Image.asset("assets/images/basketball_check.png",
                    //       fit: BoxFit.fitWidth),
                    // ),
                    // STActionSheetOption(
                    //   title: "好的",
                    //   icon: Image.asset("assets/images/basketball_check.png",
                    //       fit: BoxFit.fitWidth),
                    // ),
                    // STActionSheetOption(
                    //     title: "是不是",
                    //     icon: Image.asset("assets/images/basketball_check.png",
                    //         fit: BoxFit.fitWidth)),
                    // STActionSheetOption(
                    //     title: "不好",
                    //     message: "描述说明信息",
                    //     icon: Image.asset("assets/images/basketball_check.png",
                    //         fit: BoxFit.fitWidth)),
                  ]);
            },
          ),
          FlatButton(
            child: Text("list vertical 图片文字"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述类标题描述类标题描述类标题描述",
                  hasCancelButton: false,
                  hasConfirmButton: true,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  isOptionAligmentCenter: false,
                  options: [
                    STActionSheetOption(
                      title: "选项一",
                      icon: Icon(Icons.info_outline, color: Colors.grey),
                      //       fit: BoxFit.fitWidth),
                    ),
                    STActionSheetOption(
                      title: "选项二",
                      icon: Icon(Icons.info_outline, color: Colors.grey),
                    ),
                    STActionSheetOption(
                      title: "选项三",
                      icon: Icon(Icons.info_outline, color: Colors.grey),
                    ),
                    STActionSheetOption(
                      title: "选项四",
                      icon: Icon(Icons.info_outline, color: Colors.grey),
                    ),
                    STActionSheetOption(
                      title: "选项五",
                      icon: Icon(Icons.info_outline, color: Colors.grey),
                    )
                  ]);
            },
          ),
          FlatButton(
            child: Text("list vertical 单选文字"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述类标题描述类标题描述类标题描述",
                  hasCancelButton: false,
                  hasConfirmButton: true,
                  canSelect: true,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  isOptionAligmentCenter: false,
                  options: [
                    STActionSheetOption(
                      title: "选项一",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "选项二",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "选项三",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "选项四",
                      isRadio: true,
                    ),
                    STActionSheetOption(
                      title: "选项五",
                      isRadio: true,
                    )
                  ]);
            },
          ),
          FlatButton(
            child: Text("list vertical icon标题文字"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  icon: Icon(Icons.article, color: Colors.blue),
                  title: "这是一个标题",
                  message: "文字说明信息",
                  hasCancelButton: false,
                  hasConfirmButton: true,
                  isSingleSelect: false,
                  directionType: STActionSheetDirectionType.vertical,
                  isOptionAligmentCenter: true,
                  options: [
                    STActionSheetOption(
                      title: "选项一",
                    ),
                    STActionSheetOption(
                      title: "选项二",
                    ),
                    STActionSheetOption(
                      title: "选项三",
                    ),
                    STActionSheetOption(
                      title: "选项四",
                    ),
                    STActionSheetOption(
                      title: "选项五",
                    )
                  ]);
            },
          ),
          // FlatButton(
          //   child: Text("list vertical图片文字"),
          //   color: Colors.blue,
          //   onPressed: () {
          //     STActionSheet.show(
          //         context: context,
          //         title: "是不是",
          //         icon: Image.asset("assets/images/basketball_check.png",
          //             fit: BoxFit.fitWidth),
          //         message: "描述说明信息",
          //         hasCancelButton: true,
          //         isSingleSelect: true,
          //         directionType: STActionSheetDirectionType.vertical,
          //         isOptionAligmentCenter: false,
          //         options: [
          //           STActionSheetOption(
          //             title: "好的",
          //           ),
          //           STActionSheetOption(
          //             title: "好的",
          //             isRadio: true,
          //           ),
          //           STActionSheetOption(
          //               title: "是不是",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "不好",
          //               message: "描述说明信息",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "好的",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "是不是",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "不好",
          //               message: "描述说明信息",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //         ]);
          //   },
          // ),
          // FlatButton(
          //   child: Text("list vertical"),
          //   color: Colors.blue,
          //   onPressed: () {
          //     STActionSheet.show(
          //         context: context,
          //         title: "是不是",
          //         icon: Image.asset("assets/images/basketball_check.png",
          //             fit: BoxFit.fitWidth),
          //         message: "描述说明信息",
          //         hasCancelButton: true,
          //         isSingleSelect: false,
          //         directionType: STActionSheetDirectionType.vertical,
          //         options: [
          //           STActionSheetOption(
          //             title: "好的",
          //           ),
          //           STActionSheetOption(
          //             title: "好的",
          //             isRadio: true,
          //           ),
          //           STActionSheetOption(
          //               title: "是不是",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "不好",
          //               message: "描述说明信息",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "好的",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "是不是",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //           STActionSheetOption(
          //               title: "不好",
          //               message: "描述说明信息",
          //               icon: Image.asset("assets/images/basketball_check.png",
          //                   fit: BoxFit.fitWidth)),
          //         ]);
          //   },
          // ),
          FlatButton(
            child: Text("list horizontal"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                  context: context,
                  message: "描述说明信息",
                  hasCancelButton: false,
                  hasConfirmButton: true,
                  canSelect: true,
                  cancelTitle: "取消",
                  directionType: STActionSheetDirectionType.horizontal,
                  options: [
                    [
                      STActionSheetOption(
                          title: "好的",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth),
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                          title: "是不是",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "不好",
                          message: "描述说明信息",
                          icon: Image.asset(
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
                  canSelect: true,
                  isSingleSelect: true,
                  cancelTitle: "取消",
                  directionType: STActionSheetDirectionType.horizontal,
                  onConfirmTap: (selectArr) {
                    print(selectArr);
                  },
                  options: [
                    [
                      STActionSheetOption(
                          title: "文本",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth),
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                          title: "文本",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                      STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth))
                    ],
                    [
                      STActionSheetOption(
                          title: "文本",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth),
                          onTap: () {
                            print("好的");
                          }),
                      STActionSheetOption(
                          title: "文本",
                          icon: Image.asset(
                              "assets/images/basketball_check.png",
                              fit: BoxFit.fitWidth)),
                    ],
                  ]);
            },
          ),
          FlatButton(
            child: Text("list horizontalicon标题文字"),
            color: Colors.blue,
            onPressed: () {
              STActionSheet.show(
                context: context,
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset("assets/images/basketball_check.png",
                      fit: BoxFit.fitWidth),
                ),
                title: "这是一个标题",
                message: "文字说明信息",
                hasCancelButton: true,
                hasConfirmButton: false,
                canSelect: true,
                cancelTitle: "取消",
                directionType: STActionSheetDirectionType.horizontal,
                onConfirmTap: (selectArr) {
                  print(selectArr);
                },
                options: [
                  [
                    STActionSheetOption(
                        title: "文本",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth),
                        onTap: () {
                          print("好的");
                        }),
                    STActionSheetOption(
                        title: "文本",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "文本",
                        message: "描述说明信息",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "文本",
                        message: "描述说明信息",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "文本",
                        message: "描述说明信息",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "文本",
                        message: "描述说明信息",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
                    STActionSheetOption(
                        title: "文本",
                        message: "描述说明信息",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth))
                  ],
                  [
                    STActionSheetOption(
                        title: "文本",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth),
                        onTap: () {
                          print("文本");
                        }),
                    STActionSheetOption(
                        title: "文本",
                        icon: Image.asset("assets/images/basketball_check.png",
                            fit: BoxFit.fitWidth)),
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
