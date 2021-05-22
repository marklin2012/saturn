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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 36),
        child: Theme(
          data: ThemeData(primaryColor: STDialogConstant.textFieldThemeColor),
          child: TextField(
            controller: textEditingController,
            autofocus: true,
            focusNode: focusNode,
            cursorColor: STDialogConstant.textFieldThemeColor,
            decoration: const InputDecoration(
              hintText: "请输入",
              hintStyle: TextStyle(color: STDialogConstant.textFieldThemeColor),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                    color: STDialogConstant.textFieldThemeColor, width: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
