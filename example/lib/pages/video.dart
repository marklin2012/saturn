import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // STVideo.network(
          //     url:
          //         'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4'),

          STVideo.asset(
            path: 'assets/video/showtime.mp4',
            doubleControlRow: true,
            isShowControl: false,
          ),
        ],
      ),
    );
  }
}
