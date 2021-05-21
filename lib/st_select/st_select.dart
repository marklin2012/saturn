import 'package:flutter/material.dart';
import 'package:saturn/st_select/select_mix.dart';
import 'package:saturn/st_select/select_mix_item.dart';
import 'package:saturn/st_select/select_texts.dart';

enum STSelectTypes {
  mix,
  texts,
}

class STSelect extends StatelessWidget {
  const STSelect({
    Key key,
    this.types,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
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
  final EdgeInsets margin; // 混合选择器的内嵌
  final STSelectMixItem initMixValue; // 混合选择器的初始值
  final List<STSelectMixItem> mixListValues; // 混合选择器的所有数据
  final Function(STSelectMixItem) onChangedMixValue; //混合选择器选中后的回调
  final Widget child; // 文本选择器的触发组件
  final String title; // 文本选择器的标题
  final List<String> initTextsValue; // 文本选择器的初始值
  //文本选择器的所有数据，有几个list对应几个选择器
  final List<List<String>> textsListValues;
  //文本选择器选中后的回调，按下标对应选中的结果
  final Function(List<String> value) onChangedTextsValue;
  final List<String> initUnits; // 文本选择器的单位集合
  final bool looping; //数据是否循环

  @override
  Widget build(BuildContext context) {
    if (types == STSelectTypes.mix) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: STSelectMix(
          key: key,
          initValue: initMixValue,
          items: mixListValues,
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
