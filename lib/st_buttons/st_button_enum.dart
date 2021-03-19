// 提供四种样式的按钮
enum STButtonType {
  // 实心主按钮
  main,
  // 描边按钮
  outLine,
  // 文本按钮
  text,
  // 图形按钮
  icon,
}

// 提供两种大小样式的按钮
enum STButtonSize {
  big,
  small,
}

// 提供六种状态样式的按钮
enum STButtonState {
  // 默认
  main,
  // 点击
  focus,
  // 加载
  loading,
  // 禁用
  disable,
  // 成功
  success,
  // 危险
  danger,
}
