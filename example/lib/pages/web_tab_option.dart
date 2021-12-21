import 'package:flutter/material.dart';

class WebTapOptionPage extends StatefulWidget {
  const WebTapOptionPage({Key key}) : super(key: key);

  @override
  _WebTapOptionPageState createState() => _WebTapOptionPageState();
}

class _WebTapOptionPageState extends State<WebTapOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tabOption'),
      ),
    );
  }
}
