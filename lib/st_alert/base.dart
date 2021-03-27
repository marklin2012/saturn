import 'package:flutter/material.dart';
import 'common.dart';

class STAlertBase extends Dialog {
  final double width;
  final String icon;
  final String text;
  final String description;
  final String rightText;
  final String rightIcon;
  final VoidCallback onRightTap;
  final STAlertType type;
  final STAlertState state;
  final STAlertRightButtonType rightButtonType;

  const STAlertBase(
      {Key key,
      this.icon,
      this.text,
      this.description,
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConstant.defaultWidth,
      this.onRightTap,
      this.type,
      this.state,
      this.rightButtonType})
      : super(
          key: key,
        );

  const STAlertBase.text(
      {Key key,
      @required this.text,
      this.icon = "",
      this.description = "",
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConstant.defaultWidth,
      this.onRightTap,
      this.type = STAlertType.text,
      this.state,
      this.rightButtonType})
      : super(
          key: key,
        );

  const STAlertBase.iconText(
      {Key key,
      @required this.icon,
      @required this.text,
      this.description = "",
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConstant.defaultWidth,
      this.onRightTap,
      this.type = STAlertType.iconText,
      this.state,
      this.rightButtonType})
      : super(
          key: key,
        );

  const STAlertBase.textDescription(
      {Key key,
      @required this.text,
      @required this.description,
      this.icon = "",
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConstant.defaultWidth,
      this.onRightTap,
      this.type = STAlertType.textDescription,
      this.state,
      this.rightButtonType})
      : super(
          key: key,
        );

  const STAlertBase.iconTextDescription(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.description,
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConstant.defaultWidth,
      this.onRightTap,
      this.type = STAlertType.iconTextDescription,
      this.state,
      this.rightButtonType})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> firRowChildren = [];
    firRowChildren.add(const SizedBox(width: STAlertConstant.leftPadding));

    //第一行添加图片
    if (type == STAlertType.iconTextDescription ||
        type == STAlertType.iconText) {
      firRowChildren.add(Image.asset(icon,
          width: STAlertConstant.iconWidth,
          height: STAlertConstant.iconWidth,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.contain));
      firRowChildren
          .add(const SizedBox(width: STAlertConstant.iconTitlePadding));
    }

    double curLeftPadding = 0;
    if (type == STAlertType.iconTextDescription ||
        type == STAlertType.iconText) {
      curLeftPadding = STAlertConstant.secondTextWithIconLeftPadding;
    } else {
      curLeftPadding = STAlertConstant.leftPadding;
    }

    double curWidth = width > STAlertConstant.defaultWidth
        ? width
        : STAlertConstant.defaultWidth;

    double firTextWidth;
    switch (rightButtonType) {
      case STAlertRightButtonType.none:
        {
          firTextWidth =
              curWidth - curLeftPadding - STAlertConstant.rightPadding;
        }
        break;
      case STAlertRightButtonType.icon:
        {
          firTextWidth = curWidth -
              curLeftPadding -
              STAlertConstant.rightPadding -
              STAlertConstant.firstTextRightPadding -
              STAlertConstant.iconWidth;
        }
        break;
      case STAlertRightButtonType.text:
        {
          //右边text宽度，这里要改成实际宽度。
          double rigthTextWidth =
              (rightText.length >= STAlertConstant.rightTextCount
                      ? STAlertConstant.rightTextCount
                      : rightText.length) *
                  STAlertConstant.singleTextWidth;

          firTextWidth = curWidth -
              curLeftPadding -
              STAlertConstant.rightPadding -
              STAlertConstant.firstTextRightPadding -
              rigthTextWidth;
        }
        break;
    }

    //第一行添加左边文字
    firRowChildren.add(SizedBox(
        width: firTextWidth,
        child: Text(text,
            softWrap: true,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: STAlertConstant.textFontSize,
                decoration: TextDecoration.none))));

    //添加右边控件
    List<Widget> rightChildren = [];
    rightChildren = addRightButton(
        rightButtonType, rightChildren, rightIcon, rightText, onRightTap);
    rightChildren.add(const SizedBox(width: STAlertConstant.rightPadding));

    //添加第二排
    double secTextWidth =
        curWidth - curLeftPadding - STAlertConstant.rightPadding;

    List<Widget> secRowChildren = [];
    secRowChildren.add(SizedBox(width: curLeftPadding));
    secRowChildren.add(SizedBox(
        width: secTextWidth,
        child: Text(description,
            softWrap: true,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: STAlertConstant.descriptionFontSize,
                decoration: TextDecoration.none))));

    //搭建widget
    var widget;
    if (type == STAlertType.text || type == STAlertType.iconText) {
      widget = Center(
        child: Container(
          width: curWidth,
          decoration: BoxDecoration(
            color: bgColorFromAlertState(state),
            borderRadius: const BorderRadius.all(
                Radius.circular(STAlertConstant.cornerRadius)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: STAlertConstant.firstTitleTopPading),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: firRowChildren,
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: rightChildren,
                    )),
              ],
            ),
            const SizedBox(height: STAlertConstant.firstTitleTopPading),
          ]),
        ),
      );
    } else {
      widget = Center(
        child: Container(
          width: curWidth,
          decoration: BoxDecoration(
            color: bgColorFromAlertState(state),
            borderRadius: const BorderRadius.all(
                Radius.circular(STAlertConstant.cornerRadius)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: STAlertConstant.firstTitleTopPading),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: firRowChildren,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: rightChildren,
                      )),
                ],
              ),
              const SizedBox(height: STAlertConstant.secondTextTopPading),
              Row(
                children: secRowChildren,
              ),
              const SizedBox(height: STAlertConstant.secondTextBottomPading),
            ],
          ),
        ),
      );
    }
    return widget;
  }

  Color bgColorFromAlertState(STAlertState state) {
    switch (state) {
      case STAlertState.alert:
        return STAlertConstant.colorBlue;
      case STAlertState.success:
        return STAlertConstant.colorGreen;
      case STAlertState.danger:
        return STAlertConstant.colorRed;
      case STAlertState.warning:
        return STAlertConstant.colorOrange;
      default:
        return Colors.transparent;
    }
  }

  List<Widget> addRightButton(STAlertRightButtonType alertRightButtonType,
      List rowChildren, String icon, String text, VoidCallback tap) {
    switch (alertRightButtonType) {
      case STAlertRightButtonType.none:
        {}
        break;
      case STAlertRightButtonType.icon:
        {
          rowChildren.add(GestureDetector(
            child: Image.asset(icon,
                width: STAlertConstant.iconWidth,
                height: STAlertConstant.iconWidth,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.contain),
            onTap: tap,
          ));
        }
        break;
      case STAlertRightButtonType.text:
        {
          rowChildren.add(GestureDetector(
            child: SizedBox(
                width: STAlertConstant.singleTextWidth *
                    STAlertConstant.rightTextCount,
                child: Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: STAlertConstant.descriptionFontSize,
                      decoration: TextDecoration.none),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
            onTap: tap,
          ));
        }
        break;
    }
    return rowChildren;
  }
}
