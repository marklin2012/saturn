
class STCascaderItem {
  final String value;
  final String key;
  final List<STCascaderItem>? items;

  const STCascaderItem({key, required this.value, this.items})
      : key = key ?? value;
}
