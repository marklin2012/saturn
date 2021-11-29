import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_icons/st_icons.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildRowTwo(),
            SizedBox(height: 10),
            _buildRowThree(),
            SizedBox(height: 10),
            _buildRowFour(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildRowTwo() {
    return STGridView(
      padding: EdgeInsets.only(top: 10),
      backgroundColor: Color(0xFFDFE2E7),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 187 / 78,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            debugPrint('点击了$index');
          },
          child: Container(
            color: Color(0xFFFAFCFF),
            height: 78,
            child: Center(
              child: STTextAndIcon(
                text: Text('文字'),
                icon: Icon(STIcons.commonly_calendar),
              ),
            ),
          ),
        );
      },
      itemCount: 6,
    );
  }

  Widget _buildRowThree() {
    return STGridView(
      backgroundColor: Color(0xFFDFE2E7),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 124 / 78,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.red,
          onTap: () {
            debugPrint('点击了$index');
          },
          child: Container(
            color: Colors.white,
            height: 78,
            child: Center(
              child: STTextAndIcon(
                text: Text('文字'),
                icon: Icon(STIcons.commonly_calendar),
              ),
            ),
          ),
        );
      },
      itemCount: 9,
    );
  }

  Widget _buildRowFour() {
    return STGridView(
      backgroundColor: Color(0xFFDFE2E7),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 93 / 78,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Color(0xFFFAFCFF),
          height: 78,
          child: Center(
            child: STTextAndIcon(
              text: Text('文字'),
              icon: Icon(STIcons.commonly_calendar),
              textDirection: STTextDirection.textRight,
            ),
          ),
        );
      },
      itemCount: 12,
    );
  }
}
