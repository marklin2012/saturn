import 'package:example/models/page_model.dart';
import 'package:example/pages/badge.dart';
import 'package:example/pages/button.dart';
import 'package:example/pages/icons.dart';

import 'package:example/pages/input.dart';
import 'package:example/pages/loading.dart';
import 'package:example/pages/alert.dart';
import 'package:example/pages/tooltip.dart';
import 'package:flutter/material.dart';

List<PageModel> _pages = [
  PageModel(name: 'Input', page: InputPage()),
  PageModel(name: 'Loading', page: LoadingPage()),
  PageModel(name: 'Alert', page: AlertPage()),
  PageModel(name: 'Badge', page: BadgePage()),
  PageModel(name: 'tooltip', page: TooltipPage()),
  PageModel(name: 'Button', page: ButtonPage()),
  PageModel(name: 'Icon', page: IconPage()),
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
