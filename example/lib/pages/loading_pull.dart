import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class LoadingPullPage extends StatefulWidget {
  const LoadingPullPage({Key key}) : super(key: key);

  @override
  _LoadingPullPageState createState() => _LoadingPullPageState();
}

class _LoadingPullPageState extends State<LoadingPullPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉刷新'),
      ),
      body: EasyRefresh(
        header: ClassicalHeader(
          refreshReadyText: '松开刷新',
          refreshingText: '加载中...',
          refreshedText: '加载完成',
          refreshText: '下拉刷新',
        ),
        child: SingleChildScrollView(),
        onRefresh: () async {},
        onLoad: () async {},
      ),
    );
  }
}
