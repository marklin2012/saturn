import 'dart:async';

// class STDebounce {
//   static final STDebounce _instance = STDebounce._internal();

//   factory STDebounce() => _instance;

//   STDebounce._internal();

//   Timer _debounce;

//   /// 可外部设置时间间隔
//   int _timeInterval = 2000;

//   /* 设置时间间隔 */
//   // ignore: avoid_setters_without_getters
//   set timeInterval(int time) {
//     _timeInterval = time;
//   }

//   void debounce(Function fn) {
//     if (_debounce?.isActive ?? false) _debounce.cancel();
//     _debounce = null;
//     _debounce = Timer(Duration(milliseconds: _timeInterval), () {
//       fn();
//     });
//   }

//   void cancel() {
//     _debounce?.cancel();
//     _debounce = null;
//   }

//   void longDebounce(Function fn, {int time = 5000}) {
//     if (_debounce?.isActive ?? false) _debounce.cancel();
//     _debounce = null;
//     _debounce = Timer(Duration(milliseconds: time), () {
//       fn();
//     });
//   }
// }

class STDebounce {
  factory STDebounce() => _getInstance();

  static STDebounce get instance => _getInstance();

  static STDebounce? _instance;

  late Map<String?, Timer> _map;

  // ignore: prefer_constructors_over_static_methods
  static STDebounce _getInstance() {
    return _instance ??= STDebounce._internal();
  }

  STDebounce._internal() {
    _map = {};
  }

  /// 根据key来创建和删除Timer
  Future<void> start({
    String? key,
    Function()? func,
    int time = 500,
  }) async {
    /// 先判断是否有key存在的Timer，有的话先取消的这个Timer
    cancel(key: key);

    /// 创建新的Timer
    final _debounce = Timer(Duration(milliseconds: time), () {
      if (func != null) {
        func();
      }

      /// 完成后取消Timer
      cancel(key: key);
    });

    /// 更新Map
    _map[key] = _debounce;
  }

  void cancel({
    String? key,
  }) {
    Timer? _temp = _map[key];
    if (_temp != null) {
      _temp.cancel();
      _temp = null;
    }
  }
}
