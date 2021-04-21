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
            // CalendarDatePicker(
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime.now().subtract(Duration(days: 1000)),
            //   lastDate: DateTime.now().add(Duration(days: 1000)),
            //   onDateChanged: (value) {
            //     debugPrint('$value');
            //   },
            // ),
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
            STPicker(),
            SizedBox(height: 30),
            STPicker(isRange: true),
          ],
        ),
      ),
    );
  }
}
