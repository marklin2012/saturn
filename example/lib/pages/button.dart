import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';
import 'package:saturn/st_button/common.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _loading = false;
  bool _disabled = true;
  ValueNotifier<int> _counterNoti;

  void _incrementCounter() {
    _counterNoti.value++;
  }

  void _reduceCounter() {
    _counterNoti.value--;
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
  void initState() {
    super.initState();
    _counterNoti = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('buttons'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: _counterNoti,
            builder: (context, int value, child) {
              return Text('$value');
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STButton(
                size: STButtonSize.small,
                onTap: _reduceCounter,
                loading: _loading,
                text: '小按钮',
              ),
              STButton(
                onTap: _reduceCounter,
                loading: _loading,
                text: '主按钮',
              ),
              STButton(
                text: '图标按钮',
                icon: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                loading: _loading,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STButton.icon(
                icon: Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                size: STButtonSize.small,
              ),
              STButton.icon(
                icon: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                disabled: _disabled,
                onTap: _incrementCounter,
              ),
              STButton.icon(
                backgroundColor: STColor.assistRed,
                icon: Icon(Icons.assignment_late_outlined, color: Colors.white),
              ),
              STButton(
                text: '成功',
                type: STButtonType.success,
                onTap: _reduceCounter,
                loading: _loading,
              ),
              STButton(
                text: '警告',
                type: STButtonType.danger,
                onTap: _reduceCounter,
                loading: _loading,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STButton(
                text: 'change state',
                icon: Icon(
                  Icons.star,
                  color: Color(0xFF095BF9),
                ),
                type: STButtonType.outline,
                onTap: _showLoading,
              ),
              STButton(
                text: 'change disable',
                type: STButtonType.text,
                onTap: _changeDisable,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STButton(
                type: STButtonType.outline,
                text: 'success outline',
                borderColor: STColor.assistGreen,
                textStyle: TextStyle(color: STColor.assistGreen),
              ),
            ],
          )
        ],
      ),
    );
  }
}
