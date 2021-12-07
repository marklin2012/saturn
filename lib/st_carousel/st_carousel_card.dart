import 'package:flutter/material.dart';
import 'package:saturn/st_carousel/carousel_include.dart';

enum STCarouselCardDirction {
  left,
  right,
}

const stCarouselCardOffset = 100.0;

class STCarouselCard extends StatefulWidget {
  const STCarouselCard({
    Key key,
    this.items,
    this.height,
    this.initPage,
  }) : super(key: key);

  final List<Widget> items;
  final double height;
  final int initPage;

  @override
  _STCarouselCardState createState() => _STCarouselCardState();
}

class _STCarouselCardState extends State<STCarouselCard> {
  double _height = .0;
  final _scaleFactor = 0.9;
  List<Widget> _items = [];
  int _currentPage = 0;
  double _leftOrRight = 0;
  STCarouselCardDirction _dirction;

  @override
  void initState() {
    super.initState();
    _items = widget.items ??
        [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text('1', style: TextStyle(fontSize: 34)),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text('2', style: TextStyle(fontSize: 34)),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text('3', style: TextStyle(fontSize: 34)),
          ),
        ];
    _height = widget.height ?? 220;
    _currentPage = widget.initPage ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: MediaQuery.of(context).size.width - 32,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Container(
      height: _height,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            left: _dirction == STCarouselCardDirction.left
                ? .0 - _leftOrRight
                : .0 + _leftOrRight,
            right: _dirction == STCarouselCardDirction.left
                ? 32.0 + _leftOrRight
                : 32.0 - _leftOrRight,
            top: 12.0,
            height: _height * _scaleFactor,
            child: STCarousel(
              showIndictor: false,
              child: _items[_getPreviousPage()],
            ),
          ),
          Positioned(
            left: _dirction == STCarouselCardDirction.left
                ? 32.0 + _leftOrRight
                : 32.0 - _leftOrRight,
            right: _dirction == STCarouselCardDirction.left
                ? .0 - _leftOrRight
                : .0 + _leftOrRight,
            top: 12.0,
            height: _height * _scaleFactor,
            child: STCarousel(
              showIndictor: false,
              child: _items[_getNextPage()],
            ),
          ),
          Positioned(
            left: 24.0 + _leftOrRight,
            right: 24.0 - _leftOrRight,
            top: (_height - _getCenterHeight()) / 2,
            height: _getCenterHeight(),
            child: GestureDetector(
              onHorizontalDragStart: (details) {},
              onHorizontalDragUpdate: (detail) {
                _leftOrRight += detail.delta.dx;
                setState(() {});
              },
              onHorizontalDragEnd: (detail) {
                if (_leftOrRight > 0) {
                  _dirction = STCarouselCardDirction.right;
                } else {
                  _dirction = STCarouselCardDirction.left;
                }
                if (_leftOrRight < -stCarouselCardOffset) {
                  if (_currentPage == 0) {
                    _currentPage = _items.length - 1;
                  } else {
                    _currentPage -= 1;
                  }
                } else if (_leftOrRight > stCarouselCardOffset) {
                  if (_currentPage == _items.length - 1) {
                    _currentPage = 0;
                  } else {
                    _currentPage += 1;
                  }
                }
                _leftOrRight = 0;
                setState(() {});
              },
              child: STCarousel(
                showIndictor: false,
                child: _items[_currentPage],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getCenterHeight() {
    double _tempH = _height;
    if (_dirction == STCarouselCardDirction.left) {
      if (_leftOrRight < -stCarouselCardOffset) {
        _tempH = _height * _scaleFactor;
      } else {
        _tempH = _height -
            (_leftOrRight / -stCarouselCardOffset) *
                _height *
                (1 - _scaleFactor);
      }
    } else {
      if (_leftOrRight > stCarouselCardOffset) {
        _tempH = _height * _scaleFactor;
      } else {
        _tempH = _height -
            (_leftOrRight / stCarouselCardOffset) *
                _height *
                (1 - _scaleFactor);
      }
    }
    return _tempH;
  }

  int _getPreviousPage() {
    if (_currentPage == 0) {
      return _items.length - 1;
    }
    return _currentPage - 1;
  }

  int _getNextPage() {
    if (_currentPage == _items.length - 1) {
      return 0;
    }
    return _currentPage + 1;
  }
}
