import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class SnackbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text("标题"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                context: context,
                title: "你说是就是你说是就是你说是就是你说是就是你说是就是你说是就是",
              );
            },
          ),
          FlatButton(
            child: Text("标题文字"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                context: context,
                title: "你说是就是你说",
                message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
              );
            },
          ),
          FlatButton(
            child: Text("icon标题文字"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                  context: context,
                  title: "你说是就是你说",
                  message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                  icon: Icons.error);
            },
          ),
          FlatButton(
            child: Text("image标题文字"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                  context: context,
                  title: "你说是就是你说",
                  message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                  image: "assets/images/basketball_check.png");
            },
          ),
          FlatButton(
            child: Text("标题button"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                  context: context,
                  title: "你说是就是你说你说是就是你说",
                  buttonText: "文字按钮",
                  onButtonTap: () {
                    print("好的");
                  });
            },
          ),
          FlatButton(
            child: Text("标题button背景"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                context: context,
                title: "你说是就是你说你说是就是你说",
                buttonText: "文字按钮",
                buttonHaveBackground: true,
              );
            },
          ),
          FlatButton(
            child: Text("icon标题button背景"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                  context: context,
                  title: "你说是就是你说你说是就是你说",
                  buttonText: "文字按钮",
                  buttonHaveBackground: true,
                  icon: Icons.error);
            },
          ),
          FlatButton(
            child: Text("icon标题文字button背景"),
            color: Colors.blue,
            onPressed: () {
              // send();
              // SocketManage.send(textEditController.text);

              STSnackbar.show(
                  context: context,
                  title: "你说是就是你说你说是就是你说",
                  message: "你说是就是你说你说是就是你说你说是就是你说你说是就是你说",
                  buttonText: "文字按钮",
                  buttonHaveBackground: true,
                  icon: Icons.error);
            },
          )
        ],
      ),
    );
  }
}
