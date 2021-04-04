import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

// ignore: must_be_immutable
class TooltipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tooltip'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Tooltip(
              message: '这是系统的tooltip',
              child: Icon(Icons.storage),
            ),
            SizedBox(height: 50),
            STTooltip(
              message: 'Light 提示文字',
              backgroundColor: Colors.white,
              child: Text('Light'),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 80),
            STTooltip(
              message: 'Presets 提示文字',
              backgroundColor: Colors.red,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('presets'),
              ),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 80),
            STTooltip(
              message:
                  '这是ST的tooltip这是ST的tooltip这是ST的tooltip,这是ST的tooltip这是ST的tooltip这是ST的tooltip',
              child: Icon(Icons.settings),
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
