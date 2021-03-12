# Saturn

> Saturn： 土星，八大行星之一。土星不是单一的个体，他有为数众多的卫星，形成令人印象深刻的行星环系统，寓意该项目可以为你的项目提供众多美丽实用的组件。


# 导航

- [系统依赖](#系统依赖)
- [如何安装](#如何安装)
- [项目目录结构](#项目目录结构)
- [代码分支规范](#代码分支规范)
- [代码开发指南](#代码开发指南)

# 系统依赖

1. **请安装 Flutter 稳定版本 2.0.1**   [flutter 2.0.1](https://storage.flutter-io.cn/flutter_infra/releases/stable/macos/flutter_macos_2.0.1-stable.zip) （flutter.cn 的下载地址）

2. **Flutter 安装教程** [Flutter.cn 教程](https://flutter.cn/docs/get-started/install/macos)

3. **由于科学上网原因，Google 服务器在国内并不稳定， 国内可以在终端内使用国内的镜像源(可选)**

```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

# 如何安装

1. 安装系统依赖
    
    请按照上述的清单安装系统依赖

2. 下载本项目代码 

    ```bash
    git clone https://github.com/marklin2012/saturn.git
    ```
3. 安装 flutter 包依赖

    ```bash
    flutter packages get
    ```

4. 运行模拟器

    打开一个 iOS / Android 模拟器运行

5. 运行项目代码

    ```bash
    flutter run
    
    // 多设备运行
    flutter run -d all

    ```

# 项目目录结构

> 待补充

# 代码分支规范

## 特殊分支

| 分支名称   | 直接提交代码 | 提交 PR           | 合并 PR         | 说明                                 |
| ---------- | ------------ | ----------------- | --------------- | ------------------------------------ |
| **master** | NO           | 一般只接收 `fix/` | NO (管理员除外) | 代码一般从 dev 分支合并              |
| **dev**    | NO           | YES               | YES             | 日常开发分支                         |
| **test**   | YES          | YES               | YES             | 测试线分支，有想测试的代码都合到这里 |

## 普通分支

如果想修复线上代码，建议从 `master` 分支拉一个新的分支，命名为 `fix/xxx` 分支。  
日常开发或者重构，建议从 `dev` 分支拉新的分支，命名为 `feat/xxx` 或者 `refactor/xxx`。

| 分支前缀      | 说明     |
| ------------- | -------- |
| **feat/**     | 需求开发 |
| **fix/**      | BUG 修复 |
| **refactor/** | 重构     |

# 代码提交

（待部署提交语法检查）~~代码提交前会**自动**检查代码语法，检查不过关会提交失败。~~

需要注意：

- 检查每行被 staged 的代码，不要提交无关重要的代码！
- 不要提交无意义的 `print()`
- 合并代码时记得通过提 PR 的方式，并且 assign 给管理员：

## Git 提交规范

提交的格式为：`<type>: <subject>`，type用于说明 commit 的类别，subject是 commit 原因的简短描述，type可以使用如下类别：

| commit 前缀      | 说明     |
| ------------- | -------- |
| **init:**     | 项目初始化 |
| **feat:**     | 增加新功能 |
| **fix:**      | 修补bug   |
| **doc:**      | 修改文档   |
| **change:**   | 不影响代码功能的变动   |
| **refactor:** | 对某个功能进行了重构   |
| **test:**     | 增加测试   |
| **chore:**     | 构建过程或辅助工具的变动   |

> 比如我在 Flutter Package 工程里新增了一个组件， commit 的格式就是 feat:新增XX组件



# 代码开发指南

## 命名

Class，enums，typedefs， extensions 名字应该使用 *大写字母开头的驼峰命名* `UpperCamelCase`

```dart
class MainScreen { ... }
enum MainItem { .. }
typedef Predicate<T> = bool Function(T value);
extension MyList<T> on List<T> { ... }
```

Libraries, packages, 目录文件, 源文件这些应该使用 *小写字母加下划线的形式* `lowercase_with_underscores`

```dart 
library firebase_dynamic_links;

import 'socket/socket_manager.dart';
```

变量、常量、参数、形参这些使用 *小写字母开头的驼峰命名* `lowerCamelCase`

```dart
var item;
const bookPrice = 3.14;
final urlScheme = RegExp('^([a-z]+):');
void sum(int bookPrice) {
  // ...
}
```

### 在 lib 目录重使用相对路径
当同时使用相对路径和绝对路径导入时，两种不同的方式导入同一类时，可能会造成混乱。为了避免这种情况，我们应该在 `lib` 目录中使用相对路径。

```dart
// Don't
import 'package:demo/src/utils/dialog_utils.dart';


// Do
import '../../../utils/dialog_utils.dart';
```

### 为类成员指定类型
值类型已知时，请务必指定成员的类型，尽可能避免使用 var

```dart
//Don't
var item = 10;
final car = Car();
const timeOut = 2000;

//Do
int item = 10;
final Car bar = Car();
String name = 'john';
const int timeOut = 20;
```

### 避免使用 `as` ，使用 `is` 运算符
通常情况下，如果无法进行强制转换，则 `as` 强制转换运算符会引发异常。为了避免引发异常，可以使用 `is`

```dart
//Don't
(item as Animal).name = 'Lion';


//Do
if (item is Animal)
  item.name = 'Lion';
```

### 用 `if` 替代条件表达式
很多时候，我们需要根据行和列中的某种条件来渲染小的组件。如果条件表达式在任何情况下都返回 *null*，则应仅使用 `if` 条件表达式。

```dart
//Don't
Widget getText(BuildContext context) {
  return Row(
    children: [
      Text("Hello"),
      Platform.isAndroid ? Text("Android") : null,
      Platform.isAndroid ? Text("Android") : SizeBox(),
      Platform.isAndroid ? Text("Android") : Container(),
    ]
  );
}


//Do
Widget getText(BuildContext context) {
  return Row(
      children: 
      [
        Text("Hello"), 
        if (Platform.isAndroid) Text("Android")
      ]
  );
}
```

### 使用 `??` 和 `?.` 操作符
优先使用 `??` （如果为 null ）和 `?.`（可识别空值）运算符，少用条件表达式做空值检查。

```dart
//Don't
v = a == null ? b : a;

//Do
v = a ?? b;


//Don't
v = a == null ? null : a.b;

//Do
v = a?.b;
```

### 使用扩展集合语法 
当现有内容已经存储在另一个集合中时，扩展集合语法会使代码更简洁。

```dart
//Don't
var y = [4,5,6];
var x = [1,2];
x.addAll(y);


//Do
var y = [4,5,6];
var x = [1,2,...y];
```

### 使用级联运算符
如果我们不想对同一对象执行一系列操作，则应使用Cascades（..）运算符。

```dart
// Don't
var path = Path();
path.lineTo(0, size.height);
path.lineTo(size.width, size.height);
path.lineTo(size.width, 0);
path.close();  


// Do
var path = Path()
..lineTo(0, size.height)
..lineTo(size.width, size.height)
..lineTo(size.width, 0)
..close(); 
```

### 使用原始字符串
使用原始字符串可以用在避免对特殊字符进行转译的场景

```dart
//Don't
var s = 'This is demo string \\ and \$';


//Do
var s = r'This is demo string \ and $';
```

### 不要显式地把变量初始化为 null
在Dart中，如果未指定变量的值，则变量会自动初始化为null，因此添加null是多余且不需要的。

```dart
//Don't
int _item = null;


//Do
int _item;
```

### 使用表达函数体
对于仅包含一个表达式的函数，可以使用表达函数体的方式。

```dart

//Don't
get width {
  return right - left;
}
Widget getProgressBar() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
  );
}


//Do
get width => right - left;
Widget getProgressBar() => CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
```

### 提交代码前，避免提交 `print()` 代码调用
`print()` 和 `debugPrint()` 都用于在控制台中登录。如果您使用 `print()` 并且一次输出太多，则Android有时会丢弃一些日志行。为了避免这种情况，请使用 `debugPrint()`。

### 尽可能地把 `widget` 拆分成不同的小 `widget`
在 State上 调用 `setState()` 时，所有后代 `widget` 都将重建。因此，将 `widget` 拆分为小 `widget`，以便 `setState()` 调用实际上需要更改其 UI 的子树部分。

```dart
Scaffold(
  appBar: CustomAppBar(title: "Verify Code"), // Sub Widget
  body: Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TimerView( // Sub Widget
            key: _timerKey,
            resendClick: () {})
      ],
    ),
  ),
)
```

### 构建长列表时使用 `ListView.builder`
当使用无限列表或非常长的列表时，通常建议使用 `ListView` 构建器以提高性能。

默认的 `ListView` 构造函数可一次构建整个列表。 `ListView.builder` 创建一个惰性列表，并且当用户向下滚动列表时，`Flutter` 会按需构建 `widget`。

### 使用 `const widget` 
在 `setState` 调用时不会改变的 `widget`，我们应该将其定义为常量。这将防止 `widget` 重建，从而提高渲染性能。

