import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class WebDropdownPage extends StatefulWidget {
  const WebDropdownPage({Key key}) : super(key: key);

  @override
  _WebDropdownPageState createState() => _WebDropdownPageState();
}

class _WebDropdownPageState extends State<WebDropdownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebDropdown'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              STDropdown(
                triggerData: STDropdownTriggerData(
                  title: '下拉菜单按钮',
                  isArrow: true,
                  icon: STIcons.commonly_user_outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
