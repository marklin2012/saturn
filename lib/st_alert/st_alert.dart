import 'package:flutter/material.dart';

class STAlertConstant {
//定义的Color，带合并代码后迁移到ColorUtil中
//**************************************************************** */

  static const colorBlue = Color.fromRGBO(9, 91, 249, 0.12);
  static const colorGreen = Color.fromRGBO(73, 197, 100, 0.12);
  static const colorRed = Color.fromRGBO(255, 65, 65, 0.12);
  static const colorOrange = Color.fromRGBO(255, 169, 39, 0.12);
  static const colorBackground = Color.fromRGBO(255, 255, 255, 0.1);

//**************************************************************** */

  static const defaultWidth = 200.0; //默认宽度
  static const defaultHeight = 40.0;
  static const iconWidth = 17.0;

  static const cornerRadius = 4.0;

// Padding
  static const leftPadding = 16.0;
  static const rightPadding = 10.0;
  static const firstTextRightPadding = 5.0;
  static const iconTitlePadding = 14.0;

  static const secondTextWithIconLeftPadding =
      leftPadding + iconWidth + iconTitlePadding; //当类型为iconTitleText时，第二排文字的左边距
  static const firstTitleTopPading = 4.0;
  static const secondTextTopPading = 4.0;
  static const secondTextBottomPading = 4.0;

//Font
  static const textFontSize = 16.0;
  static const descriptionFontSize = 14.0;

  static const singleTextWidth = 15.0;
  static const rightTextCount = 4;

//Icon
  static const defaultLeftIcon = "assets/images/basketball_check.png";
  static const defaultRightIcon = "assets/images/basketball_check.png";
}

// alert 类型
enum STAlertType { alert, success, danger, warning }

class STAlert extends Dialog {
  final double width;
  final String icon;
  final String text;
  final String description;
  final String rightText;
  final String rightIcon;
  final VoidCallback onRightTap;
  final STAlertType type;
  final bool showLeftIcon;
  final bool isAutoClose;
  final int disappearTime;

  const STAlert({
    Key key,
    @required this.type,
    @required this.text,
    @required this.showLeftIcon,
    @required this.isAutoClose,
    this.width = STAlertConstant.defaultWidth,
    this.icon,
    this.description,
    this.rightText,
    this.rightIcon,
    this.onRightTap,
    this.disappearTime,
  }) : super(
          key: key,
        );

  static void show(
      {@required BuildContext context,
      @required STAlertType type,
      @required String text,
      @required bool showLeftIcon,
      @required bool isAutoClose,
      double width = STAlertConstant.defaultWidth,
      String icon,
      String description,
      String rightText,
      String rightIcon,
      VoidCallback onRightTap,
      int disappearTime = 5}) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          if (isAutoClose) {
            Future.delayed(Duration(seconds: disappearTime), () {
              hide(context);
            });
          }

          var alert = STAlert(
            type: type,
            text: text,
            showLeftIcon: showLeftIcon,
            isAutoClose: isAutoClose,
            description: description,
            width: width,
            icon: icon,
            rightText: rightText,
            rightIcon: rightIcon,
            onRightTap: onRightTap,
            disappearTime: disappearTime,
          );

          return GestureDetector(
            child: alert,
            onTap: () {
              STAlert.hide(context);
            },
          );
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firRowChildren = [];
    firRowChildren.add(const SizedBox(width: STAlertConstant.leftPadding));

    //第一行添加图片
    if (showLeftIcon == true) {
      String curIcon;
      if (isNullOrEmpty(icon)) {
        curIcon = STAlertConstant.defaultLeftIcon;
      } else {
        curIcon = icon;
      }
      firRowChildren.add(Image.asset(curIcon,
          width: STAlertConstant.iconWidth,
          height: STAlertConstant.iconWidth,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.contain));
      firRowChildren
          .add(const SizedBox(width: STAlertConstant.iconTitlePadding));
    }

    double curLeftPadding = 0;
    if (showLeftIcon == true) {
      curLeftPadding = STAlertConstant.secondTextWithIconLeftPadding;
    } else {
      curLeftPadding = STAlertConstant.leftPadding;
    }

    double curWidth = width > STAlertConstant.defaultWidth
        ? width
        : STAlertConstant.defaultWidth;

    double firTextWidth;
    if (isNullOrEmpty(rightText)) {
      if (isNullOrEmpty(rightIcon)) {
        firTextWidth = curWidth - curLeftPadding - STAlertConstant.rightPadding;
      } else {
        {
          firTextWidth = curWidth -
              curLeftPadding -
              STAlertConstant.rightPadding -
              STAlertConstant.firstTextRightPadding -
              STAlertConstant.iconWidth;
        }
      }
    } else {
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
    rightChildren =
        addRightButton(rightChildren, rightIcon, rightText, onRightTap);
    rightChildren.add(const SizedBox(width: STAlertConstant.rightPadding));

    //添加第二排
    double secTextWidth =
        curWidth - curLeftPadding - STAlertConstant.rightPadding;
    String curDescription;
    if (isNullOrEmpty(description)) {
      curDescription = "";
    } else {
      curDescription = description;
    }
    List<Widget> secRowChildren = [];
    secRowChildren.add(SizedBox(width: curLeftPadding));
    secRowChildren.add(SizedBox(
        width: secTextWidth,
        child: Text(curDescription,
            softWrap: true,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: STAlertConstant.descriptionFontSize,
                decoration: TextDecoration.none))));

    //搭建widget
    var widget;
    if (isNullOrEmpty(description)) {
      widget = Center(
        child: Container(
          width: curWidth,
          decoration: BoxDecoration(
            color: bgColorFromAlertType(type),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
            color: bgColorFromAlertType(type),
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

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Color bgColorFromAlertType(STAlertType state) {
    switch (state) {
      case STAlertType.alert:
        return STAlertConstant.colorBlue;
      case STAlertType.success:
        return STAlertConstant.colorGreen;
      case STAlertType.danger:
        return STAlertConstant.colorRed;
      case STAlertType.warning:
        return STAlertConstant.colorOrange;
      default:
        return Colors.transparent;
    }
  }

  List<Widget> addRightButton(
      List rowChildren, String icon, String text, VoidCallback tap) {
    if (isNullOrEmpty(text)) {
      if (isNullOrEmpty(icon)) {
      } else {
        String curIcon;
        if (isNullOrEmpty(icon)) {
          curIcon = STAlertConstant.defaultRightIcon;
        } else {
          curIcon = icon;
        }
        rowChildren.add(GestureDetector(
          child: Image.asset(icon,
              width: STAlertConstant.iconWidth,
              height: STAlertConstant.iconWidth,
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.contain),
          onTap: tap,
        ));
      }
    } else {
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
    return rowChildren;
  }
}
