import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/web/st_pagination/st_pagination.dart';

class STPaginationPage extends StatefulWidget {
  const STPaginationPage({
    Key? key,
    this.initCurrent = 1,
    this.initPageSize = 10,
    this.disabled = false,
    this.total = 100,
    this.type = STPaginationType.normal,
    this.onShowSizeChange,
  }) : super(key: key);

  final int initCurrent; // 默认的当前页数
  final int initPageSize; // 默认的每页条数
  final bool disabled;
  final int total; // 数据总数
  final STPaginationType type;
  final Function(int current, int size)? onShowSizeChange; // pageSize 变化的回调

  @override
  _STPaginationPageState createState() => _STPaginationPageState();
}

const _maxShowPage = 7;

class _STPaginationPageState extends State<STPaginationPage> {
  late int _current;
  late int _pageSize;
  late int _pageLength;
  late List<int> _showPages;

  @override
  void initState() {
    super.initState();
    _showPages = [1, 2, 3, 4, 5];
    _current = widget.initCurrent;
    _pageSize = widget.initPageSize;
    double _temp = widget.total / _pageSize;
    _pageLength = _temp.ceil();
    _getShowPages();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _showPages.map((e) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(color: STColor.thrRankGrey),
              ),
              alignment: Alignment.center,
              width: 32,
              child: Text(
                e.toString(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _getShowPages() {
    _showPages = [];
    if (_pageLength > _maxShowPage) {
      // 0 表示为省略符
    } else {
      for (int i = 1; i <= _pageLength; i++) {
        _showPages.add(i);
      }
    }
    debugPrint('showPages:$_showPages');
  }
}
