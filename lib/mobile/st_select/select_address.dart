import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_select/address_chinese.dart';
import 'package:saturn/mobile/st_select/select_show_dialog.dart';
import 'package:saturn/utils/include.dart';

const _selectAddressHeight = 302.0;
const _selectTitleHeight = 48.0;
const _pickerItemExtent = 52.0;
const _textStyle = TextStyle(
  color: Color(0xFF555555),
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

class STSelectAddress extends StatelessWidget {
  const STSelectAddress({
    Key? key,
    this.child,
    this.title,
    this.onChanged,
    this.looping = false,
  }) : super(key: key);

  final Widget? child; // 供外部触发的组件
  final String? title; // 标题
  final bool looping; //是否循环
  final Function(List<String> value)? onChanged; // 点击确定后的回调

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) {
            return ShowSelectDialog(
              menu: STSelectAddressMenu(
                title: title,
                looping: looping,
                onChanged: onChanged,
              ),
              offset: Offset(0, _height - _selectAddressHeight),
              height: _selectAddressHeight,
            );
          },
        );
      },
      child: child,
    );
  }
}

class STSelectAddressMenu extends StatefulWidget {
  const STSelectAddressMenu({
    Key? key,
    this.title,
    this.onChanged,
    this.looping,
  }) : super(key: key);

  final String? title; // 标题
  final bool? looping; //是否循环
  final Function(List<String> value)? onChanged; // 点击确定后的回调

  @override
  State<STSelectAddressMenu> createState() => _STSelectAddressMenuState();
}

class _STSelectAddressMenuState extends State<STSelectAddressMenu> {
  final _baseKey = '0';
  late double _width;
  late Map<String, dynamic> _map;
  final List<String> _selectedKeys = ['', '', ''];
  final List<String> _selectedValues = ['', '', ''];
  final List<String> _provinces = [];
  final List<String> _citys = [];
  final List<String> _areas = [];
  final _provinceController = FixedExtentScrollController();
  final _cityController = FixedExtentScrollController();
  final _areaController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();

