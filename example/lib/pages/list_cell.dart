import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/mobile/st_button/common.dart';

class ListCellPage extends StatefulWidget {
  const ListCellPage({Key key}) : super(key: key);

  @override
  _ListCellPageState createState() => _ListCellPageState();
}

class _ListCellPageState extends State<ListCellPage> {
  bool _radioValue = false;
  bool _switchValue = false;
  final _boldStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: STColor.backgroundColor,
      appBar: AppBar(
        title: Text('ListCell'),
      ),
      body: _buildConent(),
    );
  }

  Widget _buildConent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildOneRow(),
          _buildSecondRow(),
          _buildThreeRow(),
        ],
      ),
    );
  }

  Widget _buildThreeRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Text('三行列表'),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: STImage.avatar(width: 36),
            leadingPadding: const EdgeInsets.only(right: 12.0, top: 12.0),
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '列表',
                    style: _boldStyle,
                  ),
                  SizedBox(height: 4.0),
                  Text('文字信息文字信息'),
                  SizedBox(height: 4.0),
                  Text('辅助文字说明信息辅助文字说明信息'),
                ],
              ),
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: Image(
              image: AssetImage('assets/images/default_empty.png'),
              width: 76,
              height: 76,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0, top: 12.0),
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '列表',
                    style: _boldStyle,
                  ),
                  SizedBox(height: 4.0),
                  Text('文字信息文字信息'),
                  SizedBox(height: 4.0),
                  Text('辅助文字说明信息辅助文字说明信息'),
                ],
              ),
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Text('两行列表'),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: STImage.avatar(width: 36),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            center: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '列表',
                    style: _boldStyle,
                  ),
                  SizedBox(height: 8.0),
                  Text('文字信息文字信息'),
                ],
              ),
            ),
            trailing: Image(
              image: AssetImage('assets/images/2.png'),
              width: 24,
              height: 24,
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '列表',
                    style: _boldStyle,
                  ),
                  SizedBox(height: 8.0),
                  Text('文字信息文字信息'),
                ],
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 4),
              child: STSwitch(
                value: _switchValue,
                onChanged: (bool value) {
                  _switchValue = value;
                  setState(() {});
                },
              ),
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: STImage.avatar(width: 36),
            leadingPadding: const EdgeInsets.only(right: 12.0, top: 19.0),
            contentCrossAlignment: CrossAxisAlignment.start,
            center: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '列表',
                    style: _boldStyle,
                  ),
                  SizedBox(height: 8.0),
                  Text('文字信息文字信息'),
                ],
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                '说明',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: STColor.thrRankFont,
                ),
              ),
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildOneRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Text('单行列表'),
        ),
        _addPaddingBottom(
          child: STRowOption(
            backgroundColor: Colors.white,
            leading: Text('列表'),
            isHavBottomLine: false,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: Text('列表'),
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
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: Text('列表'),
            trailing: STSwitch(
              value: _switchValue,
              onChanged: (bool value) {
                _switchValue = value;
                setState(() {});
              },
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: Text('列表'),
            trailing: STRadio(
              value: _radioValue,
              groupValue: true,
              onChanged: (bool value) {
                _radioValue = !value;
                setState(() {});
              },
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: Image(
              image: AssetImage('assets/images/2.png'),
              width: 24,
              height: 24,
            ),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            center: Text('列表'),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
        _addPaddingBottom(
          child: STRowOption(
            leading: STImage.avatar(width: 36),
            leadingPadding: const EdgeInsets.only(right: 12.0),
            center: Text('列表'),
            trailing: Image(
              image: AssetImage('assets/images/2.png'),
              width: 24,
              height: 24,
            ),
            isHavBottomLine: false,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _addPaddingBottom({Widget child}) {
    return Padding(padding: EdgeInsets.only(bottom: 8), child: child);
  }
}
