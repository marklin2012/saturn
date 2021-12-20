import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_picker/st_cupertino_date_picker.dart';
import 'package:saturn/mobile/st_select/select_show_dialog.dart';

const _selectTextsHeight = 302.0;
const _selectTitleHeight = 48.0;

// ignore: must_be_immutable
class STDatePicker extends StatelessWidget {
  STDatePicker(
      {Key key,
      this.initDateTime,
      this.minimumDate,
      this.maximumDate,
      this.minimumYear,
      this.maximunYear,
      this.onDateTimeChanged,
      this.child})
      : super(key: key);

  final DateTime initDateTime; // 初始日期
  final DateTime minimumDate; // 最小可选择的日期
  final DateTime maximumDate; // 最大可选择日期
  final int minimumYear; // 最小显示的年份
  final int maximunYear; // 最大显示的年份
  final ValueChanged<DateTime> onDateTimeChanged; // 选中的日期回调
  final Widget child; //触发的组件

  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) {
            return ShowSelectDialog(
              menu: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                ),
                child: Column(
                  children: [
                    _getTitleChild(context),
                    SizedBox(
                      height: _selectTextsHeight - _selectTitleHeight,
                      child: STCuperDatePicker(
                        onDateTimeChanged: (value) {
                          _selectedDate = value;
                        },
                        initialDateTime: initDateTime,
                        maximumDate: maximumDate,
                        minimumDate: minimumDate,
                        minimumYear: minimumYear,
                        maximumYear: maximunYear,
                      ),
                    ),
                  ],
                ),
              ),
              offset: Offset(0, _height - _selectTextsHeight),
              height: _selectTextsHeight,
            );
          },
        );
      },
      child: child,
    );
  }

  Widget _getTitleChild(BuildContext context) {
    return SizedBox(
      height: _selectTitleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              '取消',
              style: TextStyle(color: Color(0xFF888888), fontSize: 17.0),
            ),
          ),
          const Text(
            '选择日期',
            style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onDateTimeChanged != null) {
                onDateTimeChanged(_selectedDate ?? DateTime.now());
              }
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFF000000), fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}
