import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

enum STCarouselDirction {
  left,
  top,
  right,
  bottom,
}

class STCarousel extends StatelessWidget {
  const STCarousel({
    Key? key,
    this.height = 220.0,
    this.decoration,
    this.margin,
    this.padding,
    this.child,
    this.dirction = STCarouselDirction.bottom,
    this.currentPage = 0,
    this.totalPage,
    this.indicatorType = STCarouselIndicatorType.rect,
    this.highLightColor = STColor.secRankBlue,
    this.normalColor = STColor.thrRankGrey,
    this.showIndictor = true,
  }) : super(key: key);

  final double height;
  final Decoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final STCarouselDirction dirction;
  final int currentPage;
  final int? totalPage;
  final STCarouselIndicatorType indicatorType;
  final Color highLightColor;
  final Color normalColor;
  final bool showIndictor;

  @override
  Widget build(BuildContext context) {
    if (!showIndictor) {
      return Container(
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? EdgeInsets.zero,
        constraints: BoxConstraints(
          minHeight: height,
        ),
        decoration: decoration ??
            BoxDecoration(
              color: STColor.fourRankGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
        child: Center(
          child: child,
        ),
      );
    }
    return Container(
      padding: margin ?? EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            padding: padding ?? EdgeInsets.zero,
            constraints: BoxConstraints(
              minHeight: height,
            ),
            decoration: decoration ??
                BoxDecoration(
                  color: STColor.fourRankGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
            child: Center(
              child: child,
            ),
          ),
          if (dirction == STCarouselDirction.top ||
              dirction == STCarouselDirction.bottom)
            Positioned(
              left: 0,
              right: 0,
              top: dirction == STCarouselDirction.top ? 12.0 : null,
              bottom: dirction == STCarouselDirction.bottom ? 12.0 : null,
              height:
                  indicatorType == STCarouselIndicatorType.circle ? 8.0 : 4.0,
              child: Container(
                alignment: Alignment.center,
                child: STCarouselIndicator(
                  totalPage: totalPage,
                  currentPage: currentPage,
                  type: indicatorType,
                  highLightColor: highLightColor,
                  color: normalColor,
                ),
              ),
            ),
          if (dirction == STCarouselDirction.left ||
              dirction == STCarouselDirction.right)
            Positioned(
              left: dirction == STCarouselDirction.left ? 12.0 : null,
              right: dirction == STCarouselDirction.right ? 12.0 : null,
              top: 0,
              bottom: 0,
              width:
                  indicatorType == STCarouselIndicatorType.circle ? 8.0 : 4.0,
              child: Container(
                alignment: Alignment.center,
                child: STCarouselIndicator(
                  totalPage: totalPage,
                  currentPage: currentPage,
                  type: indicatorType,
                  highLightColor: highLightColor,
                  color: normalColor,
                  axis: Axis.vertical,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
