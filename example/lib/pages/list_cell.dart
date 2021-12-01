import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_button/common.dart';

class ListCellPage extends StatefulWidget {
  const ListCellPage({Key key}) : super(key: key);

  @override
  _ListCellPageState createState() => _ListCellPageState();
}

class _ListCellPageState extends State<ListCellPage> {
  bool _radioValue = false;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ListCell'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: _buildConent(),
      ),
    );
  }

  Widget _buildConent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text('单行列表'),
          ),
          STRowOption(
            leading: Text('列表0'),
          ),
          STRowOption(
            leading: Text('列表1'),
            trailing: Text(
              '说明信息',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: STColor.secRankFont,
              ),
            ),
            trailingPadding: EdgeInsets.only(right: 4.0),
            rightArrowIconSize: 18,
            isHavRightArrow: true,
          ),
          STRowOption(
            leading: Text('列表2'),
            trailing: STRadio(
              value: _radioValue,
              groupValue: true,
              onChanged: (bool value) {
                _radioValue = !value;
                setState(() {});
              },
            ),
          ),
          STRowOption(
            leading: Text('列表3'),
            trailing: STSwitch(
              value: _switchValue,
              onChanged: (bool value) {
                _switchValue = value;
                setState(() {});
              },
            ),
          ),
          STRowOption(
            leading: Image(
              image: AssetImage('assets/images/default_avatar.png'),
              width: 32,
              height: 32,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            center: Text('列表4'),
            trailing: Image(
              image: AssetImage('assets/images/2.png'),
              width: 24,
              height: 24,
            ),
          ),
          STRowOption(
            leading: Image(
              image: AssetImage('assets/images/2.png'),
              width: 24,
              height: 24,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            center: Text('列表5'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text('两行列表'),
          ),
          STRowOption(
            center: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('列表0'),
                Text('文字信息文字信息'),
              ],
            ),
          ),
          STRowOption(
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('列表1'),
                SizedBox(height: 8.0),
                Text('文字信息文字信息'),
              ],
            ),
            trailing: STSwitch(
              value: _switchValue,
              onChanged: (bool value) {
                _switchValue = value;
                setState(() {});
              },
            ),
          ),
          STRowOption(
            leading: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Image(
                image: AssetImage('assets/images/default_avatar.png'),
                width: 32,
                height: 32,
              ),
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('列表1'),
                SizedBox(height: 8.0),
                Text('文字信息文字信息'),
              ],
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                '说明',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: STColor.thrRankFont,
                ),
              ),
            ),
          ),
          STRowOption(
            leading: Image(
              image: AssetImage('assets/images/default_avatar.png'),
              width: 32,
              height: 32,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            center: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('列表1'),
                SizedBox(height: 8.0),
                Text('文字信息文字信息'),
              ],
            ),
            trailing: Image(
              image: AssetImage('assets/images/2.png'),
              width: 24,
              height: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text('三行列表'),
          ),
          STRowOption(
            leading: Image(
              image: AssetImage('assets/images/default_avatar.png'),
              width: 32,
              height: 32,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('列表1'),
                SizedBox(height: 4.0),
                Text('文字信息文字信息'),
                SizedBox(height: 4.0),
                Text('辅助文字说明信息辅助文字说明信息'),
              ],
            ),
          ),
          STRowOption(
            leading: Image(
              image: AssetImage('assets/images/default_empty.png'),
              width: 76,
              height: 76,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('列表1'),
                SizedBox(height: 4.0),
                Text('文字信息文字信息'),
                SizedBox(height: 4.0),
                Text('辅助文字说明信息辅助文字说明信息'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
