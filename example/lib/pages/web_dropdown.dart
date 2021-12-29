import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebDropdownPage extends StatefulWidget {
  const WebDropdownPage({Key key}) : super(key: key);

  @override
  _WebDropdownPageState createState() => _WebDropdownPageState();
}

class _WebDropdownPageState extends State<WebDropdownPage> {
  final _itemDatas = [
    STDropdownItemData(title: '1st menu item'),
    STDropdownItemData(
      title: '2nd menu item',
      icon: STIcons.direction_downoutlined,
      disabled: true,
    ),
    STDropdownItemData(title: '3rd menu item'),
    STDropdownItemData(
      title: 'a danger item',
      type: STDropdownItemDataType.danger,
      divider: true,
    ),
    STDropdownItemData(title: '4th menu item'),
  ];

  final _casItemDatas = [
    STDropdownItemData(
      title: 'Navigation One',
      icon: STIcons.label_safetycertificate_outline,
    ),
    STDropdownItemData(
      title: 'Navigation Two',
      icon: STIcons.commonly_addressbook_outline,
      nextDatas: [
        STDropdownItemData(
          title: '选项一',
          nextDatas: [
            STDropdownItemData(title: '选项一'),
            STDropdownItemData(title: '选项二'),
          ],
        ),
        STDropdownItemData(title: '选项二'),
      ],
    ),
    STDropdownItemData(
      title: 'Navigation Three',
      icon: STIcons.commonly_order_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('WebDropdown'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBaisc(),
            SizedBox(height: 20),
            _buildTriggerObject(),
            SizedBox(height: 20),
            _buildAligment(),
            SizedBox(height: 20),
            _buildCascarding(),
            SizedBox(height: 20),
            _buildTriggerRight(),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerRight() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('右键菜单'),
          SizedBox(height: 10),
          STDropdown(
            triggerData: STDropdownTriggerData(
              text: '鼠标右键点击触发',
              textColor: STColor.thrRankGrey,
              triggerMode: STDropdownTriggerMode.clickRight,
            ),
            itemDatas: _itemDatas,
          ),
        ],
      ),
    );
  }

  Widget _buildCascarding() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('多级菜单'),
          SizedBox(height: 10),
          STDropdown(
            triggerData: STDropdownTriggerData(
              text: '鼠标移入查看菜单样式',
              textColor: STColor.firRankBlue,
              isArrow: true,
              triggerMode: STDropdownTriggerMode.onHover,
            ),
            itemDatas: _casItemDatas,
          ),
        ],
      ),
    );
  }

  Widget _buildAligment() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('对齐方向'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: 'Hover me',
                  textColor: STColor.firRankBlue,
                  isArrow: true,
                  triggerMode: STDropdownTriggerMode.onHover,
                ),
                itemDatas: _itemDatas,
              ),
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: 'Hover me',
                  textColor: STColor.firRankBlue,
                  isArrow: true,
                  triggerMode: STDropdownTriggerMode.onHover,
                  aligment: STDropdownTriggerAligment.center,
                ),
                itemDatas: _itemDatas,
              ),
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: 'Hover me',
                  textColor: STColor.firRankBlue,
                  isArrow: true,
                  triggerMode: STDropdownTriggerMode.onHover,
                  aligment: STDropdownTriggerAligment.right,
                ),
                itemDatas: _itemDatas,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerObject() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('触发对象'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: '下拉菜单按钮',
                  isArrow: true,
                  textColor: Colors.black,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                    border: Border.all(color: STColor.thrRankGrey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                itemDatas: _itemDatas,
              ),
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: '下拉菜单按钮',
                  textColor: Colors.black,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                    border: Border.all(color: STColor.thrRankGrey),
                  ),
                  icon: STIcons.commonly_user_outline,
                  padding: EdgeInsets.only(left: 16.0),
                ),
                itemDatas: _itemDatas,
              ),
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: '下拉菜单按钮',
                  textColor: Colors.black,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                    border: Border.all(color: STColor.thrRankGrey),
                  ),
                  icon: STIcons.commonly_pointmenu_outline,
                  padding: EdgeInsets.only(left: 16.0),
                ),
                itemDatas: _itemDatas,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBaisc() {
    return Container(
      color: STColor.fourRankGrey,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('基础用法'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: 'Hover me',
                  isArrow: true,
                  triggerMode: STDropdownTriggerMode.onHover,
                ),
                itemDatas: _itemDatas,
                selectedCallback: (List<STDropdownItemData> selectedItems) {
                  debugPrint('选中的tabs:$selectedItems');
                },
              ),
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: 'Hover me',
                  isArrow: true,
                  triggerMode: STDropdownTriggerMode.onHover,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    border: Border.all(color: STColor.firRankBlue),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                itemDatas: _itemDatas,
              ),
              STDropdown(
                triggerData: STDropdownTriggerData(
                  text: 'Hover me',
                  isArrow: true,
                  triggerMode: STDropdownTriggerMode.onHover,
                  textColor: Colors.white,
                  decoration: BoxDecoration(
                    color: STColor.firRankBlue,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                itemDatas: _itemDatas,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
