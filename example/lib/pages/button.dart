import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  ValueNotifier<int> _testDebounceNoti1;
  ValueNotifier<int> _testDebounceNoti2;

  @override
  void initState() {
    super.initState();
    _testDebounceNoti1 = ValueNotifier(0);
    _testDebounceNoti2 = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('buttons'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            _buildButtonType(),
            SizedBox(height: 20.0),
            _buildButtonIcon(),
            SizedBox(height: 20.0),
            _buildButtonSize(),
            SizedBox(height: 20.0),
            _buildButtonLoading(),
            SizedBox(height: 20.0),
            _buildButtonDisable(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('按钮类型'),
        SizedBox(height: 15.0),
        ValueListenableBuilder(
          valueListenable: _testDebounceNoti1,
          builder: (context, int value, _) {
            return Text(value.toString());
          },
        ),
        SizedBox(height: 5.0),
        STButton(
          onTap: () {
            _testDebounceNoti1.value += 1;
          },
        ),
        SizedBox(height: 15.0),
        ValueListenableBuilder(
          valueListenable: _testDebounceNoti2,
          builder: (context, int value, _) {
            return Text(value.toString());
          },
        ),
        SizedBox(height: 5.0),
        STButton(
          type: STButtonType.outline,
          debounce: false,
          onTap: () {
            _testDebounceNoti2.value += 1;
          },
        ),
        SizedBox(height: 15.0),
        STButton(type: STButtonType.danger, text: 'Danger'),
        SizedBox(height: 15.0),
        STButton(type: STButtonType.text, text: 'Link'),
      ],
    );
  }

  Widget _buildButtonIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('图标按钮'),
        SizedBox(height: 15.0),
        STButton(
          icon: Icon(
            Icons.star_outline,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.0),
        STButton(
          type: STButtonType.outline,
          icon: Icon(
            Icons.star_outline,
            color: Color(0xFF095BF9),
          ),
        ),
        SizedBox(height: 15.0),
        STButton.icon(
          icon: Icon(
            Icons.star_outline,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('按钮尺寸'),
        SizedBox(height: 15.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            STButton(text: 'Large'),
            SizedBox(width: 20.0),
            STButton(size: STButtonSize.small, text: 'Small'),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            STButton.icon(
              icon: Icon(
                Icons.star_outline,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20.0),
            STButton.icon(
              size: STButtonSize.small,
              icon: Icon(
                Icons.star_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('加载中状态'),
        SizedBox(height: 15.0),
        STButton(text: 'Large', loading: true),
        SizedBox(height: 15.0),
        STButton(type: STButtonType.outline, text: 'Large', loading: true),
        SizedBox(height: 15.0),
        STButton.icon(
          icon: Icon(
            Icons.star_outline,
            color: Colors.white,
          ),
          loading: true,
        ),
      ],
    );
  }

  Widget _buildButtonDisable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('禁用状态'),
        SizedBox(height: 15.0),
        STButton(text: 'Large', disabled: true),
        SizedBox(height: 15.0),
        STButton(type: STButtonType.outline, text: 'Large', disabled: true),
        SizedBox(height: 15.0),
        STButton.icon(
          icon: Icon(
            Icons.star_outline,
            color: Colors.white,
          ),
          disabled: true,
        ),
      ],
    );
  }
}
