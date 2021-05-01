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
          STVideo(),
          SizedBox(height: 20),
          STVideo(type: STVideoRowType.two),
        ],
      ),
    );
  }
}
