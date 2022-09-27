import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/mobile/st_button/common.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: STUnFocus(
          child: SingleChildScrollView(
        child: _buildContent(),
      )),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: STInput(
            prefixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                STButton(
                  type: STButtonType.text,
                  text: '+86',
                  textStyle: TextStyle(color: Colors.black, fontSize: 16),
                  onTap: () {},
                ),
                Icon(
                  STIcons.direction_caretdown,
                  color: Colors.black,
                ),
              ],
            ),
            placeholder: '请输入',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: STInput.password(),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: STInput(
            placeholder: '请输入验证码',
            suffixIcon: STButton(
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              text: '获取验证码',
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              onTap: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: _buildSearch(),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: STInput(
            isAround: true,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: STInput(
            isAround: true,
            maxLength: 200,
          ),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: STInput(
              height: 32,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '文字',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      STIcons.commonly_search_outline,
                      color: STColor.secRankGrey,
                      size: 24,
                    ),
                  ),
                ],
              ),
              placeholder: '请输入搜索关键字',
              cursorHeight: 22,
              contentPadding: EdgeInsets.only(bottom: 4.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              '文字',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
