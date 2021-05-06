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
                type: STProgressType.stepDot,
                width: 200,
                height: 40,
                stepCount: 9,
                progress: 0.6,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                width: 200,
                height: 40,
                stepCount: 9,
                progress: 2,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.primary,
                width: 300,
                height: 14.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                width: 300,
                height: 20.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.primary,
                  width: 300,
                  height: 14.0,
                  progress: 0.5,
                  color: Colors.green, //
                  trailingWidget: Icon(Icons.error_outline,
                      size: 20.0, color: Colors.green)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.primary,
                  width: 300,
                  height: 14.0,
                  progress: 0.5,
                  color: Colors.orange,
                  trailingWidget: Icon(Icons.error_outline,
                      size: 20.0, color: Colors.orange)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.primary,
                  width: 300,
                  height: 14.0,
                  progress: 0.5,
                  color: Colors.red,
                  trailingWidget:
                      Icon(Icons.error_outline, size: 20.0, color: Colors.red)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.primary,
                  width: 300,
                  height: 14.0,
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
                type: STProgressType.circle,
                radius: 150,
                height: 8.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.circle,
                  radius: 150,
                  height: 8.0,
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
                  type: STProgressType.circle,
                  radius: 150,
                  height: 8.0,
                  progress: 0.5,
                  color: Colors.red,
                  centerWidget:
                      Icon(Icons.error_outline, color: Colors.red, size: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.dashboard,
                  radius: 150,
                  height: 8.0,
                  progress: 0.5,
                  color: Colors.blue,
                  centerWidget: Text(
                    "10S",
                    style: const TextStyle(fontSize: 16.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.dashboard,
                  radius: 150,
                  height: 8.0,
                  progress: 1,
                  color: Colors.green,
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
