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
      // body: Center(
      //   child: STSteps(
      //     type: STStepsType.detail,
      //     items: [
      //       STStepItem(title: '文本文本', info: '说明信息'),
      //       STStepItem(title: '文本文本', info: '说明信息'),
      //       STStepItem(title: '文本文本', info: '说明信息'),
      //     ],
      //   ),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          STSteps(
            finishedIndex: 3,
            items: [
              STStepItem(title: '文字'),
              STStepItem(title: '文字文字'),
              STStepItem(title: '文字文字文字'),
              STStepItem(title: '文字'),
            ],
          ),
          SizedBox(height: 30),
          STSteps(
            type: STStepsType.number,
            finishedIndex: 2,
            items: [
              STStepItem(title: '文本'),
              STStepItem(title: '文本文本'),
              STStepItem(title: '文本文本'),
            ],
          ),
          SizedBox(height: 30),
          STSteps(
            type: STStepsType.icon,
            finishedIndex: 1,
            items: [
              STStepItem(title: '文本文本'),
              STStepItem(title: '文本'),
              STStepItem(title: '文本文本'),
            ],
          ),
          SizedBox(height: 30),
          STSteps(
            type: STStepsType.detail,
            items: [
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
