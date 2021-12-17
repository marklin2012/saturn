import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

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
            _buildRowThree(),
            _buildRowFour(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowTwo() {
    return STGridView(
      padding: EdgeInsets.symmetric(vertical: 10),
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
                icon: ImageIcon(
                  AssetImage('assets/images/2.png'),
                  color: Color(0xFF1070FF),
                ),
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
                icon: ImageIcon(
                  AssetImage('assets/images/2.png'),
                  color: Color(0xFF1070FF),
                ),
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
              icon: ImageIcon(
                AssetImage('assets/images/2.png'),
                color: Color(0xFF1070FF),
              ),
            ),
          ),
        );
      },
      itemCount: 12,
    );
  }
}
