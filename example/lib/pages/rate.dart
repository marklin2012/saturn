import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key key}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  double _rate = 2.0;
  ValueNotifier<double> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(_rate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate'),
      ),
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (context, value, _) {
                return STRate(
                  rate: value,
                  onRateTap: (int rate) {
                    _valueNotifier.value = rate.toDouble();
                  },
                );
              },
            ),
            SizedBox(height: 20),
            STButton(
              text: '随机修改',
              onTap: _randomTap,
            ),
          ],
        ),
      ),
    );
  }

  void _randomTap() {
    final _temp = Random().nextDouble() * 5.0;
    _valueNotifier.value = _temp;
  }
}
