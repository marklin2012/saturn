import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class RadioPage extends StatefulWidget {
  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  var _radioGroupValue = '语文';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('radio'),
      ),
      body: Center(
        child: Column(
          children: [
            // SizedBox(height: 20),
            // _buildEditable(),
            SizedBox(height: 20),
            _buildSTRadio(),
          ],
        ),
      ),
    );
  }

  // 系统的Radio
  Widget _buildSTRadio() {
    return Column(
      children: [
        // Text('Saturn的Radio'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            STRadio(
              value: '语文',
              text: '语文',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
            ),
            STRadio(
              value: '数学',
              text: '数学',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
            ),
            STRadio(
              value: '英语',
              text: '英语',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
            ),
            STRadio(
              value: '物理',
              text: '物理',
              disabled: true,
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  // 系统的Radio
  Widget _buildEditable() {
    return Column(
      children: [
        Text('系统的Radio'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: '语文',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
              activeColor: Colors.red,
            ),
            Radio(
              value: '数学',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
            ),
            Radio(
              value: '英语',
              groupValue: _radioGroupValue,
              onChanged: (value) {
                setState(() {
                  _radioGroupValue = value;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
