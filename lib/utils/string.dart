bool isNullOrEmpty(String? str) {
  if (str == null || str.isEmpty) {
    return true;
  } else {
    return false;
  }
}

bool isNotEmpty(String? str) {
  return !isNullOrEmpty(str);
}
