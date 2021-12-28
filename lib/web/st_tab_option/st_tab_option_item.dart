import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

enum STTabOptionDirction {
  top,
  bottom,
  left,
  right,
}

enum STTabOptionSize {
  small,
  normal,
  large,
}

enum STTabOptionType {
  line,
  card,
  editCard,
  boxCard,
}

const _selectedFontWeight = FontWeight.w600;
const _unselectedFontWeight = FontWeight.w400;
const _selectedColor = STColor.firRankBlue;
const _unselectedColor = STColor.firRankFont;
const _disabledColor = STColor.secRankGrey;
const _disabledBadgeBGColor = STColor.thrRankGrey;
const _unselectedBadgeBGColor = STColor.secRankGrey;
const _selectedBadgeColor = Colors.white;
const _disabledBadgeColor = STColor.secRankGrey;
const _unselectedBadgeColor = STColor.thrRankFont;
const _badgeHeight = 16.0;
const _iconSize = 16.0;
const _badgeFontSize = 12.0;

class STTabOptionData {
  final IconData? icon;
  final String? title;
  final int? badge;
  final int? maxBadge;
  final bool disabled;
  final bool isDeleted;

  const STTabOptionData({
    this.icon,
    this.title,
    this.badge,
    this.maxBadge,
    this.disabled = false,
    this.isDeleted = true,
  });
}

// ignore: must_be_immutable
class STTabOptionItem extends StatelessWidget {
  STTabOptionItem({
    Key? key,
    this.icon,
    this.badge,
    this.maxBadge = 99,
    this.selected = false,
    this.disabled = false,
    required this.item,
    this.type = STTabOptionType.line,
    this.dirction = STTabOptionDirction.top,
    this.size = STTabOptionSize.normal,
    this.isDeleted = true,
    this.onTap,
    this.onDeletedTap,
  }) : super(key: key);

  final STTabOptionType type;
  final STTabOptionDirction dirction;
  final STTabOptionSize size;
  final IconData? icon;
  final int? badge;
  final int maxBadge;
  final bool selected;
  final bool disabled;
  final String item;
  final bool isDeleted; // editCard时是否可编辑
  final VoidCallback? onTap;
  final VoidCallback? onDeletedTap;

  late Axis _axis;

  @override
  Widget build(BuildContext context) {
    if (dirction == STTabOptionDirction.top ||
        dirction == STTabOptionDirction.bottom) {
      _axis = Axis.horizontal;
    } else {
      _axis = Axis.vertical;
    }
    return GestureDetector(
      onTap: () {
        if (disabled) return;
        if (onTap != null) {
          STDebounce().start(
            key: 'STTabOptionItemKey',
            func: () {
              onTap!();
            },
            time: 100,
          );
        }
      },
      child: Container(
        padding: _getContentPadding(),
        decoration: _getDecoration(),
        child: _getContent(),
      ),
    );
  }

  EdgeInsets _getContentPadding() {
    EdgeInsets _insets = EdgeInsets.zero;
    if (type == STTabOptionType.line) {
      final _ver = size == STTabOptionSize.small
          ? 8.0
          : (size == STTabOptionSize.large ? 16.0 : 12.0);
      _insets = EdgeInsets.symmetric(
        vertical: _ver,
        horizontal: _axis == Axis.vertical ? 24.0 : 0,
      );
    } else {
      _insets = EdgeInsets.symmetric(
        vertical: size == STTabOptionSize.small ? 6.0 : 8.0,
        horizontal: 16.0,
      );
    }
    return _insets;
  }

  BoxDecoration? _getDecoration() {
    BoxDecoration? _decoration;
    if (type == STTabOptionType.line) {
      const _side = BorderSide(color: STColor.firRankBlue, width: 2);
      _decoration = BoxDecoration(
        color: Colors.transparent,
        border: selected
            ? Border(
                top: dirction == STTabOptionDirction.bottom
                    ? _side
                    : BorderSide.none,
                right: dirction == STTabOptionDirction.left
                    ? _side
                    : BorderSide.none,
                bottom: dirction == STTabOptionDirction.top
                    ? _side
                    : BorderSide.none,
                left: dirction == STTabOptionDirction.right
                    ? _side
                    : BorderSide.none,
              )
            : null,
      );
    } else if (type == STTabOptionType.boxCard) {
      _decoration = BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: selected
            ? const BorderRadius.vertical(top: Radius.circular(2.0))
            : null,
      );
    } else {
      const _side = BorderSide(color: STColor.thrRankGrey);
      const _whiteSide = BorderSide(color: Colors.white);
      _decoration = BoxDecoration(
        color: Colors.white,
        border: selected
            ? Border(
                top:
                    dirction == STTabOptionDirction.bottom ? _whiteSide : _side,
                right:
                    dirction == STTabOptionDirction.left ? _whiteSide : _side,
                bottom:
                    dirction == STTabOptionDirction.top ? _whiteSide : _side,
                left:
                    dirction == STTabOptionDirction.right ? _whiteSide : _side,
              )
            : Border.all(color: STColor.thrRankGrey),
      );
    }
    return _decoration;
  }

  Widget _getContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 9.0),
            child: _buildIcon(),
          ),
        _buildTitle(),
        if (badge != null)
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: _getBadge(),
          ),
        if (type == STTabOptionType.editCard && isDeleted == true)
          _getDeletedIcon(),
      ],
    );
  }

  Widget _buildIcon() {
    return Icon(
      icon,
      size: _iconSize,
      color: disabled
          ? _disabledColor
          : selected
              ? _selectedColor
              : _unselectedColor,
    );
  }

  Widget _buildTitle() {
    final _fontSize = _getFontSize();
    TextStyle _style = TextStyle(
      fontSize: _fontSize,
      fontWeight: _unselectedFontWeight,
      color: _unselectedColor,
    );
    if (disabled) {
      _style = TextStyle(
        fontSize: _fontSize,
        fontWeight: _unselectedFontWeight,
        color: _disabledColor,
      );
    } else if (selected) {
      _style = TextStyle(
        fontSize: _fontSize,
        fontWeight: _selectedFontWeight,
        color: _selectedColor,
      );
    }
    return Text(item, style: _style);
  }

  double _getFontSize() {
    if (size == STTabOptionSize.large) {
      return 16.0;
    } else {
      return 14.0;
    }
  }

  Widget? _getBadge() {
    String _badge = '';
    if (badge! > maxBadge) {
      _badge = '$maxBadge+';
    } else if (badge! < 0) {
      _badge = '0';
    } else {
      _badge = '$badge';
    }
    return Container(
      height: _badgeHeight,
      constraints: const BoxConstraints(
        minWidth: 30,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: disabled
            ? _disabledBadgeBGColor
            : selected
                ? _selectedColor
                : _unselectedBadgeBGColor,
      ),
      child: Text(
        _badge,
        style: TextStyle(
          color: disabled
              ? _disabledBadgeColor
              : selected
                  ? _selectedBadgeColor
                  : _unselectedBadgeColor,
          fontSize: _badgeFontSize,
          fontWeight: _unselectedFontWeight,
        ),
      ),
    );
  }

  Widget _getDeletedIcon() {
    return GestureDetector(
      onTap: () {
        if (onDeletedTap == null) return;
        STDebounce().start(
          key: 'STTabOptionItemKey',
          func: () {
            onDeletedTap!();
          },
          time: 100,
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(
          STIcons.commonly_close_outline,
          size: 20,
          color: STColor.secRankGrey,
        ),
      ),
    );
  }
}
