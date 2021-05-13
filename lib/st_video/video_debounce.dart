import 'dart:async';

class STDebounce {
  static final STDebounce _instance = STDebounce._internal();

  factory STDebounce() => _instance;

  STDebounce._internal();

  Timer _debounce;

  void debounce(Function fn, [int time = 5000]) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = null;
    _debounce = Timer(Duration(milliseconds: time), () {
      fn();
    });
  }

  void cancel() {
    _debounce?.cancel();
    _debounce = null;
  }
}
