import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/utils/include.dart';

enum STTabOptionDirction {
  top,
  bottom,
  left,
  right,
}

enum STTabOptionSize {
  small,
  middle,
  large,
}

const _selectedFontWeight = FontWeight.w600;
const _unselectedFontWeight = FontWeight.w400;
const _disabledBadgeBGColor = STColor.thrRankGrey;
const _unselectedBadgeBGColor = STColor.secRankGrey;
const _selectedBadgeColor = Colors.white;
const _disabledBadgeColor = STColor.secRankGrey;
const _unselectedBadgeColor = STColor.thrRankFont;
const _badgeHeight = 16.0;
const _iconSize = 16.0;
const _badgeFontSize = 12.0;

class STTabOptionItem extends StatelessWidget {
  const STTabOptionItem({
    Key? key,
    this.backgroundColor,
    this.icon,
    this.badge,
    this.maxBadge = 99,
    this.selected = false,
    this.disabled = false,
    this.selectedColor = STColor.firRankBlue,
    this.unselectedColor = STColor.firRankFont,
    this.disabledColor = STColor.secRankGrey,
    required this.item,
    this.dirction = STTabOptionDirction.top,
    this.optionSize = STTabOptionSize.middle,
    this.isCard = false,
    this.onTap,
  }) : super(key: key);

  final bool isCard;
  final STTabOptionDirction dirction;
  final STTabOptionSize optionSize;
  final Color? backgroundColor;
  final IconData? icon;
  final int? badge;
  final int maxBadge;
  final bool selected;
  final bool disabled;
  final Color selectedColor;
  final Color unselectedColor;
  final Color disabledColor;
  final String item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
        padding: _getContenPadding(),
        decoration: _getDecoration(),
        child: _getContent(),
      ),
    );
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
      ],
    );
  }

  BoxDecoration? _getDecoration() {
    BoxDecoration? _decoration;
    if (isCard) {
      const _side = BorderSide(color: STColor.thrRankGrey);
      _decoration = BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: selected
            ? Border(
                top: dirction == STTabOptionDirction.bottom
                    ? BorderSide.none
                    : _side,
                right: dirction == STTabOptionDirction.left
                    ? BorderSide.none
                    : _side,
                bottom: dirction == STTabOptionDirction.top
                    ? BorderSide.none
                    : _side,
                left: dirction == STTabOptionDirction.right
                    ? BorderSide.none
                    : _side,
              )
            : Border.all(color: STColor.thrRankGrey),
        borderRadius: selected
            ? null
            : const BorderRadius.vertical(top: Radius.circular(2)),
      );
    } else {
      const _side = BorderSide(color: STColor.firRankBlue, width: 2);
      _decoration = BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
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
    }
    return _decoration;
  }

  Widget _buildIcon() {
    return Icon(
      icon,
      size: _iconSize,
      color: disabled
          ? disabledColor
          : selected
              ? selectedColor
              : unselectedColor,
    );
  }

  Widget _buildTitle() {
    final _fontSize = _getFontSize();
    TextStyle _style = TextStyle(
      fontSize: _fontSize,
      fontWeight: _unselectedFontWeight,
      color: unselectedColor,
    );
    if (disabled) {
      _style = TextStyle(
        fontSize: _fontSize,
        fontWeight: _unselectedFontWeight,
        color: disabledColor,
      );
    } else if (selected) {
      _style = TextStyle(
        fontSize: _fontSize,
        fontWeight: _selectedFontWeight,
        color: selectedColor,
      );
    }
    return Text(item, style: _style);
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
                ? selectedColor
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

  EdgeInsets _getContenPadding() {
    switch (optionSize) {
      case STTabOptionSize.small:
        return isCard
            ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0)
            : EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: (dirction == STTabOptionDirction.left ||
                        dirction == STTabOptionDirction.right)
                    ? 24.0
                    : 0,
              );
      case STTabOptionSize.large:
        return isCard
            ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
            : EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: (dirction == STTabOptionDirction.left ||
                        dirction == STTabOptionDirction.right)
                    ? 24.0
                    : 0,
              );
      default:
        return isCard
            ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
            : EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: (dirction == STTabOptionDirction.left ||
                        dirction == STTabOptionDirction.right)
                    ? 24.0
                    : 0,
              );
    }
  }

  double _getFontSize() {
    switch (optionSize) {
      case STTabOptionSize.small:
        return 14.0;
      case STTabOptionSize.large:
        return 14.0;
      default:
        return 16.0;
    }
  }
}
