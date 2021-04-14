import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  STSelectMixData _mixData = STSelectMixData(title: '混合型');
  STSelectTextsData _textsData = STSelectTextsData(
      firTitle: '文本fir1', secTitle: '文本sec1', thrTitle: '文本thr1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: Column(children: [
        SizedBox(height: 50),
        STSelect(
          enums: STSelectEnums.mix,
          initialMix: _mixData,
          mixList: [
            STSelectMixData(title: '混合型'),
            STSelectMixData(title: '一类型'),
            STSelectMixData(title: '二类型', icon: Icons.star),
            STSelectMixData(title: '三类型', icon: Icons.book),
            STSelectMixData(title: '四类型', disabled: true),
            STSelectMixData(title: '五类型'),
            STSelectMixData(title: '六类型'),
          ],
          onSelectedMix: (STSelectMixData value) {
            setState(() {
              _mixData = value;
            });
          },
        ),
        SizedBox(height: 50),
        STSelect(
          enums: STSelectEnums.texts,
          initialTexts: _textsData,
          textsList: [
            STSelectTextsData(
                firTitle: '文本fir1', secTitle: '文本sec1', thrTitle: '文本thr1'),
            STSelectTextsData(
                firTitle: '文本fir2', secTitle: '文本sec2', thrTitle: '文本thr2'),
            STSelectTextsData(
                firTitle: '文本fir3', secTitle: '文本sec3', thrTitle: '文本thr3'),
            STSelectTextsData(
                firTitle: '文本fir4', secTitle: '文本sec4', thrTitle: '文本thr4'),
            STSelectTextsData(
                firTitle: '文本fir5', secTitle: '文本sec5', thrTitle: '文本thr5'),
            STSelectTextsData(
                firTitle: '文本fir6', secTitle: '文本sec6', thrTitle: '文本thr6'),
            STSelectTextsData(
                firTitle: '文本fir7', secTitle: '文本sec7', thrTitle: '文本thr7'),
            STSelectTextsData(
                firTitle: '文本fir8', secTitle: '文本sec8', thrTitle: '文本thr8'),
            STSelectTextsData(
                firTitle: '文本fir9', secTitle: '文本sec9', thrTitle: '文本thr9'),
          ],
          title: '标题',
          child: Text('文本Select'),
          onSelectedText: (value) {
            setState(() {
              _textsData = value;
            });
          },
        )
      ]),
    );
  }
}
