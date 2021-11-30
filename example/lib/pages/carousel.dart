import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/st_button/common.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Carousel'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 20,
            color: STColor.backgroundColor,
            alignment: Alignment.center,
            child: STCarouselIndicator(
              totalPage: 4,
              currentPage: 0,
              type: STCarouselIndicatorType.rect,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 20,
            color: STColor.backgroundColor,
            alignment: Alignment.center,
            child: STCarouselIndicator(
              totalPage: 4,
              currentPage: 1,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 20,
            color: STColor.backgroundColor,
            alignment: Alignment.center,
            child: STCarouselIndicator(
              totalPage: 4,
              currentPage: 2,
              type: STCarouselIndicatorType.progress,
            ),
          ),
          SizedBox(height: 10),
          STCarousel(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 34,
                color: STColor.thrRankFont,
                fontWeight: FontWeight.w600,
              ),
            ),
            totalPage: 4,
          ),
          SizedBox(height: 10),
          STCarousel(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 34,
                color: STColor.thrRankFont,
                fontWeight: FontWeight.w600,
              ),
            ),
            totalPage: 4,
            currentPage: 1,
            dirction: STCarouselDirction.left,
            indicatorType: STCarouselIndicatorType.circle,
          ),
        ],
      ),
    );
  }
}
