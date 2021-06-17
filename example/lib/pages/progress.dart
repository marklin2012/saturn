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
                type: STProgressType.primary,
                size: 300,
                progress: 0.5,
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
            //percent
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
                type: STProgressType.percent,
                status: STProgressStatus.error,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                status: STProgressStatus.warning,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                status: STProgressStatus.done,
                size: 300,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),

            //circle
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: STProgress(
            //       type: STProgressType.stepDot,
            //       stepCount: 5,
            //       progress: 0.6,
            //       color: Colors.blue,
            //       trailingWidget: Icon(Icons.east_outlined,
            //           size: 20.0, color: Colors.green)),
            // ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepDot,
                status: STProgressStatus.primary,
                stepCount: 5,
                progress: 0.6,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepDot,
                status: STProgressStatus.warning,
                stepCount: 5,
                progress: 0.6,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepDot,
                status: STProgressStatus.error,
                stepCount: 5,
                progress: 0.6,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepDot,
                status: STProgressStatus.done,
                stepCount: 5,
                progress: 0.6,
                color: Colors.blue,
              ),
            ),

            //rect

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                status: STProgressStatus.warning,
                size: 200,
                stepCount: 9,
                progress: 0.2,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                status: STProgressStatus.error,
                size: 200,
                stepCount: 9,
                progress: 0.2,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                status: STProgressStatus.done,
                size: 200,
                stepCount: 9,
                progress: 0.2,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                size: 200,
                stepCount: 9,
                progress: 0.2,
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
                status: STProgressStatus.error,
                height: 8.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.circle,
                status: STProgressStatus.warning,
                height: 8.0,
                progress: 0.5,
                color: Colors.blue,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: STProgress(
                  type: STProgressType.circle,
                  status: STProgressStatus.done,
                  height: 8.0,
                  progress: 0.5,
                  color: Colors.red,
                )),

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
                status: STProgressStatus.error,
                height: 8,
                progress: 1,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.dashboard,
                status: STProgressStatus.warning,
                height: 8,
                progress: 1,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.dashboard,
                status: STProgressStatus.done,
                height: 8,
                progress: 1,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
