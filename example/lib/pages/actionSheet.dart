import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ActionSheetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ActionSheet'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              FlatButton(
                child: Text("list vertical文字 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                      context: context,
                      message: "描述类标题描述类标题描述类标题描述",
                      hasCancelButton: false,
                      hasConfirmButton: true,
                      isSingleSelect: true,
                      directionType: STActionSheetDirectionType.vertical,
                      isOptionAligmentCenter: true,
                      showSeperateLine: true,
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
                        STActionSheetOption(
                          title: "选项四",
                        ),
                        STActionSheetOption(
                          title: "选项五",
                        ),
                      ]);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("list vertical文字 多选",
                    style: TextStyle(color: Colors.white)),
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
                      showSeperateLine: true,
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
                        STActionSheetOption(
                          title: "选项四",
                        ),
                        STActionSheetOption(
                          title: "选项五",
                        ),
                      ]);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("list vertical 图片文字 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                      context: context,
                      message: "描述类标题描述类标题描述类标题描述",
                      hasCancelButton: false,
                      hasConfirmButton: true,
                      isSingleSelect: true,
                      directionType: STActionSheetDirectionType.vertical,
                      isOptionAligmentCenter: false,
                      options: [
                        STActionSheetOption(
                          title: "选项一",
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth)),
                          //       fit: BoxFit.fitWidth),
                        ),
                        STActionSheetOption(
                          title: "选项二",
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth)),
                        ),
                        STActionSheetOption(
                          title: "选项三",
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth)),
                        ),
                        STActionSheetOption(
                          title: "选项四",
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth)),
                        ),
                        STActionSheetOption(
                          title: "选项五",
                          icon: SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth)),
                        )
                      ]);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("list vertical 单选按钮文字 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                      context: context,
                      message: "描述类标题描述类标题描述类标题描述",
                      hasCancelButton: false,
                      hasConfirmButton: true,
                      canSelect: true,
                      isSingleSelect: true,
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
                            onTap: () {
                              print("点击了");
                            }),
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
              SizedBox(height: 20),
              FlatButton(
                child: Text("list vertical 单选按钮文字 多选",
                    style: TextStyle(color: Colors.white)),
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
                            onTap: () {
                              print("点击了");
                            }),
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
              SizedBox(height: 20),
              FlatButton(
                child: Text("list vertical icon标题文字 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                      context: context,
                      icon: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/images/iconfont.png",
                              fit: BoxFit.fitWidth)),
                      title: "这是一个标题",
                      message: "文字说明信息",
                      hasCancelButton: false,
                      hasConfirmButton: true,
                      isSingleSelect: true,
                      directionType: STActionSheetDirectionType.vertical,
                      isOptionAligmentCenter: false,
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
              SizedBox(height: 20),
              FlatButton(
                child: Text("list horizontal 单排 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                      context: context,
                      message: "描述说明信息",
                      hasCancelButton: false,
                      hasConfirmButton: true,
                      isSingleSelect: true,
                      canSelect: true,
                      cancelTitle: "取消",
                      directionType: STActionSheetDirectionType.horizontal,
                      options: [
                        [
                          STActionSheetOption(
                              title: "好的",
                              icon: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset("assets/images/iconfont.png",
                                    fit: BoxFit.fitWidth),
                              ),
                              onTap: () {
                                print("好的");
                              }),
                          STActionSheetOption(
                            title: "是不是",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "不好",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "不好",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "不好",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "不好",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "不好",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          )
                        ],
                      ]);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("list horizontal 双排 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                      context: context,
                      message: "描述说明信息",
                      hasCancelButton: false,
                      hasConfirmButton: true,
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
                              icon: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset("assets/images/iconfont.png",
                                    fit: BoxFit.fitWidth),
                              ),
                              onTap: () {
                                print("好的");
                              }),
                          STActionSheetOption(
                            title: "文本",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "文本",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "文本",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "文本",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "文本",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          STActionSheetOption(
                            title: "文本",
                            message: "描述说明信息",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          )
                        ],
                        [
                          STActionSheetOption(
                              title: "文本",
                              icon: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset("assets/images/iconfont.png",
                                    fit: BoxFit.fitWidth),
                              ),
                              onTap: () {
                                print("好的");
                              }),
                          STActionSheetOption(
                            title: "文本",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ],
                      ]);
                },
              ),
              SizedBox(height: 20),
              FlatButton(
                child: Text("list horizontalicon 标题文字 双排 单选",
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  STActionSheet.show(
                    context: context,
                    icon: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/images/iconfont.png",
                          fit: BoxFit.fitWidth),
                    ),
                    title: "这是一个标题",
                    message: "文字说明信息",
                    isSingleSelect: true,
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
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                            onTap: () {
                              print("好的");
                            }),
                        STActionSheetOption(
                          title: "文本",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        STActionSheetOption(
                          title: "文本",
                          message: "描述说明信息",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        )
                      ],
                      [
                        STActionSheetOption(
                            title: "文本",
                            icon: SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset("assets/images/iconfont.png",
                                  fit: BoxFit.fitWidth),
                            ),
                            onTap: () {
                              print("文本");
                            }),
                        STActionSheetOption(
                          title: "文本",
                          icon: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/iconfont.png",
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                      ]
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
