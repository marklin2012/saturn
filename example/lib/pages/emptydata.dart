import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class EmptyDataPage extends StatelessWidget {
  const EmptyDataPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('空状态'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              STEmptyData(),
              SizedBox(height: 20),
              STEmptyData(
                icon: Image.asset(
                  'assets/images/default_empty.png',
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(height: 20),
              STEmptyData(
                icon: Image.asset(
                  'assets/images/default_empty.png',
                  width: 80,
                  height: 80,
                ),
                content: '对应内容将显示在这里哦！',
              ),
              SizedBox(height: 20),
              STEmptyData(
                icon: Image.asset(
                  'assets/images/default_empty.png',
                  width: 80,
                  height: 80,
                ),
                content: '对应内容将显示在这里哦！',
                customBtn: STButton(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                  text: '去看看',
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
