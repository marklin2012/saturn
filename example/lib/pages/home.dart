import 'package:flutter/material.dart';

import 'package:example/pages/checkbox.dart';
import 'package:example/pages/select.dart';
import 'package:example/pages/slider.dart';
import 'package:example/pages/stepper.dart';
import 'package:example/pages/tabbar.dart';

import 'package:example/models/page_model.dart';
import 'package:example/pages/input.dart';
import 'package:example/pages/icons.dart';

import 'package:example/pages/badge.dart';
import 'package:example/pages/button.dart';
import 'package:example/pages/radio.dart';
import 'package:example/pages/switch.dart';
import 'package:example/pages/picker.dart';
import 'package:example/pages/steps.dart';
import 'package:example/pages/cascader.dart';
import 'package:example/pages/card.dart';
import 'package:example/pages/video.dart';

import 'package:example/pages/loading.dart';
import 'package:example/pages/alert.dart';
import 'package:example/pages/tooltip.dart';
import 'package:example/pages/toast.dart';
import 'package:example/pages/snackbar.dart';
import 'package:example/pages/tag.dart';
import 'package:example/pages/message.dart';
import 'package:example/pages/progress.dart';

List<PageModel> _pages = [
  PageModel(name: 'Progress', page: ProgressPage()),
  PageModel(name: 'Input', page: InputPage()),
  PageModel(name: 'Loading', page: LoadingPage()),
  PageModel(name: 'Alert', page: AlertPage()),
  PageModel(name: 'Badge', page: BadgePage()),
  PageModel(name: 'tooltip', page: TooltipPage()),
  PageModel(name: 'Button', page: ButtonPage()),
  PageModel(name: 'Toast', page: ToastPage()),
  PageModel(name: 'message', page: MessagePage()),
  PageModel(name: 'Switch', page: SwitchPage()),
  PageModel(name: 'Radio', page: RadioPage()),
  PageModel(name: 'Checkbox', page: CheckboxPage()),
  PageModel(name: 'Stepper', page: StepperPage()),
  PageModel(name: 'Slider', page: SliderPage()),
  PageModel(name: 'Icon', page: IconPage()),
  PageModel(name: 'Snackbar', page: SnackbarPage()),
  PageModel(name: 'Select', page: SelectPage()),
  PageModel(name: 'Picker', page: PickerPage()),
  PageModel(name: 'Steps', page: StepsPage()),
  PageModel(name: 'Cascader', page: CascaderPage()),
  PageModel(name: 'Card', page: CardPage()),
  PageModel(name: 'Video', page: VideoPage()),
  PageModel(name: 'Tag', page: TagPage()),
  PageModel(name: 'Tabbar', page: TabbarPage()),
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
