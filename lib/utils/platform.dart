import 'dart:io';

// 判断是否在Web上，Web上需要计算本身的高度
bool getIsWeb() {
  var kisWeb = false;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      kisWeb = false;
    } else {
      kisWeb = true;
    }
  } catch (e) {
    kisWeb = true;
  }
  return kisWeb;
}
