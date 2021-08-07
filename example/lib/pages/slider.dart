import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _basicValue = 0.5;
  RangeValues _horRangeValue = RangeValues(0.25, 0.75);
  double _conStrValue = 0.3;
  double _disableValue = 0.4;
  double _verValue = 0.6;
  RangeValues _verRangeValue = RangeValues(0.2, 0.7);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width - 32.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('slider'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('基本用法'),
            SizedBox(height: 15),
            STSlider(
              value: _basicValue,
              mainSize: _width,
              onChanged: (value) {
                setState(() {
                  _basicValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('范围可拖拽'),
            SizedBox(height: 15),
            STSlider(
              mainSize: _width,
              rangeValues: _horRangeValue,
              onChangedRange: (value) {
                setState(() {
                  _horRangeValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('含字符的滑块'),
            SizedBox(height: 15),
            STSlider(
              value: _conStrValue,
              mainSize: _width,
              minValue: 0,
              maxValue: 100,
              onChanged: (value) {
                setState(() {
                  _conStrValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('禁用状态'),
            SizedBox(height: 15),
            STSlider(
              value: _disableValue,
              disabled: true,
              mainSize: _width,
              minValue: 0,
              maxValue: 100,
              onChanged: (value) {
                setState(() {
                  _disableValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('垂直拖拽'),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                STSlider(
                  axis: Axis.vertical,
                  value: _verValue,
                  mainSize: 200,
                  onChanged: (value) {
                    setState(() {
                      _verValue = value;
                    });
                  },
                ),
                // SizedBox(width: 100),
                // STSlider(
                //   axis: Axis.vertical,
                //   mainSize: 200,
                //   rangeValues: _verRangeValue,
                //   onChangedRange: (value) {
                //     setState(() {
                //       _verRangeValue = value;
                //     });
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
