import 'package:flutter/material.dart';
import 'common.dart';

class STDialogTextField extends StatelessWidget {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  String getText() {
    return textEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 36),
        child: Theme(
          data: ThemeData(primaryColor: STDialogConstant.textFieldThemeColor),
          child: TextField(
            controller: textEditingController,
            autofocus: true,
            focusNode: focusNode,
            cursorColor: STDialogConstant.defaultButtonTextColor,
            cursorWidth: 1.5,
            decoration: const InputDecoration(
              hintText: "请输入",
              hintStyle: TextStyle(color: STDialogConstant.textFieldThemeColor),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: STDialogConstant.textFieldThemeColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
