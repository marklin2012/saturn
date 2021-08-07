import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: STInput(),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: STInput.password(),
            ),
          ],
        ),
      ),
    );
  }
}
