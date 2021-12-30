import 'package:flutter/material.dart';
import 'package:saturn/web/st_pagination/st_pagination_page.dart';

enum STPaginationType {
  small,
  simple,
  normal,
}

class STPagination extends StatefulWidget {
  const STPagination({
    Key? key,
    this.initCurrent = 1,
    this.initPageSize = 10,
    this.disabled = false,
    this.pageSizeOptions = const [10, 20, 50, 100],
    this.showLessItems = false,
    this.showQuickJumper = false,
    this.showSizeChanger,
    this.showTotal = false,
    this.total = 100,
    this.type = STPaginationType.normal,
    this.onChange,
    this.onShowSizeChange,
  }) : super(key: key);

  final int initCurrent; // 默认的当前页数
  final int initPageSize; // 默认的每页条数
  final bool disabled;
  final List<int> pageSizeOptions; // 指定每页可以显示多少条
  final bool showLessItems; // 是否显示较少页面内容
  final bool showQuickJumper; // 是否可以快速跳转至某页
  final bool? showSizeChanger; // 是否展示PageSize切换器，当total大于50是默认展示
  final bool showTotal; // 用于显示数据总量和当前数据顺序
  final int total; // 数据总数
  final STPaginationType type;
  final Function(int page, int pageSize)?
      onChange; //页码或 pageSize 改变的回调，参数是改变后的页码及每页条数
  final Function(int current, int size)? onShowSizeChange; // pageSize 变化的回调

  @override
  _STPaginationState createState() => _STPaginationState();
}

class _STPaginationState extends State<STPagination> {
  static const _normalHeight = 32.0;
  static const _smallHeight = 24.0;

  late int _current;
  late int _pageSize;
  late List<int> _pageSizeOptions;
  late bool _showSizeChanger;
  late bool _isSmall;

  @override
  void initState() {
    super.initState();
    _current = widget.initCurrent;
    _pageSize = widget.initPageSize;
    _pageSizeOptions = widget.pageSizeOptions;
    _showSizeChanger = widget.showSizeChanger ?? (widget.total >= 50);
    _isSmall = widget.type == STPaginationType.small;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _isSmall ? _smallHeight : _normalHeight,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          STPaginationPage(
            initCurrent: _current,
            initPageSize: _pageSize,
            disabled: widget.disabled,
            total: widget.total,
            type: widget.type,
            onShowSizeChange: (current, size) {},
          ),
        ],
      ),
    );
  }
}
