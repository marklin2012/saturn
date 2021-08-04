class STCascaderItem {
  final String value;
  final String key;
  final List<STCascaderItem> items;

  const STCascaderItem({value, key, items})
      : key = key ?? value,
        value = value ?? '',
        // ignore: prefer_initializing_formals
        items = items;
}
