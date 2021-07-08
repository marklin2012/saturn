import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Loading'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("下拉加载"),
                SizedBox(height: 20),
                STLoading(
                  text: "正在加载...",
                ),
                SizedBox(height: 20),
                STLoading(
                  iconPosition: STLoadingIconPosition.top,
                  text: "正在加载...",
                ),
                SizedBox(height: 20),
                STLoading(
                  iconPosition: STLoadingIconPosition.top,
                  text: "",
                  alwaysLoading: true,
                ),
                SizedBox(height: 20),
                STLoading(
                  iconPosition: STLoadingIconPosition.top,
                  alwaysLoading: true,
                  icon: null,
                ),
                SizedBox(height: 20),
                Text("下拉刷新"),
                SizedBox(height: 20),
                STLoading(
                  text: "正在刷新...",
                ),
                SizedBox(height: 20),
                STLoading(
                  text: "松开刷新...",
                ),
                SizedBox(height: 20),
                Text("全屏加载"),
                SizedBox(height: 20),
                STLoading(
                    iconPosition: STLoadingIconPosition.top,
                    alwaysLoading: true,
                    icon: Image.asset("assets/images/icon_selected_20x20.png"),
                    text: "正在努力加载中..."),
                SizedBox(height: 20),
                STLoading(
                    icon: Image.asset("assets/images/icon_selected_20x20.png"),
                    text: "")
              ],
            ),
          ),
        ));
  }
}
