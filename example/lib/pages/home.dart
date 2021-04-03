import 'package:example/pages/checkbox.dart';
import 'package:flutter/material.dart';

import 'package:example/models/page_model.dart';
import 'package:example/pages/button.dart';
import 'package:example/pages/input.dart';
import 'package:example/pages/radio.dart';
import 'package:example/pages/switch.dart';

List<PageModel> _pages = [
  PageModel(name: 'Input', page: InputPage()),
  PageModel(name: 'Button', page: ButtonPage()),
  PageModel(name: 'Switch', page: SwitchPage()),
  PageModel(name: 'Radio', page: RadioPage()),
  PageModel(name: 'Checkbox', page: CheckboxPage()),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examples'),
      ),
      body: ListView.builder(
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          final PageModel model = _pages[index];
          return ListTile(
            title: Text(model.name),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => model.page));
            },
          );
        },
      ),
    );
  }
}
