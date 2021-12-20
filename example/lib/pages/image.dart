import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/mobile/st_button/common.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDefault(),
            _buildFit(),
            _buildCircle(),
            _buildType(),
          ],
        ),
      ),
    );
  }

  Widget _buildDefault() {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: STColor.backgroundColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              STImage.avatar(),
              STImage.logo(),
              STImage.team(),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              STImage.holder(
                iconWidth: 50,
                scale: STImageScale.scale1v1,
              ),
              STImage.holder(
                iconWidth: 100,
                scale: STImageScale.scale16v9,
              ),
              STImage.holder(
                iconWidth: 80,
                scale: STImageScale.scale4v3,
              ),
              STImage.holder(
                iconWidth: 90,
                scale: STImageScale.scale3v2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFit() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          STImage.holder(
            iconWidth: 210,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10),
          STImage.holder(
            iconWidth: 210,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
          STImage.holder(
            iconWidth: 210,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          STImage.holder(
            width: 210,
            iconWidth: 350,
            fit: BoxFit.none,
          ),
        ],
      ),
    );
  }

  Widget _buildCircle() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          STImage.holder(
            iconWidth: 210,
            fit: BoxFit.fill,
            isCircle: true,
          ),
          SizedBox(height: 10),
          STImage.holder(
            iconWidth: 210,
            fit: BoxFit.contain,
            isCircle: true,
          ),
          SizedBox(height: 10),
          STImage.holder(
            iconWidth: 210,
            fit: BoxFit.cover,
            isCircle: true,
          ),
          SizedBox(height: 10),
          STImage.holder(
            width: 210,
            iconWidth: 350,
            fit: BoxFit.none,
            isCircle: true,
          ),
        ],
      ),
    );
  }

  Widget _buildType() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          STImage.diffType(
            width: 320,
            type: STImageType.loading,
          ),
          SizedBox(height: 10),
          STImage.diffType(
            width: 320,
            type: STImageType.fail,
          ),
          SizedBox(height: 10),
          STImage.diffType(
            width: 320,
            type: STImageType.custom,
            customChild: Icon(Icons.sms_failed),
          ),
        ],
      ),
    );
  }
}
