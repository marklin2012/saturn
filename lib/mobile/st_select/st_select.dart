import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_select/select_mix.dart';
import 'package:saturn/mobile/st_select/select_mix_item.dart';
import 'package:saturn/mobile/st_select/select_texts.dart';

enum STSelectTypes {
  mix,
  texts,
}

class STSelect extends StatelessWidget {
  const STSelect({
    Key key,
    this.types,
    this.margin = const EdgeInsets.all(0.0),
    this.isConCheck = false,
    this.initMixValue,
    this.mixListValues,
    this.onChangedMixValue,
    this.child,
    this.title,
    this.initTextsValue,
    this.textsListValues,
    this.onChangedTextsValue,
    this.initUnits,
    this.looping = false,
  }) : super(key: key);

  final STSelectTypes types; // 不同的样式
  final bool isConCheck; // 混合样式是否需要勾选
  final EdgeInsets margin; // 混合样式的外边距
  final STSelectMixItem initMixValue; // 混合样式的初始值
  final List<STSelectMixItem> mixListValues; // 混合样式的所有数据
  final Function(STSelectMixItem) onChangedMixValue; //混合样式选中后的回调
  final Widget child; // 文本样式的触发组件
  final String title; // 文本样式的标题
  final List<String> initTextsValue; // 文本样式的初始值
  //文本样式的数据集，子List对应行数
  final List<List<String>> textsListValues;
  //文本样式选中后的回调，按下标对应选中的结果
  final Function(List<String>) onChangedTextsValue;
  final List<String> initUnits; // 文本样式的单位集合
  final bool looping; //数据是否循环

  @override
  Widget build(BuildContext context) {
    if (types == STSelectTypes.mix) {
      return Container(
        margin: margin,
        child: STSelectMix(
          key: key,
          initValue: initMixValue,
          items: mixListValues,
          isConCheck: isConCheck,
          onChanged: (STSelectMixItem value) {
            if (onChangedMixValue != null) {
              onChangedMixValue(value);
            }
          },
        ),
      );
    } else {
      return STSelectTexts(
        key: key,
        title: title,
        initValue: initTextsValue,
        initUnits: initUnits,
        listValues: textsListValues,
        looping: looping,
        onChanged: (value) {
          if (onChangedTextsValue != null) {
            onChangedTextsValue(value);
          }
        },
        child: child,
      );
    }
  }
}
