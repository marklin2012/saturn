import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_dropdown/st_dropdown_simple.dart';
import 'package:saturn/web/st_pagination/st_page_input.dart';
import 'package:saturn/web/st_pagination/st_pagination_page.dart';

enum STPaginationType {
  small,
  simple,
  normal,
}

const _disableBGColor = Color(0xFFF5F5F5);
const _disableTextColor = STColor.fourRankFont;
const _disbaleBorderColor = Color(0xFFD9D9D9);

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
    this.turnPages,
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
  final List<String>? turnPages; // 左右翻页的文字
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
  late int _maxPage;
  late String _pageSizeStr;
  late List<String> _pageSizeOptions;
  late bool _showSizeChanger;

  bool get isSmall => widget.type == STPaginationType.small;
  bool get isSimple => widget.type == STPaginationType.simple;

  @override
  void initState() {
    super.initState();
    _current = widget.initCurrent;
    _pageSize = widget.initPageSize;
    _pageSizeStr = '$_pageSize条/页';
    _pageSizeOptions = widget.pageSizeOptions.map((e) => '$e条/页').toList();
    _showSizeChanger = widget.showSizeChanger ?? (widget.total > 50);
    _caculateMaxPage();
  }

  void _caculateMaxPage() {
    final _temp = widget.total / _pageSize;
    _maxPage = _temp.ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSmall ? _smallHeight : _normalHeight,
      alignment: Alignment.centerLeft,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        scrollBehavior: STCustomScrollBehavior(),
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isSimple && widget.showTotal) _buildShowTotal(),
                STPaginationPage(
                  current: _current,
                  pageSize: _pageSize,
                  disabled: widget.disabled,
                  total: widget.total,
                  type: widget.type,
                  turnPages: widget.turnPages,
                  onChanged: (current) {
                    _current = current;
                    setState(() {});
                  },
                ),
                if (!isSimple && _showSizeChanger) _buildShowSizeChanger(),
                if (!isSimple && widget.showQuickJumper) _buildQuickJumper(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 显示总量
  Widget _buildShowTotal() {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        'Total ${widget.total} items',
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildShowSizeChanger() {
    final _disabled = widget.disabled;
    var _padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 5);
    if (isSmall) {
      _padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 1);
    }
    return STDropdownSimple(
      initValue: _pageSizeStr,
      entryWidth: 82.0,
      items: _pageSizeOptions,
      disabled: widget.disabled,
      child: Container(
        height: isSmall ? _smallHeight : _normalHeight,
        padding: _padding,
        decoration: BoxDecoration(
          color: _disabled ? _disableBGColor : Colors.white,
          borderRadius: BorderRadius.circular(2.0),
          border: Border.all(
            color: _disabled ? _disbaleBorderColor : STColor.thrRankGrey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _pageSizeStr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _disabled ? _disableTextColor : Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 2),
              child: Icon(
                STIcons.direction_downoutlined,
                size: 14,
                color: STColor.thrRankGrey,
              ),
            ),
          ],
        ),
      ),
      onChanged: (String selectPageSize) {
        if (_pageSizeStr == selectPageSize) return;
        _pageSizeStr = selectPageSize;
        _dealSelectPageSize();
      },
    );
  }

  void _dealSelectPageSize() {
    final _temp = _pageSizeStr.substring(0, _pageSizeStr.length - 3);
    if (int.tryParse(_temp) != null) {
      _pageSize = int.parse(_temp);
      _caculateMaxPage();
    }
    setState(() {});
  }

  Widget _buildQuickJumper() {
    final _disabled = widget.disabled;
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: isSmall ? _smallHeight : _normalHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '跳至 ',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: _disabled ? _disableTextColor : Colors.black,
            ),
          ),
          STpageInput(
            width: isSmall ? 50 : 60,
            onChanged: (String page) {
              if (int.tryParse(page) == null) return;
              final _tempPage = int.tryParse(page)!;
              _current = _tempPage;
              if (_tempPage > _maxPage) {
                _current = _maxPage;
              }
              setState(() {});
            },
          ),
          Text(
            ' 页',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: _disabled ? _disableTextColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
