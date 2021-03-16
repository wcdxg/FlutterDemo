# 

Flutter

## 1.Widget

`StatelessWidget`组件用于不需要更新界面的情况,`StatefulWidget`用于更新界面的情况,不同之处在于 `StatefulWidget` 有一个跨帧存储和恢复状态数据的 `State` 对象。

## 2.页面跳转切换

Flutter中没有Intent,页面跳转使用`Navigator`和`Routes`,`Routes`类似于`Activity`,`Navigator`是管理`Routes`的工具,Navigator 的工作原理和栈相似，你可以将想要跳转到的 route 压栈 (`push()`)，想要返回的时候将 route 弹栈 (`pop()`)。对于需要调用外部的组件,例如相机或者文件选择器,[可以集成原生平台插件](https://pub.flutter-io.cn/flutter/)

* 通过将 route 名压栈 (push) 到 Navigator 中来跳转到这个 route。

```dart
Navigator.of(context).pushNamed('/b');
Navigator.of(context).pop('/b')
```

## 3.网络请求

Flutter中网络请求可以添加`http`包,如果要使用 `http` 包，需要在 `pubspec.yaml` 文件中添加依赖：

```dart
dependencies:
  ...
  http: ^0.11.3+16
```

如果要发起一个网络请求，在异步 (`async`) 方法 `http.get()` 上调用 `await` 即可：

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
[...]
  Future<void> loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = jsonDecode(response.body);
    });
  }
}
```

## 4.资源文件的引用

### 图片视频等资源的引用

虽然 Android 区分对待资源文件 (resources) 和资产文件 (assets)，但是 Flutter 应用只有资产文件 (assets)。所有原本在 Android 中应该放在 `res/drawable-*` 文件夹中的资源文件，在 Flutter 中都放在一个 assets 文件夹中。

| Android 密度修饰符 | Flutter 像素比例 |
| ------------------ | ---------------- |
| `ldpi`             | `0.75x`          |
| `mdpi`             | `1.0x`           |
| `hdpi`             | `1.5x`           |
| `xhdpi`            | `2.0x`           |
| `xxhdpi`           | `3.0x`           |
| `xxxhdpi`          | `4.0x`           |

文件放置于任意文件夹中,需要在 `pubspec.yaml` 文件中定义文件（包括位置信息），Flutter 负责找到它们。

```dart
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

接下来，你需要在 `pubspec.yaml` 文件中定义这些图片：

```dart
assets:
 - images/my_icon.jpeg
```

然后你就可以使用 `AssetImage` 访问你的图片了：

```dart
 Image.asset("images/my_icon.png");
```

可以指定引用一个目录下的所有assets,需要在目录名称的结尾加上 `/`：仅包含该目录下的所有文件以及子目录下的同名文件,不包含子目录下的其他文件

```
flutter:
  assets:
    - directory/
    - directory/subdirectory/

```

为不同设备像素指定不同比例的图片,主资源默认对应于1.0倍的分辨率图片

```
.../my_icon.png
.../2.0x/my_icon.png
.../3.0x/my_icon.png

```

### 字符串的引用

Flutter 当下并没有一个特定的管理字符串的资源管理系统。目前来讲，最好的办法是将字符串作为静态域存放在类中，并通过类访问它们。例如：

```dart
class Strings {
  static String welcomeMessage = "Welcome To Flutter";
}
```

接着在你们的代码中，你可以这样访问你的字符串：

```java
Text(Strings.welcomeMessage)
```

在不同平台读取 Flutter assets， Android 是通过 `AssetManager`，iOS 是 `NSBundle`。

```java
想要在 Java 插件中访问 icons/heart.png
AssetManager assetManager = registrar.context().getAssets();
String key = registrar.lookupKeyForAsset("icons/heart.png");
AssetFileDescriptor fd = assetManager.openFd(key);

```

## 5.ScrollView

Flutter中实现ScrollView最简单的方式是采用ListView,Flutter 中 ListView widget 既是一个 ScrollView，也是一个 Android 中的 ListView。

## 6.处理屏幕旋转

FlutterView 会处理配置的变化，前提条件是在 AndroidManifest.xml 文件中声明了：

```dart
android:configChanges="orientation|screenSize"
```

## 7.手势触摸监听以及点击事件

一:如果 Widget 支持事件监听，那么向它传入一个方法并在方法中处理事件。例如，RaisedButton 有一个 `onPressed` 参数：

```dart
@override
Widget build(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        print("click");
      },
      child: Text("Button"));
}

```

二:如果 Widget 不支持事件监听，将 Widget 包装进一个 GestureDetector 中并向 `onTap` 参数传入一个方法。

