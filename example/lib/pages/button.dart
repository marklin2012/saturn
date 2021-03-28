import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  int _counter = 0;
  bool _firBtnLoading = false;
  bool _secBtnDisable = true;

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
            STButton(
              type: STButtonType.danger,
              onTap: _reduceCounter,
              loading: _firBtnLoading,
            ),
            SizedBox(height: 5),
            STButton.icon(
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              disable: _secBtnDisable,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 5),
            STButton(
              text: 'change fir state',
              style: STButtonStyle.outLine,
              type: STButtonType.success,
              onTap: () {
                _firBtnLoading = !_firBtnLoading;
                setState(() {});
              },
            ),
            SizedBox(height: 5),
            STButton(
              text: 'change sec disable',
              style: STButtonStyle.text,
              onTap: () {
                _secBtnDisable = !_secBtnDisable;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
