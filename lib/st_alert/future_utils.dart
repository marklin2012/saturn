import 'package:flutter/material.dart';

class FutureUtils {
  // 单例公开访问点
  factory FutureUtils() => _sharedInstance();

  // 静态私有成员，没有初始化
  static FutureUtils _instance;

  // 私有构造函数
  FutureUtils._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static FutureUtils _sharedInstance() {
    return _instance ??= FutureUtils._();
  }

  void delayedAction(VoidCallback callBack, int time) {
    Future.delayed(
      Duration(seconds: time),
      () {
        callBack();
      },
    );
  }
}
