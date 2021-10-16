import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: STInput(
              cursorColor: Colors.red,
              prefixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  STButton(
                    type: STButtonType.text,
                    text: '+86',
                    onTap: () {},
                  ),
                  Icon(
                    STIcons.direction_caretdown,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: STInput.password(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: STInput(
              suffixIcon: STButton(
                text: '获取验证码',
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: STInput(
              height: 32,
              placeholder: '请输入账号',
              cursorHeight: 24,
              contentPadding: EdgeInsets.only(bottom: 16),
            ),
          ),
        ],
      ),
    );
  }
}
