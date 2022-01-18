import 'package:flutter/material.dart';
import 'package:saturn/web/st_tree/st_tree.dart';

class STTreeProvider extends ChangeNotifier {
  STTreeProvider({required this.items});

  List<STTreeData> items;

  List<STTreeData> checkItems = [];

  List<STTreeData> searchItems = [];

  void changeOpened({STTreeData? data}) {
    if (data == null) return;
    _findDataChanged(lists: items, data: data, changeOpened: true);
    notifyListeners();
  }

  void changeChecked({STTreeData? data}) {
    if (data == null) return;
    _findDataChanged(lists: items, data: data, changeChecked: true);
    notifyListeners();
  }

  void _findDataChanged({
    required List<STTreeData> lists,
    required STTreeData data,
    bool? changeOpened,
    bool? changeChecked,
  }) {
    for (final item in lists) {
      if (item == data) {
        if (changeOpened != null && changeOpened) {
          item.isOpened = !item.isOpened;
        } else if (changeChecked != null && changeChecked) {
          item.checked = !item.checked;
          _dealCheckedItem(item);
        }
        break;
      }
      if (item.subs != null && item.subs!.isNotEmpty) {
        _findDataChanged(
          lists: item.subs!,
          data: data,
          changeOpened: changeOpened,
          changeChecked: changeChecked,
        );
      }
    }
  }

  void _dealCheckedItem(STTreeData data) {
    if (data.checked) {
      checkItems.add(data);
    } else {
      for (int i = 0; i < checkItems.length; i++) {
        final _temp = checkItems[i];
        if ((_temp.key ?? _temp.title) == (data.key ?? data.title)) {
          checkItems.removeAt(i);
          i--;
          break;
        }
      }
    }
    if (data.subs != null && data.subs!.isNotEmpty) {
      for (final _temp in data.subs!) {
        _temp.checked = data.checked;
        _dealCheckedItem(_temp);
      }
    }
  }

  void search(String search) {
    searchItems = [];
    _findItem(search, items);
    for (final item in searchItems) {
      _changedSearchItemsOpened(item, STTreeData(title: '_', subs: items));
    }
    notifyListeners();
  }

  /// 1.找到对应的data
  void _findItem(String search, List<STTreeData> datas) {
    for (final item in datas) {
      if ((item.key != null && item.key!.contains(search)) ||
          item.title.contains(search)) {
        searchItems.add(item);
      }
      if (item.subs != null && item.subs!.isNotEmpty) {
        _findItem(search, item.subs!);
      }
    }
  }

  /// 2.逐级往上打开
  void _changedSearchItemsOpened(STTreeData data, STTreeData? list) {
    if (list == null) return;
    if (list.subs != null && list.subs!.isNotEmpty) {
      if (list.subs!.contains(data)) {
        list.isOpened = true;
        _changedSearchItemsOpened(list, STTreeData(title: '_', subs: items));
        return;
      } else {
        for (final temp in list.subs!) {
          _changedSearchItemsOpened(data, temp);
        }
      }
    }
  }
}
