import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class STCarouselPage extends StatefulWidget {
  const STCarouselPage({
    Key? key,
    required this.items,
    this.initPage = 0,
    this.decoration,
    this.padding,
    this.height,
  })  : assert(items.length >= 3),
        super(key: key);

  final List<Widget> items;
  final int initPage;
  final Decoration? decoration;
  final EdgeInsets? padding;
  final double? height;

  @override
  _STCarouselPageState createState() => _STCarouselPageState();
}

class _STCarouselPageState extends State<STCarouselPage> {
  // int _currentPage;
  late List<Widget> _items;
  //缩放系数
  final _scaleFactor = .9;
  // 高度
  double? _height;
  // pageView
  double? _currentPageValue = .0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _height = widget.height ?? 220.0;
    _items = widget.items;
    _pageController = PageController(
      viewportFraction: _scaleFactor,
      initialPage: widget.initPage,
    );
    _pageController!.addListener(() {
      _currentPageValue = _pageController!.page;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPage(),
          _buildIndictor(),
        ],
      ),
    );
  }

  Widget _buildPage() {
    return Container(
      height: _height,
      alignment: Alignment.center,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) => _buildPageItem(index),
        itemCount: _items.length,
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPageValue!.floor()) {
      //当前的item
      final currScale = 1 - (_currentPageValue! - index) * (1 - _scaleFactor);
      final currTrans = _height! * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currentPageValue!.floor() + 1) {
      //右边的item
      final currScale =
          _scaleFactor + (_currentPageValue! - index + 1) * (1 - _scaleFactor);
      final currTrans = _height! * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currentPageValue!.floor() - 1) {
      //左边
      final currScale = 1 - (_currentPageValue! - index) * (1 - _scaleFactor);
      final currTrans = _height! * (1 - currScale) / 2;

      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else {
      //其他，不在屏幕显示的item
      matrix4 = Matrix4.diagonal3Values(1.0, _scaleFactor, 1.0)
        ..setTranslationRaw(0.0, _height! * (1 - _scaleFactor) / 2, 0.0);
    }

    return Transform(
      transform: matrix4,
      child: STCarousel(
        showIndictor: false,
        child: _items[index],
      ),
    );
  }

  Widget _buildIndictor() {
    return Padding(
      padding: const EdgeInsets.only(top: 11.0),
      child: STCarouselIndicator(
        totalPage: widget.items.length,
        currentPage: _currentPageValue!.floor(),
        type: STCarouselIndicatorType.progress,
      ),
    );
  }
}
