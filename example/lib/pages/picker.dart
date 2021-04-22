import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:saturn/saturn.dart';

class PickerPage extends StatefulWidget {
  @override
  _PickerPageState createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  DateTime _selectedTime = DateTime.now();
  Duration _duration = Duration(hours: 2, minutes: 20, seconds: 30);
  String _datePickerStr = 'DatePicker';
  String _timePickerStr = 'timePicker';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picker'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            STPicker.date(
              minimumYear: 2012,
              maximunYear: 2025,
              initDateTime: _selectedTime,
              onDateTimeChanged: (value) {
                _selectedTime = value;
                _datePickerStr = value.toString();
                setState(() {});
              },
              child: Text(_datePickerStr),
            ),
            SizedBox(height: 30),
            STPicker.time(
              child: Text(_timePickerStr),
              initDuration: _duration,
              onTimerDurationChanged: (value) {
                _duration = value;
                _timePickerStr = value.toString();
                setState(() {});
              },
            ),
            SizedBox(height: 30),
            STPicker(
              onRangeDateTimeChanged: (List<DateTime> value) {
                // 非Range取value的首个元素即可
                // 日期的显示内部已完成
                debugPrint('$value');
              },
            ),
            SizedBox(height: 30),
            STPicker(
              isRange: true,
              onRangeDateTimeChanged: (List<DateTime> value) {
                // Range首元素为开始日期，末元素为结束日期
                debugPrint('$value');
              },
            ),
          ],
        ),
      ),
    );
  }
}
