import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class StepperPage extends StatefulWidget {
  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('整个stepper禁用'),
            SizedBox(height: 5),
            STStepper(
              disabled: true,
            ),
            SizedBox(height: 20),
            Text('设置最小值，value与最小值相同，减号禁用'),
            SizedBox(height: 5),
            STStepper(
              value: 1,
              minValue: 1,
            ),
            SizedBox(height: 20),
            Text('设置最大值，点击加减号，会触发加减号禁用'),
            SizedBox(height: 5),
            STStepper(
              value: 2,
              maxValue: 5,
            ),
          ],
        ),
      ),
    );
  }
}
