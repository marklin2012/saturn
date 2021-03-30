import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';
import 'package:saturn/st_button/common.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  int _counter = 0;
  bool _loading = false;
  bool _disabled = true;

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

  void _showLoading() {
    if (_loading == false) {
      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          _loading = false;
        });
      });
    }
    setState(() {
      _loading = !_loading;
    });
  }

  void _changeDisable() {
    setState(() {
      _disabled = !_disabled;
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
            // 主按钮
            STButton(
              onTap: _reduceCounter,
              loading: _loading,
              text: '主按钮',
            ),
            SizedBox(height: 5),
            // 主按钮
            STButton(
              text: '图标按钮',
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              loading: _loading,
            ),
            SizedBox(height: 5),
            STButton(
              text: '成功',
              type: STButtonType.success,
              onTap: _reduceCounter,
              loading: _loading,
            ),
            SizedBox(height: 5),
            STButton(
              text: '警告',
              type: STButtonType.danger,
              onTap: _reduceCounter,
              loading: _loading,
            ),
            SizedBox(height: 5),
            STButton(
              text: '警告',
              type: STButtonType.danger,
              onTap: _reduceCounter,
              loading: _loading,
            ),
            SizedBox(height: 5),
            STButton.icon(
              icon: Icon(
                Icons.star,
                color: Colors.white,
              ),
              disabled: _disabled,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 5),
            STButton(
              text: 'change state',
              icon: Icon(
                Icons.star,
                color: Colors.blue,
              ),
              type: STButtonType.outline,
              onTap: _showLoading,
            ),
            SizedBox(height: 5),
            STButton(
              text: 'change state',
              type: STButtonType.outline,
              onTap: _showLoading,
            ),
            SizedBox(height: 5),
            STButton(
              text: 'change disable',
              type: STButtonType.text,
              onTap: _changeDisable,
            ),
            SizedBox(height: 5),
            STButton(
              type: STButtonType.outline,
              text: 'success outline',
              borderColor: STColor.assistGreen,
              textStyle: TextStyle(color: STColor.assistGreen),
            ),
            SizedBox(height: 5),
            STButton.icon(
              backgroundColor: STColor.assistRed,
              icon: Icon(Icons.assignment_late_outlined, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
