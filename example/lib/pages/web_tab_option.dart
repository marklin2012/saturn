import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

const _textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

class WebTapOptionPage extends StatefulWidget {
  const WebTapOptionPage({Key key}) : super(key: key);

  @override
  _WebTapOptionPageState createState() => _WebTapOptionPageState();
}

class _WebTapOptionPageState extends State<WebTapOptionPage> {
  int _currentPageIndex = 0;
  List<String> pageList = ['这里是文字内容1', '这里是文字内容2', '这里是文字内容3', '这里是文字内容4'];
  List<String> pageList1 = [
    '这里是文字内容1',
    '这里是文字内容2',
    '这里是文字内容3',
    '这里是文字内容4',
    '这里是文字内容5',
    '这里是文字内容6',
    '这里是文字内容7',
    '这里是文字内容8',
    '这里是文字内容9',
    '这里是文字内容10',
    '这里是文字内容11',
    '这里是文字内容12',
  ];
  PageController _pageController;
  PageController _pageController1;
  PageController _pageController2;
  PageController _pageController3;
  PageController _pageController4;
  PageController _pageController5;
  PageController _pageController6;
  PageController _pageController7;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
    _pageController1 = PageController(initialPage: _currentPageIndex);
    _pageController2 = PageController(initialPage: _currentPageIndex);
    _pageController3 = PageController(initialPage: _currentPageIndex);
    _pageController4 = PageController(initialPage: _currentPageIndex);
    _pageController5 = PageController(initialPage: _currentPageIndex);
    _pageController6 = PageController(initialPage: _currentPageIndex);
    _pageController7 = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tabOption'),
      ),
      body: _test(),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: 10),
      //       _buildDefault(),
      //       SizedBox(height: 10),
      //       _buildCenter(),
      //       SizedBox(height: 10),
      //       _buildAddIcon(),
      //       SizedBox(height: 10),
      //       _buildCanScroller(),
      //       SizedBox(height: 10),
      //       _buildAddOther(),
      //       SizedBox(height: 10),
      //       _buildPositonBottom(),
      //       SizedBox(height: 10),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           _buildPositonLeft(),
      //           _buildPositonRight(),
      //         ],
      //       ),
      //       SizedBox(height: 10),
      //       _buildSmallCard(),
      //       SizedBox(height: 10),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _test() {
    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      color: Colors.grey,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        controller: ScrollController(initialScrollOffset: 200),
        children: [
          Container(
            width: 200,
            color: Colors.red,
          ),
          Container(
            width: 200,
            color: Colors.blue,
          ),
          Container(
            width: 200,
            color: Colors.yellow,
          ),
          Container(
            width: 200,
            color: Colors.purple,
          ),
          Container(
            width: 200,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('小号 卡片', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            selectedChanged: (int index) {
              _pageController6.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
            isCard: true,
            optionSize: STTabOptionSize.small,
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController6, pageList1),
          ),
        ],
      ),
    );
  }

  Widget _buildPositonLeft() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('位置在左', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            dirction: STTabOptionDirction.left,
          ),
        ],
      ),
    );
  }

  Widget _buildPositonRight() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('位置在右', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            dirction: STTabOptionDirction.right,
          ),
        ],
      ),
    );
  }

  Widget _buildPositonBottom() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('位置在下', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            selectedChanged: (int index) {
              _pageController5.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
            dirction: STTabOptionDirction.bottom,
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController5, pageList),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOther() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('附加内容', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            selectedChanged: (int index) {
              _pageController4.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
            prefix: STButton(
              text: '左内容按钮',
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              type: STButtonType.outline,
              backgroundColor: Colors.white,
            ),
            suffix: STButton(
              text: '右内容按钮',
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              type: STButtonType.outline,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController4, pageList),
          ),
        ],
      ),
    );
  }

  Widget _buildCanScroller() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('滑动', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
              STTabOptionData(
                title: 'Tab5',
              ),
              STTabOptionData(
                title: 'Tab6',
              ),
              STTabOptionData(
                title: 'Tab7',
              ),
              STTabOptionData(
                title: 'Tab8',
              ),
              STTabOptionData(
                title: 'Tab9',
              ),
              STTabOptionData(
                title: 'Tab10',
              ),
              STTabOptionData(
                title: 'Tab11',
              ),
              STTabOptionData(
                title: 'Tab12',
              ),
            ],
            selectedChanged: (int index) {
              _pageController3.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController3, pageList1),
          ),
        ],
      ),
    );
  }

  Widget _buildAddIcon() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('带图标 微标数 禁用某一项', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
                icon: STIcons.label_heart_outline,
                badge: 100,
              ),
              STTabOptionData(
                title: 'Tab2',
                icon: STIcons.label_fire_outline,
                disabled: true,
                badge: 10,
              ),
              STTabOptionData(
                title: 'Tab3',
                icon: STIcons.label_like_outline,
                badge: 12,
              ),
              STTabOptionData(
                title: 'Tab4',
                icon: STIcons.label_star_outline,
                badge: 8,
              ),
            ],
            selectedChanged: (int index) {
              _pageController2.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController2, pageList),
          ),
        ],
      ),
    );
  }

  Widget _buildCenter() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('居中 禁用某一项', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            mainAxisAlignment: MainAxisAlignment.center,
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
                disabled: true,
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            selectedChanged: (int index) {
              _pageController1.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController1, pageList),
          ),
        ],
      ),
    );
  }

  Widget _buildDefault() {
    return Container(
      height: 150,
      color: STColor.fourRankGrey,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('默认', style: _textStyle),
          SizedBox(height: 10),
          STTabOption(
            items: [
              STTabOptionData(
                title: 'Tab1',
              ),
              STTabOptionData(
                title: 'Tab2',
              ),
              STTabOptionData(
                title: 'Tab3',
              ),
              STTabOptionData(
                title: 'Tab4',
              ),
            ],
            selectedChanged: (int index) {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildPageView(_pageController, pageList),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(PageController controller, List<String> list) {
    return PageView.builder(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Text(
          list[index],
          style: TextStyle(color: Colors.black, fontSize: 14),
        );
      },
    );
  }

  Widget _buildPageViewVer(PageController controller, List<String> list) {
    return PageView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Text(
          list[index],
          style: TextStyle(color: Colors.black, fontSize: 14),
        );
      },
    );
  }
}
