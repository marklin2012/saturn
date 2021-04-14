import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_mix.dart';
import 'package:saturn/st_select/select_texts.dart';

enum STSelectEnums {
  mix,
  texts,
}

class STSelectMixData {
  final IconData icon;
  final String title;
  final bool disabled;

  const STSelectMixData({
    this.icon,
    this.title,
    this.disabled = false,
  });
}

class STSelectTextsData {
  String firTitle;
  String secTitle;
  String thrTitle;

  STSelectTextsData({
    this.firTitle,
    this.secTitle,
    this.thrTitle,
  });
}

class STSelect extends StatelessWidget {
  final STSelectEnums enums;
  final STSelectMixData initialMix;
  final STSelectTextsData initialTexts;
  final List<STSelectMixData> mixList;
  final List<STSelectTextsData> textsList;
  final Function(STSelectMixData value) onSelectedMix;
  final Function(STSelectTextsData value) onSelectedText;
  final EdgeInsets margin;
  final Widget child;
  final String title;

  const STSelect({
    Key key,
    this.enums,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
    this.initialMix,
    this.initialTexts,
    this.mixList,
    this.textsList,
    this.onSelectedMix,
    this.onSelectedText,
    this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (enums == STSelectEnums.mix) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: STSelectMix(
          initialValue: initialMix,
          list: mixList,
          onSelected: (STSelectMixData value) {
            if (onSelectedMix != null) {
              onSelectedMix(value);
            }
          },
        ),
      );
    } else {
      return STSelectTexts(
        initialValue: initialTexts,
        list: textsList,
        title: title,
        onSelected: (STSelectTextsData value) {
          if (onSelectedText != null) {
            onSelectedText(value);
          }
        },
        child: child,
      );
    }
  }
}
