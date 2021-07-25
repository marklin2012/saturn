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
      backgroundColor: Colors.white,
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("基本用法",
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: STDialogConstant.titleFontSize,
                        decoration: TextDecoration.none)),
              ),
            ),
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("内嵌样式",
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: STDialogConstant.titleFontSize,
                        decoration: TextDecoration.none)),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                size: 200,
                progress: 0.25,
                color: Colors.blue.withAlpha(50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                size: 200,
                progress: 0.50,
                color: Colors.blue.withAlpha(170),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                size: 200,
                progress: 0.95,
                color: Colors.blue,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.percent,
                status: STProgressStatus.done,
                size: 300,
                progress: 1,
                color: Colors.blue,
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("步骤进度",
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: STDialogConstant.titleFontSize,
                        decoration: TextDecoration.none)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepDot,
                size: 280,
                height: 15,
                stepCount: 20,
                progress: 0.5,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                size: 280,
                height: 20,
                stepCount: 20,
                progress: 0.75,
                color: Colors.blue,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: STProgress(
                type: STProgressType.stepRect,
                status: STProgressStatus.done,
                size: 280,
                stepCount: 30,
                progress: 1,
                color: Colors.blue,
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("进度圈",
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: STDialogConstant.titleFontSize,
                        decoration: TextDecoration.none)),
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: STProgress(
                    type: STProgressType.circle,
                    height: 8.0,
                    progress: 0,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: STProgress(
                    type: STProgressType.circle,
                    height: 8.0,
                    progress: 0.75,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: STProgress(
                    type: STProgressType.circle,
                    status: STProgressStatus.error,
                    height: 8.0,
                    progress: 0.8,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: STProgress(
                    type: STProgressType.circle,
                    status: STProgressStatus.done,
                    height: 8.0,
                    progress: 1,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("仪表盘",
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: STDialogConstant.titleFontSize,
                        decoration: TextDecoration.none)),
              ),
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: STProgress(
                  type: STProgressType.dashboard,
                  height: 8.0,
                  progress: 0.5,
                  centerWidget: Text("10s",
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: STDialogConstant.titleFontSize,
                          decoration: TextDecoration.none)),
                  color: Colors.blue,
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
            ]),
          ],
        ),
      ),
    );
  }
}
