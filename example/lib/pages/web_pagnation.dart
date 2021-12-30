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
          ],
        ),
      ),
    );
  }

  Widget _buildBasic() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('基础用法'),
        Container(
          height: 190,
          color: STColor.fourRankGrey,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: STPagination(),
        ),
      ],
    );
  }
}
