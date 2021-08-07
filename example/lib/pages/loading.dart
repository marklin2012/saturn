import 'package:example/pages/loading_pull.dart';
import 'package:example/pages/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(STToastConstant.cornerRadius),
      color: STToastConstant.defaultBackgroundColor,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Loading'),
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
                  child: Text("基本", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return STLoading(alwaysLoading: true, text: '');
                        });
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("toast加载", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return STToast(
                            type: STToastType.error,
                            icon: Icon(
                              STIcons.status_loading,
                              color: Colors.white,
                            ),
                            closable: false,
                            autoClose: false,
                            hasSafeArea: true,
                            rotateAnimation: true,
                            disappearMilliseconds:
                                STToastConstant.defaultDisappearMilliseconds,
                            isIconTop: true,
                            message: "正在加载",
                            position: STToastPosition.center,
                          );
                        });
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("下拉刷新加载", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoadingPullPage()));
                  },
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("进度条加载", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                FlatButton(
                  child: Text("预加载", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoadingShimmerPage()));
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
