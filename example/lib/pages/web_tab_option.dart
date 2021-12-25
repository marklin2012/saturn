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
  List<Widget> _pageLists = [
    Text('这里是文字内容1'),
    Text('这里是文字内容2'),
    Text('这里是文字内容3'),
    Text('这里是文字内容4'),
  ];
  STTabOptionDirction _dirction = STTabOptionDirction.top;
  String _selectedDirction = 'top';
  STTabOptionSize _size = STTabOptionSize.small;
  String _selectedSize = '小号';
  List<STTabOptionData> _itemDatas = [
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
      isDeleted: false,
    ),
  ];
  List<Widget> _editPages = [
    Text('这里是文字内容1'),
    Text('这里是文字内容2'),
    Text('这里是文字内容3'),
    Text('这里是文字内容4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('tabOption'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildCardContainer(),
              SizedBox(height: 10),
              _buildAddOrDelete(),
              SizedBox(height: 10),
              _buildChangeSize(),
              SizedBox(height: 10),
              _buildChangePositon(),
              SizedBox(height: 10),
              _buildAddOther(),
              SizedBox(height: 10),
              _buildCanScroller(),
              SizedBox(height: 10),
              _buildIconAndBadge(),
              SizedBox(height: 10),
              _buildCenter(),
              SizedBox(height: 10),
              _buildDefault(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('卡片容器', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 4,
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
          pages: _pageLists,
          type: STTabOptionType.boxCard,
          pageBackgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildAddOrDelete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('新增和关闭选项卡', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 4,
          items: _itemDatas,
          pages: _editPages,
          type: STTabOptionType.editCard,
          onDeletedChanged: (int index) {
            _itemDatas.removeAt(index);
            _editPages.removeAt(index);
            setState(() {});
          },
          onAddItemTap: () {
            _itemDatas.add(STTabOptionData(title: 'New Tabs'));
            _editPages.add(Text('新增内容'));
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildChangeSize() {
    List<String> _sizes = ['小号', '中号', '大号'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('大小 描述', style: _textStyle),
        SizedBox(height: 10),
        Row(
          children: _sizes.map((e) {
            return Padding(
              padding: EdgeInsets.only(right: 10),
              child: STButton(
                text: e,
                textStyle: _selectedSize == e
                    ? TextStyle(color: Colors.white)
                    : TextStyle(color: Colors.black),
                backgroundColor:
                    _selectedSize == e ? Colors.blue : Colors.transparent,
                onTap: () {
                  _selectedSize = e;
                  if (e == '小号') {
                    _size = STTabOptionSize.small;
                  } else if (e == '中号') {
                    _size = STTabOptionSize.normal;
                  } else {
                    _size = STTabOptionSize.large;
                  }
                  setState(() {});
                },
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 32,
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
          pages: _pageLists,
          size: _size,
        ),
        STTabOption(
          itemGutter: 4,
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
          pages: _pageLists,
          size: _size,
          type: STTabOptionType.card,
        ),
      ],
    );
  }

  Widget _buildChangePositon() {
    List<String> _positons = ['top', 'bottom', 'left', 'right'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('位置描述', style: _textStyle),
        SizedBox(height: 10),
        Row(
          children: _positons.map((e) {
            return Padding(
              padding: EdgeInsets.only(right: 10),
              child: STButton(
                text: e,
                textStyle: _selectedDirction == e
                    ? TextStyle(color: Colors.white)
                    : TextStyle(color: Colors.black),
                backgroundColor:
                    _selectedDirction == e ? Colors.blue : Colors.transparent,
                onTap: () {
                  _selectedDirction = e;
                  if (e == 'bottom') {
                    _dirction = STTabOptionDirction.bottom;
                  } else if (e == 'left') {
                    _dirction = STTabOptionDirction.left;
                  } else if (e == 'right') {
                    _dirction = STTabOptionDirction.right;
                  } else {
                    _dirction = STTabOptionDirction.top;
                  }
                  setState(() {});
                },
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        STTabOption(
          height: 300,
          itemGutter: 32,
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
          pages: _pageLists,
          dirction: _dirction,
        ),
      ],
    );
  }

  Widget _buildAddOther() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('附加内容', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 32,
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
          pages: _pageLists,
          prefix: STButton(
            text: '左内容按钮',
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            type: STButtonType.outline,
            borderColor: STColor.thrRankGrey,
            backgroundColor: Colors.white,
          ),
          suffix: STButton(
            text: '右内容按钮',
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            type: STButtonType.outline,
            borderColor: STColor.thrRankGrey,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCanScroller() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('滑动', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 32,
          isSlided: true,
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
              disabled: true,
            ),
            STTabOptionData(
              title: 'Tab7',
            ),
            STTabOptionData(
              title: 'Tab8',
            ),
          ],
          pages: List.generate(8, (index) => Text('这里是文字内容${index + 1}')),
        ),
      ],
    );
  }

  Widget _buildIconAndBadge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('带图标和微标', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 32,
          items: [
            STTabOptionData(
              title: 'Tab1',
              icon: STIcons.label_heart_outline,
              badge: 100,
            ),
            STTabOptionData(
              title: 'Tab2',
              disabled: true,
              icon: STIcons.label_fire_outline,
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
          pages: _pageLists,
        ),
      ],
    );
  }

  Widget _buildCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('居中 禁用某一项', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 32,
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
          pages: _pageLists,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }

  Widget _buildDefault() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('默认', style: _textStyle),
        SizedBox(height: 10),
        STTabOption(
          itemGutter: 32,
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
          pages: _pageLists,
        ),
      ],
    );
  }
}
