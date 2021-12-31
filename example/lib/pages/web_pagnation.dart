import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebPaginationPage extends StatefulWidget {
  const WebPaginationPage({Key key}) : super(key: key);

  @override
  _WebPaginationPageState createState() => _WebPaginationPageState();
}

class _WebPaginationPageState extends State<WebPaginationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('WebPagination'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBasic(),
            _buildPageSize(),
            _buildPageSizeJump(),
            _buildPageSizeDisable(),
            _buildPageSmall(),
            _buildPageSimple(),
            _buildPageSizeText(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageSizeText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('文字'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(
            total: 500,
            showTotal: true,
            showQuickJumper: true,
            turnPages: ['上一页', '下一页'],
          ),
        ),
      ],
    );
  }

  Widget _buildPageSmall() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('小型'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(
            total: 50,
            showSizeChanger: true,
            showQuickJumper: true,
            type: STPaginationType.small,
          ),
        ),
      ],
    );
  }

  Widget _buildPageSimple() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('简洁'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                child: STPagination(
                  total: 990,
                  type: STPaginationType.simple,
                ),
              ),
              Container(
                width: 200,
                child: STPagination(
                  total: 990,
                  disabled: true,
                  type: STPaginationType.simple,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageSizeDisable() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('页数'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(
            total: 500,
            disabled: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPageSizeJump() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('跳转'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(
            total: 500,
            showQuickJumper: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPageSize() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('页数'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(
            total: 500,
          ),
        ),
      ],
    );
  }

  Widget _buildBasic() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('基础用法'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(
            total: 50,
          ),
        ),
      ],
    );
  }
}
