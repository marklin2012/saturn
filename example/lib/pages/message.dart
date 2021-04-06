import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_message/st_message.dart';

class MessagePage extends StatelessWidget {
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
            child: Text("文字"),
            color: Colors.blue,
            onPressed: () {
              STMessage.show(
                  context: context,
                  title: "标题标题",
                  message: "好的",
                  explain: "说的",
                  explainInfo: "这个",
                  icon: "assets/images/basketball_check.png");
            },
          ),
        ],
      ),
    );
  }
}
