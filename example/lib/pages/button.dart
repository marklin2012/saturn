import 'package:flutter/material.dart';

import 'package:saturn/st_button/st_button.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reduceCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('buttons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            STButton(state: STButtonState.danger, onTap: _reduceCounter),
            SizedBox(height: 5),
            STButton.icon(
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              onTap: _incrementCounter,
            ),
            SizedBox(height: 5),
            STButton(
              type: STButtonType.outLine,
              size: STButtonSize.small,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 5),
            STButton(
              text: 'text',
              type: STButtonType.text,
              onTap: _reduceCounter,
            ),
          ],
        ),
      ),
    );
  }
}
