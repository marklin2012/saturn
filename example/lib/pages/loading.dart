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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            STLoading(),
            STLoading(
              iconPosition: STLoadingIconPosition.top,
            ),
            STLoading(alwaysLoading: true),
            STLoading(
              iconPosition: STLoadingIconPosition.top,
              alwaysLoading: true,
              icon: Image.asset("assets/images/icon_selected_20x20.png"),
            ),
            STLoading(icon: null)
          ],
        ),
      ),
    );
  }
}
