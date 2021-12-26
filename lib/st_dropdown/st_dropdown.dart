import 'package:flutter/material.dart';
import 'package:saturn/st_dropdown/st_dropdown_item.dart';
import 'package:saturn/st_dropdown/st_dropdown_trigger.dart';

class STDropdown extends StatefulWidget {
  const STDropdown({Key? key, required this.triggerData, this.items})
      : super(key: key);

  final STDropdownTriggerData triggerData;
  final List<STDropdownItem>? items;

  @override
  _STDropdownState createState() => _STDropdownState();
}

class _STDropdownState extends State<STDropdown> {
  @override
  Widget build(BuildContext context) {
    return STDropdownTrigger(
      data: widget.triggerData,
    );
  }
}
