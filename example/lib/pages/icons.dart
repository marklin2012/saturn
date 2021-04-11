import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class IconPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Icon(STIcons.direction_verticalalignbottom,
                  size: 24, color: Colors.cyan),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Icon(STIcons.status_minuscircle,
                  size: 24, color: Colors.cyan),
            ),
          ],
        ),
      ),
    );
  }
}
