import 'dart:async';

class STDebounce {
  static final STDebounce _instance = STDebounce._internal();

  factory STDebounce() => _instance;

  STDebounce._internal();

  Timer _debounce;

  /// 可外部设置时间间隔
  int _timeInterval = 2000;

  /* 设置时间间隔 */
  // ignore: avoid_setters_without_getters
  set timeInterval(int time) {
    _timeInterval = time;
  }

  void debounce(Function fn) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = null;
    _debounce = Timer(Duration(milliseconds: _timeInterval), () {
      fn();
    });
  }

  void cancel() {
    _debounce?.cancel();
    _debounce = null;
  }

  void longDebounce(Function fn, {int time = 5000}) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = null;
    _debounce = Timer(Duration(milliseconds: time), () {
      fn();
    });
  }
}
