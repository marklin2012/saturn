import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:saturn/saturn.dart';

const tipTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

class FormPage extends StatefulWidget {
  const FormPage({Key key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var _name = '';
  var _sex = '';
  var _nick = '';
  final _formFirstKey = GlobalKey<FormState>(debugLabel: 'First');
  var _address = '';
  var _id = '';
  var _email = '';
  final _formSecondKey = GlobalKey<FormState>(debugLabel: 'Second');
  var _oldPassword = '';
  var _newPassword = '';
  var _conPassword = '';
  final _formThreeKey = GlobalKey<FormState>(debugLabel: 'Three');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: STUnFocus(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(key: _formFirstKey, child: _buildFirst()),
              SizedBox(height: 20),
              Form(key: _formSecondKey, child: _buildSecond()),
              SizedBox(height: 20),
              Form(key: _formThreeKey, child: _buildThree()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirst() {
    return Column(
      children: [
        STRowOption(
          leading: Text('头像', style: tipTextStyle),
          trailing: STImage.avatar(width: 32),
          isHavRightArrow: true,
        ),
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('姓名', style: tipTextStyle),
          ),
          center: STFormInput(
            placeholder: '必填',
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
            ],
            onSaved: (value) {
              _name = value;
              debugPrint(_name);
            },
            validator: (String value) {
              return value.length >= 2 ? '姓名验证成功' : '姓名不可少于2个字符';
            },
          ),
        ),
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('性别', style: tipTextStyle),
          ),
          center: STFormInput(
            placeholder: '必填',
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
            ],
            onSaved: (value) {
              _sex = value;
              debugPrint(_sex);
            },
            validator: (String value) {
              return value.length >= 1 ? '性别验证成功' : '性别不可少于1个字符';
            },
          ),
          isHavRightArrow: true,
        ),
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('用户昵称', style: tipTextStyle),
          ),
          center: STFormInput(
            placeholder: '必填',
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            onSaved: (value) {
              _nick = value;
              debugPrint(_nick);
            },
            validator: (String value) {
              return value.length >= 6 ? '昵称验证成功' : '昵称不可少于6个字符';
            },
          ),
          isHavRightArrow: true,
        ),
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('出生年月', style: tipTextStyle),
          ),
          trailing: STButton(
            type: STButtonType.text,
            text: '请选择',
            textStyle: TextStyle(
              color: Color(0xFF888888),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              STActionSheet.show(context: context, title: '选择性别', options: [
                STActionSheetOption(
                  title: "男",
                ),
                STActionSheetOption(
                  title: "女",
                ),
                STActionSheetOption(
                  title: "未知",
                ),
              ]);
            },
          ),
          isHavRightArrow: true,
          isHavBottomLine: false,
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: 10, left: 16, right: 16),
        //   child: STButton(
        //     text: '登录',
        //     mainAxisSize: MainAxisSize.max,
        //     onTap: () {
        //       final _state = _formFirstKey.currentState;
        //       if (_state.validate()) {
        //         _state.save();
        //       }
        //     },
        //   ),
        // )
      ],
    );
  }

  Widget _buildSecond() {
    return Column(
      children: [
        STRowOption(
          leading: Icon(STIcons.commonly_home),
          center: STFormInput(
            placeholder: '请输入家庭住址',
            inputFormatters: [
              LengthLimitingTextInputFormatter(40),
            ],
            onSaved: (value) {
              _address = value;
              debugPrint(_address);
            },
            validator: (String value) {
              return value.length >= 12 ? null : '地址长度不低于12位';
            },
          ),
        ),
        STRowOption(
          leading: Icon(STIcons.commonly_userorder_outline),
          center: STFormInput(
            placeholder: '请输入个人ID',
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            onSaved: (value) {
              _id = value;
              debugPrint(_id);
            },
            validator: (String value) {
              return value.length >= 18 ? null : 'ID长度不低于18位';
            },
          ),
        ),
        STRowOption(
          leading: Icon(STIcons.commonly_mail),
          center: STFormInput(
            placeholder: '请输入邮箱地址',
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
            ],
            onSaved: (value) {
              _email = value;
              debugPrint(_email);
            },
            validator: (String value) {
              return value.length >= 10 ? null : '邮箱长度不低于10位';
            },
          ),
          isHavBottomLine: false,
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: 10, left: 16, right: 16),
        //   child: STButton(
        //     text: '保存',
        //     mainAxisSize: MainAxisSize.max,
        //     onTap: () {
        //       final _state = _formSecondKey.currentState;
        //       if (_state.validate()) {
        //         _state.save();
        //       }
        //     },
        //   ),
        // )
      ],
    );
  }

  Widget _buildThree() {
    return Column(
      children: [
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('旧密码', style: tipTextStyle),
          ),
          center: STFormInput(
            placeholder: '请输入旧密码',
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            onSaved: (value) {
              _oldPassword = value;
              debugPrint(_oldPassword);
            },
            validator: (String value) {
              return value.length >= 10 ? null : '密码不可少于10个字符';
            },
          ),
        ),
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('新密码', style: tipTextStyle),
          ),
          center: STFormInput.password(
            placeholder: '请设置新密码',
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            onSaved: (value) {
              _newPassword = value;
              debugPrint(_newPassword);
            },
            validator: (String value) {
              return value.length >= 10 ? null : '密码不可少于10个字符';
            },
          ),
        ),
        STRowOption(
          leading: Container(
            width: 64,
            child: Text('确认密码', style: tipTextStyle),
          ),
          center: STFormInput.password(
            placeholder: '请再次输入新密码',
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            onSaved: (value) {
              _conPassword = value;
              debugPrint(_conPassword);
            },
            validator: (String value) {
              return value.length >= 10 ? null : '密码不可少于10个字符';
            },
          ),
          isHavBottomLine: false,
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: 10, left: 16, right: 16),
        //   child: STButton(
        //     text: '修改',
        //     mainAxisSize: MainAxisSize.max,
        //     onTap: () {
        //       final _state = _formThreeKey.currentState;
        //       if (_state.validate()) {
        //         _state.save();
        //       }
        //     },
        //   ),
        // )
      ],
    );
  }
}