```dart
class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        child: FlutterLogo(
          size: 200.0,
        ),
        onTap: () {
          print("tap");
        },
      ),
    ));
  }
}
```

使用 GestureDetector 可以监听非常多的手势

- Tap

  - `onTapDown` - 一个可能产生点击事件的指针触摸到屏幕的特定位置。

    `onTapDown` - A pointer that might cause a tap has contacted the screen at a particular location.

  - `onTapUp` - 一个产生了点击事件的指针停止触摸屏幕的特定位置。

  - `onTap` - 一个点击事件已经发生。

  - `onTapCancel` - 之前触发了 `onTapDown` 事件的指针不会产生点击事件。

- Double tap

  - `onDoubleTap` - 用户在屏幕同一位置连续快速地点击两次。

- Long press

  - `onLongPress` - 指针在屏幕的同一位置保持了一段较长时间的触摸状态。

- Vertical drag

  - `onVerticalDragStart` - 指针已经触摸屏幕并可能开始垂直移动。
  - `onVerticalDragUpdate` - 触摸屏幕的指针在垂直方向移动了更多的距离。
  - `onVerticalDragEnd` - 之前和屏幕接触并垂直移动的指针不再继续和屏幕接触，并且在和屏幕停止接触的时候以一定的速度移动。

- Horizontal drag

  - `onHorizontalDragStart` - 指针已经触摸屏幕并可能开始水平移动。
  - `onHorizontalDragUpdate` - 触摸屏幕的指针在水平方向移动了更多的距离。
  - `onHorizontalDragEnd` - 之前和屏幕接触并水平移动的指针不再继续和屏幕接触，并且在和屏幕停止接触的时候以一定的速度移动。

## 8.ListView

ListView创建需要一组Widget,需要需要列表点击监听,则使用widget的触摸监听

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: ListView(children: widgets),
    );
  }
```
item触摸监听
```dart
 List<Widget> _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      widgets.add(GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Row $i"),
        ),
        onTap: () {
          print('row tapped');
        },
      ));
    }
    return widgets;
  }
