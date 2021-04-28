import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.step,
                width: 300,
                lineWidth: 14.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.line,
                width: 300,
                lineWidth: 14.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.line,
                width: 300,
                lineWidth: 20.0,
                progress: 0.5,
                color: Colors.blue,
                showInnerProgress: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.line,
                  width: 300,
                  lineWidth: 14.0,
                  progress: 0.5,
                  color: Colors.green, //
                  trailingWidget: Icon(Icons.error_outline,
                      size: 20.0, color: Colors.green)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.line,
                  width: 300,
                  lineWidth: 14.0,
                  progress: 0.5,
                  color: Colors.orange,
                  trailingWidget: Icon(Icons.error_outline,
                      size: 20.0, color: Colors.orange)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.line,
                  width: 300,
                  lineWidth: 14.0,
                  progress: 0.5,
                  color: Colors.red,
                  trailingWidget:
                      Icon(Icons.error_outline, size: 20.0, color: Colors.red)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.line,
                  width: 300,
                  lineWidth: 14.0,
                  progress: 0.5,
                  color: Colors.blue,
                  trailingWidget: Text(
                    "75%",
                    style: const TextStyle(fontSize: 16.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.circular,
                radius: 150,
                lineWidth: 8.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.circular,
                  radius: 150,
                  lineWidth: 8.0,
                  progress: 0.5,
                  color: Colors.blue,
                  centerWidget: Text(
                    "75%",
                    style: const TextStyle(fontSize: 16.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.circular,
                  radius: 150,
                  lineWidth: 8.0,
                  progress: 0.5,
                  color: Colors.red,
                  centerWidget:
                      Icon(Icons.error_outline, color: Colors.red, size: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.circular,
                  radius: 150,
                  lineWidth: 8.0,
                  progress: 0.5,
                  color: Colors.blue,
                  isInstrument: true,
                  centerWidget: Text(
                    "10S",
                    style: const TextStyle(fontSize: 16.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.circular,
                  radius: 150,
                  lineWidth: 8.0,
                  progress: 1,
                  color: Colors.green,
                  isInstrument: true,
                  centerWidget: Text(
                    "Done",
                    style: const TextStyle(fontSize: 16.0, color: Colors.green),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
