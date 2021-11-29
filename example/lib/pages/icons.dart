import 'package:flutter/material.dart';

final List<int> commonIcons = [
  0xe800,
  0xe801,
  0xe802,
  0xe803,
  0xe804,
  0xe805,
  0xe806,
  0xe807,
  0xe808,
  0xe809,
  0xe80a,
  0xe80b,
  0xe80c,
  0xe80d,
  0xe80e,
  0xe80f,
  0xe810,
  0xe811,
  0xe812,
  0xe813,
  0xe814,
  0xe815,
  0xe816,
  0xe817,
  0xe818,
  0xe819,
  0xe81a,
  0xe81b,
  0xe81c,
  0xe81d,
  0xe81e,
  0xe81f,
  0xe820,
  0xe821,
  0xe822,
  0xe823,
  0xe824,
  0xe825,
  0xe826,
  0xe827,
  0xe828,
  0xe829,
  0xe82a,
  0xe82b,
  0xe82c,
  0xe82d,
  0xe82e,
  0xe82f,
  0xe830,
  0xe831,
  0xe832,
  0xe833,
  0xe834,
  0xe835,
  0xe836,
  0xe837,
  0xe838,
  0xe839,
  0xe83a,
  0xe83b,
  0xe83c,
  0xe83d,
  0xe83e,
  0xe83f,
  0xe840,
  0xe841,
  0xe842,
  0xe843,
  0xe844,
  0xe845,
  0xe846,
  0xe847,
  0xe848,
  0xe849,
  0xe84a,
  0xe84b,
  0xe84c,
  0xe84d,
];

final List<int> dataIcons = [
  0xe84e,
  0xe84f,
  0xe850,
  0xe851,
  0xe852,
  0xe853,
  0xe854,
  0xe855,
  0xe856,
];

final List<int> directionIcons = [
  0xe857,
  0xe858,
  0xe859,
  0xe85a,
  0xe85b,
  0xe85c,
  0xe85d,
  0xe85e,
  0xe85f,
  0xe860,
  0xe861,
  0xe862,
  0xe863,
  0xe864,
  0xe865,
  0xe866,
  0xe867,
  0xe868,
  0xe869,
  0xe86a,
  0xe86b,
  0xe86c,
  0xe86d,
  0xe86e,
  0xe86f,
  0xe870,
  0xe871,
  0xe872,
  0xe873,
  0xe874,
];

final List<int> newsLetterIcons = [
  0xe875,
  0xe876,
  0xe877,
  0xe878,
  0xe879,
  0xe87a,
  0xe87b,
  0xe87c,
  0xe87d,
  0xe87e,
  0xe87f,
  0xe880,
  0xe881,
  0xe882,
  0xe883,
  0xe884,
  0xe885,
  0xe886,
];

final List<int> statusIcons = [
  0xe887,
  0xe888,
  0xe889,
  0xe88a,
  0xe88b,
  0xe88c,
  0xe88d,
  0xe88e,
  0xe88f,
  0xe890,
  0xe891,
  0xe892,
  0xe893,
  0xe894,
  0xe895,
  0xe896,
  0xe897,
  0xe898,
  0xe899,
  0xe89a,
  0xe89b,
];

class IconPage extends StatelessWidget {
  Widget titleFrom(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget iconListFrom(List<int> icons) {
    return Wrap(
        children: icons
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    IconData(
                      e,
                      fontFamily: 'STIcons',
                    ),
                    size: 32,
                    color: Colors.blue[400],
                  ),
                ))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleFrom('常用类'),
                iconListFrom(commonIcons),
                titleFrom('数据类'),
                iconListFrom(dataIcons),
                titleFrom('方向类'),
                iconListFrom(directionIcons),
                titleFrom('消息类'),
                iconListFrom(newsLetterIcons),
                titleFrom('状态类'),
                iconListFrom(statusIcons),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
