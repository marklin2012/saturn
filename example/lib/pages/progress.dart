import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _progress += 0.1;
          });
        },
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
                stepCount: 5,
                progress: 0.6,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                size: 200,
                stepCount: 9,
                progress: _progress,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.primary,
                status: STProgressStatus.done,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.primary,
                status: STProgressStatus.error,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.primary,
                status: STProgressStatus.warning,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.primary,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.primary,
                  size: 300,
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
                  size: 300,
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
                  size: 300,
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
                size: 300,
                height: 14.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.circle,
                height: 8.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                  type: STProgressType.circle,
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
                  size: 180,
                  height: 12,
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
