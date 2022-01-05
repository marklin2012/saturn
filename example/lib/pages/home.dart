import 'package:example/pages/carousel.dart';
import 'package:example/pages/emptydata.dart';
import 'package:example/pages/form.dart';
import 'package:example/pages/grid.dart';
import 'package:example/pages/image.dart';
import 'package:example/pages/list_cell.dart';
import 'package:example/pages/menu.dart';
import 'package:example/pages/web_breadcrumb/web_breadcrumb.dart';
import 'package:example/pages/web_dropdown.dart';
import 'package:example/pages/web_pagnation.dart';
import 'package:example/pages/web_tab_option.dart';
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
import 'package:example/pages/dialog.dart';
import 'package:example/pages/toast.dart';
import 'package:example/pages/snackbar.dart';
import 'package:example/pages/tag.dart';
import 'package:example/pages/message.dart';
import 'package:example/pages/actionSheet.dart';
import 'package:example/pages/progress.dart';

List<PageModel> _pages = [
  PageModel(name: 'ActionSheet', page: ActionSheetPage()),
  PageModel(name: 'Alert', page: AlertPage()),
  PageModel(name: 'Badge', page: BadgePage()),
  PageModel(name: 'Button', page: ButtonPage()),
  PageModel(name: 'Card', page: CardPage()),
  PageModel(name: 'Carousel', page: CarouselPage()),
  PageModel(name: 'Cascader', page: CascaderPage()),
  PageModel(name: 'Checkbox', page: CheckboxPage()),
  PageModel(name: 'Dialog', page: DialogPage()),
  PageModel(name: 'EmptyData', page: EmptyDataPage()),
  PageModel(name: 'Form', page: FormPage()),
  PageModel(name: 'GridView', page: GridViewPage()),
  PageModel(name: 'Icon', page: IconPage()),
  PageModel(name: 'Image', page: ImagePage()),
  PageModel(name: 'Input', page: InputPage()),
  PageModel(name: 'ListCell', page: ListCellPage()),
  PageModel(name: 'Loading', page: LoadingPage()),
  PageModel(name: 'Menu', page: MenuPage()),
  PageModel(name: 'Message', page: MessagePage()),
  PageModel(name: 'Picker', page: PickerPage()),
  PageModel(name: 'Progress', page: ProgressPage()),
  PageModel(name: 'Radio', page: RadioPage()),
  PageModel(name: 'Select', page: SelectPage()),
  PageModel(name: 'Slider', page: SliderPage()),
  PageModel(name: 'Snackbar', page: SnackbarPage()),
  PageModel(name: 'Stepper', page: StepperPage()),
  PageModel(name: 'Steps', page: StepsPage()),
  PageModel(name: 'Switch', page: SwitchPage()),
  PageModel(name: 'Tabbar', page: TabbarPage()),
  // if (getIsWeb())
  PageModel(
    name: 'WebBreadcrumb',
    page: WebBreadCrumbPage(),
    routeName: WebBreadCrumbPage.routeName,
  ),
  PageModel(name: 'WebDropdown', page: WebDropdownPage()),
  PageModel(name: 'WebTabOption', page: WebTapOptionPage()),
  PageModel(name: 'WebPagination', page: WebPaginationPage()),
  PageModel(name: 'Tag', page: TagPage()),
  PageModel(name: 'Toast', page: ToastPage()),
  PageModel(name: 'Tooltip', page: TooltipPage()),
  PageModel(name: 'Video', page: VideoPage()),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => model.page,
                  settings: RouteSettings(name: model.routeName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
