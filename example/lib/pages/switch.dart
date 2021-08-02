import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class SwitchPage extends StatefulWidget {
  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('switch'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            STSwitch(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              activeColor: Colors.blue,
            ),
            SizedBox(height: 20),
            STSwitch(
              value: _value,
              text: '文字',
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            SizedBox(height: 20),
            STSwitch(
              value: _value,
              text: '文字',
              disabled: true,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
