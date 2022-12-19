import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image imageWidget = Image.asset("assets/images/basketball_check.png",
        width: 24.0, height: 24.0, fit: BoxFit.contain);
    Icon iconWidget = Icon(Icons.error_outline);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Message'),
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
              STButton(
                text: "基础用法",
                onTap: () {
                  STMessage.show(
                      context: context,
                      message: "这是文本信息",
                      icon: imageWidget,
                      showShadow: true,
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
              STButton(
                text: "含辅助性文字描述",
                onTap: () {
                  STMessage.show(
                      context: context,
                      title: "标题标题",
                      message: "好的好的信息好的信息好的信息好的信息好的信息好的信息好的信息好的信息",
                      icon: imageWidget,
                      showShadow: true,
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
              STButton(
                text: "显示状态",
                onTap: () {
                  STMessage.show(
                      context: context,
                      message: "这是文本信息",
                      type: STMessageType.success,
                      showShadow: true,
                      autoClose: true);
                },
              ),
              SizedBox(height: 20),
              STButton(
                text: "可自定义",
                onTap: () {
                  STMessage.show(
                    context: context,
                    autoClose: false,
                    content: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              STMessageConstant.cornerRadius),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.wifi, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text(
                                        "这是说明信息",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "说明信息",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text("标题标题",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: STMessageConstant.titleFontSize,
                                      decoration: TextDecoration.none)),
                              SizedBox(height: 4),
                              Text("这是文本信息",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none)),
                              SizedBox(height: 12),
                            ],
                          ),
                        )),
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