    _map = AddressChinese.map;
    _getData();
    _setInitinalValues();
  }

  // ignore: always_declare_return_types
  _getData() async {
    final httpClient = HttpClient();
    final url = Uri(
      scheme: 'https',
      host: 'gitee.com',
      path: 'mingChenxin/province-city-area/raw/master/pca.json',
    );
    final request = await httpClient.getUrl(url);
    request.headers.add(
      'cookie',
      'gitee-session-n=QjJGa2hlSkVsUnQzSWtZMmFPSFkrRHhVZGIxTGhrQlAyN0tjLzZBdXpjNlUwSjJudTlObllLcmxjcjdvSTFmdEJYTTZ3MWVkcWFKREZtZnpYOWhpc2lHSU9xQTArTFU2K1Yxa25PRHU0V2dvQWdYNTlVY0NrU2xIK0NYbnIyWStabkpjL1dJUS9Gc1U0S0V4WDFWY0FVakFVVTEyZG95c0hBc2RaMHdLZWRYYlA2dEc4eFRoMmJGSVp5YmY5WklrblA4VWg3ZGRGM2RRckZYRUFSc29Xa0pwZGkzbUZTcXVNTnZIN3dzOHgyeExkM2kyWEFWeG9icnVMMFRyOFZKMUFmbElLRjE3RU9Ub1dvU3NyT0V2Rkxya3oxWGM1NXQ2YU9MZVBSZkI2dmdIOGJsNk11Zi8xK0lTUEVLdW10S0EyaExjSmNza2NQMXFHdEdXWVNza0lja2FQUDFKTWFObU9yK3J3MnpBMVI0PS0taktGQy9STXZ4RzhvYUc3L0hWbVVidz09--f635486bccbe410866794f7712d90bf9e1473c5a',
    );
    final response = await request.close();
    final _responseString =
        await response.transform(convert.utf8.decoder).join();
    final _responseMap =
        convert.jsonDecode(_responseString) as Map<String, dynamic>;
    debugPrint('${_responseMap.length}');

    if (_responseMap.isNotEmpty) {
      _map = _responseMap;
      _setInitinalValues();
    }
  }

  void _setInitinalValues() {
    if (_map[_baseKey] == null) {
      return;
    }

    Map<String, dynamic> _temps = {};
    if (_map[_baseKey] is Map<String, dynamic>) {
      _temps = _map[_baseKey];
    }
    _temps.forEach((key, value) {
      _provinces.add(value.toString());
    });
    // 默认选择第一个省份
    for (final key in _temps.keys) {
      _selectedKeys.first = key;
      _selectedValues.first = _temps[key]!.toString();
      break;
    }
    // 默认选择第一个省份第一个市
    final _cityKeys = '$_baseKey,${_selectedKeys.first}';
    Map<String, dynamic> _citysMap = {};
    if (_map[_cityKeys] is Map<String, dynamic>) {
      _citysMap = _map[_cityKeys];
    }
    _citys.clear();
    _citysMap.forEach((key, value) {
      _citys.add(value.toString());
    });
    // 默认选择第一个省份第一个市第一个区
    for (final key in _citysMap.keys) {
      _selectedKeys[1] = key;
      _selectedValues[1] = _citysMap[key]!.toString();
      break;
    }
    final _initAreaKey = '$_baseKey,${_selectedKeys.first},${_selectedKeys[1]}';
    Map<String, dynamic> _initAreaMap = {};
    if (_map[_initAreaKey] is Map<String, dynamic>) {
      _initAreaMap = _map[_initAreaKey];
    }
    _initAreaMap.forEach((key, value) {
      _areas.add(value.toString());
    });
    // 默认选择第一个区
    for (final key in _initAreaMap.keys) {
      _selectedKeys.last = key;
      _selectedValues.last = _initAreaMap[key]!.toString();
      break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getTitleChild(context),
          Row(
            children: List.generate(
              3,
              (index) => _getPickerView(index),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _getTitleChild(BuildContext context) {
    return SizedBox(
      height: _selectTitleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              '取消',
              style: TextStyle(color: Color(0xFF888888), fontSize: 17.0),
            ),
          ),
          Text(
            widget.title ?? '省市区',
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.onChanged == null) return;
              widget.onChanged!(_selectedValues);
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Color(0xFF000000), fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPickerView(int i) {
    var _pickerDatas = <String>[];
    FixedExtentScrollController _pickerController;
    if (i == 0) {
      _pickerDatas = _provinces;
      _pickerController = _provinceController;
    } else if (i == 1) {
      _pickerDatas = _citys;
      _pickerController = _cityController;
    } else {
      _pickerDatas = _areas;
      _pickerController = _areaController;
    }
    if (_pickerDatas.isEmpty) {
      return Container();
    }
    return SizedBox(
      width: _width / 3,
      height: _selectAddressHeight - _selectTitleHeight,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: _textStyle,
          ),
        ),
        child: CupertinoPicker(
          itemExtent: _pickerItemExtent,
          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            capStartEdge: false,
            capEndEdge: false,
          ),
          scrollController: _pickerController,
          useMagnifier: true,
          looping: widget.looping!,
          onSelectedItemChanged: (int index) {
            STDebounce().start(
              key: '_selectAddressDebounceKey',
              func: () {
                final _selected = _pickerDatas[index];
                _dealDatas(i, _selected);
              },
              time: 600,
            );
          },
          children: List.generate(_pickerDatas.length, (index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: _pickerItemExtent,
              alignment: Alignment.center,
              child: Text(
                _pickerDatas[index],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _dealDatas(int column, String selectedValue) {
    if (column == 0) {
      // 省数据
      Map<String, dynamic> _temps = {};
      if (_map[_baseKey] is Map<String, dynamic>) {
        _temps = _map[_baseKey]!;
      }
      // 清空已选择的key和value
      List.generate(3, (index) {
        _selectedKeys[index] = '';
        _selectedValues[index] = '';
      });
      // 省份选择成功
      _temps.forEach((key, value) {
        if (selectedValue == value.toString()) {
          _selectedKeys.first = key;
          _selectedValues.first = value.toString();
        }
      });
      // 重置city数据
      final _cityKeys = '$_baseKey,${_selectedKeys.first}';
      Map<String, dynamic> _citysMap = {};
      if (_map[_cityKeys] is Map<String, dynamic>) {
        _citysMap = _map[_cityKeys];
      }
      _citys.clear();
      _citysMap.forEach((key, value) {
        _citys.add(value.toString());
      });
      // 给city赋上默认值
      for (final key in _citysMap.keys) {
        _selectedKeys[1] = key;
        _selectedValues[1] = _citysMap[key]!.toString();
        break;
      }
      // 重置区的数据
      final _initAreaKey =
          '$_baseKey,${_selectedKeys.first},${_selectedKeys[1]}';
      Map<String, dynamic> _initAreaMap = {};
      if (_map[_initAreaKey] is Map<String, dynamic>) {
        _initAreaMap = _map[_initAreaKey];
      }
      _areas.clear();
      _initAreaMap.forEach((key, value) {
        _areas.add(value.toString());
      });
      // 给area赋上默认值
      for (final key in _initAreaMap.keys) {
        _selectedKeys.last = key;
        _selectedValues.last = _initAreaMap[key]!.toString();
        break;
      }
      // picker跳转到初始位置
      _cityController.jumpToItem(0);
      _areaController.jumpToItem(0);

      setState(() {});
    } else if (column == 1) {
      // 获取市区数据
      final _cityKeys = '$_baseKey,${_selectedKeys.first}';
      Map<String, dynamic> _citysMap = {};
      if (_map[_cityKeys] is Map<String, dynamic>) {
        _citysMap = _map[_cityKeys];
      }
      // 市区选择成功
      _citysMap.forEach((key, value) {
        if (selectedValue == value.toString()) {
          _selectedKeys[1] = key;
          _selectedValues[1] = value.toString();
        }
      });
      // 重置区的数据
      final _initAreaKey =
          '$_baseKey,${_selectedKeys.first},${_selectedKeys[1]}';
      Map<String, dynamic> _initAreaMap = {};
      if (_map[_initAreaKey] is Map<String, dynamic>) {
        _initAreaMap = _map[_initAreaKey];
      }
      _areas.clear();
      _initAreaMap.forEach((key, value) {
        _areas.add(value.toString());
      });
      // 给area赋上默认值
      for (final key in _initAreaMap.keys) {
        _selectedKeys.last = key;
        _selectedValues.last = _initAreaMap[key]!.toString();
        break;
      }
      // picker跳转到初始位置
      _areaController.jumpToItem(0);

      setState(() {});
    } else {
      // 获取区的数据
      final _initAreaKey =
          '$_baseKey,${_selectedKeys.first},${_selectedKeys[1]}';
      Map<String, dynamic> _initAreaMap = {};
      if (_map[_initAreaKey] is Map<String, dynamic>) {
        _initAreaMap = _map[_initAreaKey];
      }
      // 区选择成功
      _initAreaMap.forEach((key, value) {
        if (selectedValue == value.toString()) {
          _selectedKeys.last = key;
          _selectedValues.last = value.toString();
        }
      });

      setState(() {});
    }
    debugPrint('$_selectedValues');
  }
}
