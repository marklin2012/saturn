import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _sliderValue = 0;
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
            STSlider(
              axis: Axis.vertical,
            ),
            SizedBox(height: 10),
            STSlider(
              startText: '0',
              endText: '100',
            ),
          ],
        ),
      ),
    );
  }
}
