import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class StepsPage extends StatefulWidget {
  @override
  _StepsPageState createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steps'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          STSteps(
            current: 3,
            steps: [
              STStepItem(title: '文字'),
              STStepItem(title: '文字文'),
              STStepItem(title: '文字文字文字文字文字'),
              STStepItem(title: '文字'),
            ],
          ),
          SizedBox(height: 30),
          Steps(
            current: 3,
            steps: [
              STStepItem(title: '文字'),
              STStepItem(title: '文字文'),
              STStepItem(title: '文字文字文字文字文字'),
              STStepItem(title: '文字'),
            ],
          ),
          SizedBox(height: 30),
          STSteps(
            type: STStepsType.number,
            current: 2,
            steps: [
              STStepItem(title: '文本'),
              STStepItem(title: '文本文本'),
              STStepItem(title: '文本文本文本文本'),
            ],
          ),
          SizedBox(height: 30),
          STSteps(
            type: STStepsType.icon,
            current: 1,
            steps: [
              STStepItem(title: '文本文本'),
              STStepItem(title: '文本'),
              STStepItem(title: '文本文本文本文本'),
            ],
          ),
          SizedBox(height: 30),
          STSteps(
            type: STStepsType.detail,
            steps: [
              STStepItem(title: '文本文本', info: '说明信息'),
              STStepItem(title: '文本文本', info: '说明信息'),
              STStepItem(title: '文本文本', info: '说明信息'),
            ],
          ),
        ],
      ),
    );
  }
}
