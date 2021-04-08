import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _sliderValue = 0;
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
            SizedBox(height: 5),
            Slider(
              value: _sliderValue,
              label: '$_sliderValue',
              divisions: 4,
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                STSlider(
                  axis: Axis.vertical,
                  value: _sliderValue,
                  minValue: 0,
                  maxValue: 1000,
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
