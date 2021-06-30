import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            STMenu(
              onTap: (index) {
                print('切换到第$index个内容');
              },
              items: [
                STMenuDataItem(title: '文本1'),
                STMenuDataItem(title: '文本2'),
                STMenuDataItem(title: '文本3'),
                STMenuDataItem(title: '文本4'),
                STMenuDataItem(title: '文本5'),
                // STMenuDataItem(title: '文本6'),
                // STMenuDataItem(title: '文本7'),
              ],
            ),
            STMenu(
              type: STMenuType.underline,
              onTap: (index) {
                print('切换到第$index个内容');
              },
              items: [
                STMenuDataItem(title: '文本1'),
                STMenuDataItem(title: '文本2'),
                STMenuDataItem(title: '文本3'),
                STMenuDataItem(title: '文本4'),
                STMenuDataItem(title: '文本5'),
                // STMenuDataItem(title: '文本6'),
                // STMenuDataItem(title: '文本7'),
              ],
            ),
            STMenu(
              type: STMenuType.section,
              onTap: (index) {
                print('切换到第$index个内容');
              },
              items: [
                STMenuDataItem(title: '文本1'),
                STMenuDataItem(title: '文本2'),
                STMenuDataItem(title: '文本3'),
                STMenuDataItem(title: '文本4'),
                STMenuDataItem(title: '文本5'),
                // STMenuDataItem(title: '文本6'),
                // STMenuDataItem(title: '文本7'),
              ],
            ),
            STMenu(
              type: STMenuType.label,
              onTap: (index) {
                print('切换到第$index个内容');
              },
              items: [
                STMenuDataItem(title: '文本1', icon: Icons.home),
                STMenuDataItem(title: '文本2', icon: Icons.favorite),
                STMenuDataItem(title: '文本3', icon: Icons.history),
                STMenuDataItem(title: '文本4', icon: STIcons.commonly_wallet),
                STMenuDataItem(title: '文本5', icon: Icons.settings),
                // STMenuDataItem(title: '文本6'),
                // STMenuDataItem(title: '文本7'),
              ],
            ),
          ],
        ));
  }
}
