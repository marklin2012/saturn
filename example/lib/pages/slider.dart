import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _sliderValue = 0.5;
  RangeValues _sliderRangeValue = RangeValues(0.2, 0.5);
  bool sliderDisabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('slider'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('系统Slider'),
            Slider(
              value: _sliderValue,
              label: '$_sliderValue',
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 10),
            Text('自定义Slider'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                STSlider(
                  axis: Axis.vertical,
                  value: _sliderValue,
                  mainSize: 300,
                  dotSize: 12,
                  activeSize: 4,
                  inactiveColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
                STSlider(
                  axis: Axis.vertical,
                  rangeValues: _sliderRangeValue,
                  minValue: 0,
                  maxValue: 1000,
                  dotSize: 12,
                  activeSize: 4,
                  inactiveColor: Colors.white,
                  onChangedRange: (value) {
                    setState(() {
                      _sliderRangeValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            STSlider(
              value: _sliderValue,
              mainSize: 340,
              activeSize: 4,
              dotSize: 12,
              inactiveColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            STSlider(
              disabled: sliderDisabled,
              rangeValues: _sliderRangeValue,
              dotSize: 12,
              activeSize: 4,
              minValue: 0,
              maxValue: 1000,
              inactiveColor: Colors.white,
              onChangedRange: (value) {
                setState(() {
                  _sliderRangeValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            STButton(
              text: 'change disable',
              type: STButtonType.text,
              onTap: () {
                setState(() {
                  sliderDisabled = !sliderDisabled;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
