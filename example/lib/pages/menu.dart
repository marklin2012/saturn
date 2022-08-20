import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _menuDatas = [
    STMenuDataItem(title: '文本1'),
    STMenuDataItem(title: '文本2'),
    STMenuDataItem(title: '文本3'),
    STMenuDataItem(title: '文本4'),
    STMenuDataItem(title: '文本5'),
    STMenuDataItem(title: '文本6'),
    STMenuDataItem(title: '文本7'),
  ];
  var _baseIndex = 0;
  var _underlineIndex = 0;
  var _sectionIndex = 0;
  var _scrollIndex = 0;
  var _tagIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 24, bottom: 16, right: 8),
                child: Text(
                  '基本用法',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              STMenu(
                onTap: (index) {
                  print('切换到第$index个内容');
                  setState(() {
                    _baseIndex = index;
                  });
                },
                initIndex: _baseIndex,
                items: _menuDatas,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 24, bottom: 16, right: 8),
                child: Text(
                  '下划线样式',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              STMenu(
                type: STMenuType.underline,
                itemPadding: const EdgeInsets.symmetric(horizontal: 12),
                onTap: (index) {
                  print('切换到第$index个内容');
                  setState(() {
                    _underlineIndex = index;
                  });
                },
                items: _menuDatas,
                initIndex: _underlineIndex,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 24, bottom: 16, right: 8),
                child: Text(
                  '分段样式',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              STMenu(
                type: STMenuType.section,
                onTap: (index) {
                  print('切换到第$index个内容');
                  setState(() {
                    _sectionIndex = index;
                  });
                },
                items: _menuDatas,
                initIndex: _sectionIndex,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 24, bottom: 16, right: 8),
                child: Text(
                  '滚动样式',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              STMenu(
                type: STMenuType.section,
                onTap: (index) {
                  print('切换到第$index个内容');
                  setState(() {
                    _scrollIndex = index;
                  });
                },
                items: _menuDatas,
                initIndex: _scrollIndex,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 24, bottom: 16, right: 8),
                child: Text(
                  '标签样式',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              STMenu(
                type: STMenuType.label,
                padding: EdgeInsets.zero,
                itemPadding: EdgeInsets.symmetric(horizontal: 10),
                onTap: (index) {
                  print('切换到第$index个内容');
                  setState(() {
                    _tagIndex = index;
                  });
                },
                items: [
                  STMenuDataItem(title: '文本1', icon: Icons.home),
                  STMenuDataItem(title: '文本2', icon: Icons.favorite),
                  STMenuDataItem(title: '文本3', icon: Icons.history),
                  STMenuDataItem(title: '文本4', icon: STIcons.commonly_wallet),
                  STMenuDataItem(title: '文本5', icon: Icons.settings),
                ],
                initIndex: _tagIndex,
              ),
            ],
          )),
    );
  }
}