```

ListView更新数据,如果是直接在`setState()`里面更新一组widget,因为Widget树并没有任何更改,

当引擎检查到 `ListView`，他会执行 `==` 检查，并判断两个 `ListView` 是一样的。没有任何更改，所以也就不需要更新。

* 更新 `ListView` 的一个简单方法是，在 `setState()` 里创建一个新的 `List`，并将数据从旧列表拷贝到新列表。虽然这个方法很简单，但是并不推荐在大数据集的时候使用。

  ```dart
   @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: ListView(children: widgets),
      );
    }
  
    Widget getRow(int i) {
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Row $i"),
        ),
        onTap: () {
          setState(() {
            widgets = List.from(widgets);
            widgets.add(getRow(widgets.length));
            print('row $i');
          });
        },
      );
    }
  ```


* 推荐的高效且有效的创建列表的方法是使用 ListView.Builder,等同于Android 里的 RecyclerView，会为你自动回收列表项,不用创建一个 “ListView”，而是创建接收两个参数的 ListView.Builder，两个参数分别是列表的初始长度和一个 ItemBuilder 方法。

  ItemBuilder 方法和 Android adapter 里的 `getView` 方法类似；它通过位置返回你期望在这个位置渲染的列表项。

   ```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: ListView.builder(
            itemCount: widgets.length,
            itemBuilder: (BuildContext context, int position) {
              return getRow(position);
            }));
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row $i"),
      ),
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          print('row $i');
        });
      },
    );
  }
   ```


## 9.数据库以及本地存储

* SharedPreferences键值对存储,[使用shared_preferences插件](https://pub.flutter-io.cn/packages/shared_preferences/install),这个插件同时包装了 Shared Preferences 和 NSUserDefaults（iOS 平台对应 API）的功能。

  ```dart
  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    prefs.setInt('counter', counter);
  }
  ```

* SQLite 数据库存储

  [使用SQFlite插件](https://pub.flutter-io.cn/packages/sqflite)

## 10.布局

* `Row`  [`MainAxisAlignment`](https://api.flutter-io.cn/flutter/rendering/MainAxisAlignment-class.html) 和 [`CrossAxisAlignment`](https://api.flutter-io.cn/flutter/rendering/CrossAxisAlignment-class.html) 控制对齐
* `Column` [`MainAxisAlignment`](https://api.flutter-io.cn/flutter/rendering/MainAxisAlignment-class.html) 和 [`CrossAxisAlignment`](https://api.flutter-io.cn/flutter/rendering/CrossAxisAlignment-class.html) 
* `Expanded`
* [`Container`](https://flutter.cn/docs/development/ui/layout#container)：向 widget 增加 padding、margins、borders、background color 或者其他的“装饰”。
* [`GridView`](https://flutter.cn/docs/development/ui/layout#gridview)：将 widget 展示为一个可滚动的网格。
* [`ListView`](https://flutter.cn/docs/development/ui/layout#listview)：将 widget 展示为一个可滚动的列表。
* [`Stack`](https://flutter.cn/docs/development/ui/layout#stack)：将 widget 覆盖在另一个的上面。
*  `Material widgets`
  - [`Card`](https://flutter.cn/docs/development/ui/layout#card)：将相关信息整理到一个有圆角和阴影的盒子中。
  - [`ListTile`](https://flutter.cn/docs/development/ui/layout#listtile)：将最多三行的文本、可选的导语以及后面的图标组织在一行中。
* 默认情况下，行或列沿其主轴会占用尽可能多的空间，但如果要将子项紧密组合在一起，请将其 `mainAxisSize` 设置为 `MainAxisSize.min`

## 11.动画

### 11.1 Animation介绍

* `Animation` Flutter 动画库中的核心抽象类，插入用于指导动画的值, `Animation` 对象知道动画目前的状态（例如，是否开始，暂停，前进或倒退），但是对屏幕上显示的内容一无所知

* [`AnimationController`](https://api.flutter-io.cn/flutter/animation/AnimationController-class.html) 管理 `Animation`。

  ```dart
  controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);
  ```

* [`CurvedAnimation`](https://api.flutter-io.cn/flutter/animation/CurvedAnimation-class.html) 定义进程为非线性曲线,`CurvedAnimation` 和 `AnimationController`（下面将会详细说明）都是 `Animation<double>` 类型，所以可以互换使用

  vsync 的存在防止后台动画消耗不必要的资源。您可以通过添加 SingleTickerProviderStateMixin 到类定义，将有状态的对象用作 vsync。

* [`Tween`](https://api.flutter-io.cn/flutter/animation/Tween-class.html) 为动画对象插入一个范围值,Tween` 源自 `Animatable<T>`，而不是 `Animation<T>。例如，`Tween` 可以定义插入值由红到蓝，或从 0 到 255。

  ```dart
  colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);
  ```

  要使用 `Tween` 对象，请在 `Tween` 调用 `animate()`，传入控制器对象。例如，下面的代码在 500 ms 的进程中生成 0-255 范围内的整数值。

  ```dart
  AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this);
  Animation<int> alpha = IntTween(begin: 0, end: 255).animate(controller);
  ```

* 使用 Listeners 和 StatusListeners 监视动画状态变化。

### 11.2 AnimatedWidget

* `AnimatedWidget`可以从动画代码中区分出核心widget代码，不需要保持State对象来hold动画,适用于可重复使用的动画定义Widget

  ```dart
  ## 修改前：
  controller =
          AnimationController(vsync: this, duration: const Duration(seconds: 2));
      animation = Tween<double>(begin: 0, end: 300).animate(controller)
        ..addListener(() {
          setState(() {
            print("Animation Value =  $animation.value");
          });
        });
      controller.forward();
  ```

  ```dart
  ## 修改后，移除了addListener和setState代码
  animation = Tween<double>(begin: 0, end: 300).animate(controller);
  controller.forward();
      
  class AnimatedLogo extends AnimatedWidget {
    AnimatedLogo({Key key, Animation<double> animation})
        : super(key: key, listenable: animation);
  
    @override
    Widget build(BuildContext context) {
      final animation = listenable as Animation<double>;
      return Center(
        child: Container(
          child: FlutterLogo(),
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
        ),
      );
    }
  }
  
    @override
    Widget build(BuildContext context) {
      return AnimatedLogo(animation: animation,);
    }
  ```
### 11.3 AnimatedBuilder

* `AnimatedBuilder` 相对于`AnimatedWidget`来说，不会渲染widget，也不会控制动画对象，相当于一个对接者，引入需要渲染的widget以及动画对象，自动监听动画对象，并通知渲染widget。

  ```dart
  ## 动画对象
  controller =
          AnimationController(duration: Duration(seconds: 2), vsync: this);
  animation = Tween<double>(begin: 0, end: 300).animate(controller);
  controller.forward();
  
  ## 渲染的Widget
  class LogoWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      print('GrowTransition创建');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
    }
  }
  
  ## AnimatedBuilder
  class GrowTransition extends StatelessWidget {
    GrowTransition({this.child, this.animation});
    final Widget child;
    final Animation<double> animation;
    @override
    Widget build(BuildContext context) {
      print('GrowTransition创建');
      return Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
          child: child,
        ),
      );
    }
  }
  ```

### 11.4 同步动画

* 在同一个动画控制器中使用多个动画 `CurvedAnimation`

  ```dart
   controller =
          AnimationController(duration: const Duration(seconds: 2), vsync: this);
      animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
  ```

  ```dart
  class AnimatedLogo extends AnimatedWidget {
    // Make the Tweens static because they don't change.
    static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
    static final _sizeTween = Tween<double>(begin: 0, end: 300);
  
    AnimatedLogo({Key key, Animation<double> animation})
        : super(key: key, listenable: animation);
  
    Widget build(BuildContext context) {
      final animation = listenable as Animation<double>;
      return Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: _sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
            child: FlutterLogo(),
          ),
        ),
      );
    }
  }
  ```

  动画重复播放可以使用`..repeat`,使用repeat时不需要使用`controller.forward()`来播放动画,会自动播放

  ```dart
    controller =
          AnimationController(duration: Duration(seconds: 2), vsync: this)
            ..repeat(reverse: true);
  ```

### 11.5 Hero动画(共享元素动画)

​	hero动画实现需要两个Hero Widget : 一个用来在原页面中描述 widget，另一个在目标页面中描述 widget,两个hero widgets要创建相同的标签.Hero 动画代码有如下结构：

1. 定义一个起始 Hero widget，被称为 **source hero**。该 hero 指定图形表示（通常是图像），以及识别标签`tag`，并且在由原页面定义的当前显示的 widget 树中。
2. 定义一个截至 Hero widget，被称为 **destination hero**。该 hero 也指定图形表示，并与 source hero 使用同样的标签`tag`, **这是基本，两个 hero widgets 要创建相同的标签**
3. 创建一个含有 destination hero 的页面。目标页面定义了动画结束时应有的 widget 树。
4. 通过推送目标页面到 Navigator 堆栈来触发动画。 Navigator 推送并弹出操作触发原页面和目标页面中含有配对标签 heroes 的 hero 动画。







## Flutter添加到现有Android项目步骤

* AS 新建Flutter Module ( 需要配合Flutter插件 )

* 在 AndroidManifest.xml 中添加 FlutterActivity

  ```dart
  <activity
    android:name="io.flutter.embedding.android.FlutterActivity"
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize"
    />
  
  ```

* 加载FlutterActivity

  * ```dart
    FlutterActivity.createDefaultIntent(this)
         
    上述的例子假定了你的 Dart 代码入口是调用 main()，并且你的 Flutter 初始路由是 ‘/’
    ```

  * ```
    FlutterActivity
          .withNewEngine()
          .initialRoute("/my_route")
          .build(this)
          
    可以用你想要的初始路由替换掉 "/my_route"。工厂方法 withNewEngine() 可以用于配置一个 FlutterActivity，它会在内部创建一个属于自己的 FlutterEngine 实例，这会有一个明显的初始化时间
    ```

  * 使用缓存的FlutterEngine

    * 在Application初始化FlutterEngine,传给 `FlutterEngineCache` 的 ID 可以是你想要的任何名称。确保 `FlutterActivity` 或 `FlutterFragment` 在使用缓存的 `FlutterEngine` 时，传递了同样的 ID

      ```kotlin
      class MyApplication : Application() {
        lateinit var flutterEngine : FlutterEngine
      
        override fun onCreate() {
          super.onCreate()
      
          // Instantiate a FlutterEngine.
          flutterEngine = FlutterEngine(this)
      
          // Start executing Dart code to pre-warm the FlutterEngine.
          flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
          )
      
          // Cache the FlutterEngine to be used by FlutterActivity.
          FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)
        }
      }
      
      ```

    * 使用预热好的FlutterEngine加载FlutterActivity

      ```kotlin
       FlutterActivity
            .withCachedEngine("my_engine_id")
            .build(this)
      ```

      > 当使用一个缓存的 `FlutterEngine` 时， `FlutterEngine` 会比展示它的 `FlutterActivity` 或 `FlutterFragment` 存活得更久。切记，Dart 代码会在你预热 `FlutterEngine` 时就开始执行，并且在你的 `FlutterActivity` 或 `FlutterFragment` 销毁后继续运行。要停止代码运行和清理相关资源，可以从 `FlutterEngineCache` 中获取你的 `FlutterEngine`，然后使用 `FlutterEngine.destroy()` 来销毁 `FlutterEngine`。

      ```kotlin
      val flutterEngineCache = FlutterEngineCache.getInstance()
      flutterEngineCache.get(Constants.FLUTTER_ENGINE_ID)?.destroy()
      ```

      

  
