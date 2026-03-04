import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:uikit_plus/utils/responsive.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/23
/// create_time: 15:14
/// describe: Toast提示组件 - 支持多种显示模式、动画配置、队列管理
/// Enterprise-level Toast component - Supports multiple display modes, animation configuration, queue management
///
/// ✨ 功能特性 / Features:
/// • 🎨 灵活的样式配置 - 支持自定义颜色、圆角、阴影等
/// • 🎬 丰富的动画效果 - 淡入淡出、缩放动画可配置
/// • 📍 多种显示位置 - 顶部、中间、底部、自定义位置
/// • ⏱️ 队列管理 - 支持多个Toast排队显示
/// • 🔄 Loading状态 - 内置加载动画支持
/// • 🎯 状态提示 - 成功/失败状态样式
/// • 📱 响应式设计 - 自适应不同屏幕尺寸
/// • 🌐 全局配置 - 统一管理Toast样式
///
/// 📖 使用示例 / Usage Examples:
///
/// ```dart
/// // 示例1: 基础用法 - 显示简单提示
/// // Example 1: Basic usage - Show simple message
/// Toast.show('操作成功');
///
/// // 示例2: 自定义样式配置
/// // Example 2: Custom style configuration
/// Toast().initStyleConfig(
///   styleConfig: ToastStyleConfig(
///     margin: EdgeInsets.all(20),
///     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
///     decoration: BoxDecoration(
///       color: Colors.black87,
///       borderRadius: BorderRadius.circular(10),
///       boxShadow: [
///         BoxShadow(
///           color: Colors.black26,
///           blurRadius: 10,
///           offset: Offset(0, 4),
///         ),
///       ],
///     ),
///   ),
///   animationConfig: ToastAnimationConfig(
///     enableAnimation: true,
///     animationDuration: 300,
///     enableScaleAnimation: true,
///   ),
/// );
///
/// // 示例3: 显示Loading加载动画
/// // Example 3: Show loading animation
/// Toast.showLoading(
///   child: CircularProgressIndicator(
///     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
///   ),
///   backgroundColor: Color(0x77000000),
///   barrierDismissible: false,
/// );
/// // 关闭Loading
/// Toast.closeLoading();
///
/// // 示例4: 显示状态提示(成功/失败)
/// // Example 4: Show status message (success/failure)
/// Toast.showStatus(
///   '保存成功',
///   status: true,
///   iconColorSuccess: Colors.green,
///   iconColorError: Colors.red,
/// );
///
/// // 示例5: 队列方式显示多个Toast
/// // Example 5: Show multiple toasts in queue
/// Toast.showQueueToast('消息1');
/// Toast.showQueueToast('消息2');
/// Toast.showQueueToast('消息3');
///
/// // 示例6: 自定义位置显示
/// // Example 6: Show at custom position
/// Toast.show(
///   '顶部提示',
///   position: ToastPosition.top,
///   showTime: 3000,
/// );
/// ```
///
/// ⚠️ 注意事项 / Notes:
/// • 需要在MaterialApp中配置navigatorKey: Toast.navigatorState
/// • 建议在应用启动时初始化全局样式配置
/// • Loading状态会阻止用户交互,使用时注意及时关闭
/// • 队列Toast会自动管理显示顺序,无需手动控制
/// • 自定义样式时注意保持视觉一致性
///

typedef BuildToastStyle = Widget Function(BuildContext context, String msg);
typedef BuildToastQueueStyle = Widget Function(BuildContext context, ToastTaskQueue queue);
typedef BuildOverlayStyle = OverlayEntry Function();

/// Toast 动画配置类
/// Toast animation configuration class
class ToastAnimationConfig {
  /// 是否启用动画 / Enable animation
  /// 默认值: true
  final bool enableAnimation;
  
  /// 动画持续时间（毫秒）/ Animation duration (milliseconds)
  /// 默认值: 300ms
  /// 范围: 100-1000ms
  final int animationDuration;
  
  /// 淡入动画曲线 / Fade in animation curve
  /// 默认值: Curves.easeOut
  final Curve fadeInCurve;
  
  /// 淡出动画曲线 / Fade out animation curve
  /// 默认值: Curves.easeIn
  final Curve fadeOutCurve;
  
  /// 缩放动画起始值 / Scale animation start value
  /// 默认值: 0.8
  /// 范围: 0.0-1.0
  final double scaleStart;
  
  /// 缩放动画结束值 / Scale animation end value
  /// 默认值: 1.0
  final double scaleEnd;
  
  /// 是否启用缩放动画 / Enable scale animation
  /// 默认值: true
  final bool enableScaleAnimation;
  
  const ToastAnimationConfig({
    this.enableAnimation = true,
    this.animationDuration = 300,
    this.fadeInCurve = Curves.easeOut,
    this.fadeOutCurve = Curves.easeIn,
    this.scaleStart = 0.8,
    this.scaleEnd = 1.0,
    this.enableScaleAnimation = true,
  });
}

/// Toast 样式配置类
/// Toast style configuration class
class ToastStyleConfig {
  /// 外边距 / Outer margin
  /// 默认值: EdgeInsets.only(left: 10, right: 10)
  final EdgeInsetsGeometry margin;
  
  /// 内边距 / Inner padding
  /// 默认值: EdgeInsets.fromLTRB(10, 15, 10, 15)
  final EdgeInsetsGeometry padding;
  
  /// 对齐方式 / Alignment
  /// 默认值: Alignment.topCenter
  final AlignmentGeometry alignment;
  
  /// 文本样式 / Text style
  /// 默认值: TextStyle(color: Colors.white, fontSize: 16)
  final TextStyle textStyle;
  
  /// 装饰样式 / Decoration style
  /// 默认值: BoxDecoration(color: Colors.black38, borderRadius: 30)
  final BoxDecoration decoration;
  
  /// 最大宽度 / Maximum width
  /// null 表示不限制 / null means no limit
  final double? maxWidth;
  
  /// 最小宽度 / Minimum width
  /// 默认值: 0
  final double? minWidth;
  
  /// 阴影效果 / Box shadow
  /// 可选配置 / Optional configuration
  final List<BoxShadow>? boxShadow;
  
  const ToastStyleConfig({
    this.margin = const EdgeInsets.only(left: 10, right: 10),
    this.padding = const EdgeInsets.fromLTRB(10, 15, 10, 15),
    this.alignment = Alignment.topCenter,
    this.textStyle = const TextStyle(
      decoration: TextDecoration.none,
      color: Colors.white,
      fontSize: 16,
    ),
    this.decoration = const BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    this.maxWidth,
    this.minWidth,
    this.boxShadow,
  });
}

/// Toast的显示位置枚举
/// Toast display position enum
enum ToastPosition {
  /// 居中显示 / Center position
  center,
  /// 底部显示 / Bottom position
  bottom,
  /// 顶部显示 / Top position
  top,
}

typedef BuildToastPoint = Positioned Function(
    BuildContext context, BuildToastStyle style);

class Toast {

  ///如果不关心，context调用，需在入口函数的 MaterialApp( navigatorKey: Toast.navigatorState ) 添加绑定
  ///如果路由2.0 则使用 RouterDelegate 下面的 navigatorKey
  static final navigatorState = GlobalKey<NavigatorState>();

  /// toast显示时间 单位 毫秒
  int showTime = 2000;

  /// 两次toast的间隔时间
  int intervalTime = 2000;

  ///显示位置
  ToastPosition globalPosition = ToastPosition.center;

  ///构建toast样式，外部自定义方式
  BuildToastStyle? globalBuildToastStyle;

  BuildToastQueueStyle? globalBuildToastQueueStyle;

  /// Toast 全局样式配置
  ToastStyleConfig globalToastStyleConfig = const ToastStyleConfig();

  /// Toast 全局动画配置
  ToastAnimationConfig globalAnimationConfig = const ToastAnimationConfig();

  /// 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  DateTime? _startedTime;

  factory Toast() => _instance;
  static final Toast _instance = Toast._internal();

  static final List<OverlayEntryManger> _overlayEntryMangers = [];

  /// Loading 相关的 OverlayEntry 管理器
  static OverlayEntryManger? _loadingOverlayManger;

  /// 队列方式显示 toast
  static final Queue<ToastTaskQueue> _queueTask = Queue<ToastTaskQueue>();
  static OverlayEntry? _queueTaskOverlay;
  static final _valueListenable = ValueNotifier(_queueTask.length);

  ///toast全局样式基础配置，使用内部的方式，外部传参控制
  ///当需要多种样式请使用 globalBuildToastStyle 或者 show时 传入样式
  ///已废弃，请使用 globalToastStyleConfig
  @Deprecated('请使用 globalToastStyleConfig')
  static EdgeInsetsGeometry? _globalToastMargin =
      const EdgeInsets.only(left: 10, right: 10);
  @Deprecated('请使用 globalToastStyleConfig')
  static EdgeInsetsGeometry? _globalToastPadding =
      const EdgeInsets.fromLTRB(10, 15, 10, 15);
  @Deprecated('请使用 globalToastStyleConfig')
  static AlignmentGeometry? _globalToastAlignment = Alignment.topCenter;
  @Deprecated('请使用 globalToastStyleConfig')
  static TextStyle? _globalToastTextStyle = const TextStyle(
      decoration: TextDecoration.none, color: Colors.white, fontSize: 16);
  @Deprecated('请使用 globalToastStyleConfig')
  static BoxDecoration? _globalToastDecoration = const BoxDecoration(
    color: Colors.black38,
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  /// 初始化基础样式（已废弃，请使用 initStyleConfig）
  @Deprecated('请使用 initStyleConfig')
  void initBaseStyle(
      {EdgeInsetsGeometry? globalToastMargin,
      EdgeInsetsGeometry? globalToastPadding,
      AlignmentGeometry? globalToastAlignment,
      TextStyle? globalToastTextStyle,
      BoxDecoration? globalToastDecoration}) {
    _globalToastMargin = globalToastMargin ?? _globalToastMargin;
    _globalToastPadding = globalToastPadding ?? _globalToastPadding;
    _globalToastAlignment = globalToastAlignment ?? _globalToastAlignment;
    _globalToastTextStyle = globalToastTextStyle ?? _globalToastTextStyle;
    _globalToastDecoration = globalToastDecoration ?? _globalToastDecoration;
  }

  /// 初始化样式配置
  void initStyleConfig({
    ToastStyleConfig? styleConfig,
    ToastAnimationConfig? animationConfig,
  }) {
    if (styleConfig != null) {
      globalToastStyleConfig = styleConfig;
    }
    if (animationConfig != null) {
      globalAnimationConfig = animationConfig;
    }
  }

  Toast._internal() {
    globalBuildToastStyle ??= (context, msg) => _baseStyle(context, msg);
    globalBuildToastQueueStyle ??= (context, task) => _baseStyle(context, task.msg);
  }

  Widget _baseStyle(context, msg) {
    final config = globalToastStyleConfig;
    final screenWidth = MediaQuery.of(context).size.width;
    
    Widget buildContainer(double width) {
      return Container(
        constraints: BoxConstraints(
          maxWidth: config.maxWidth ?? width,
          minWidth: config.minWidth ?? 0,
        ),
        margin: config.margin,
        padding: config.padding,
        alignment: config.alignment,
        decoration: config.decoration.copyWith(
          boxShadow: config.boxShadow ?? config.decoration.boxShadow,
        ),
        child: Text(msg, style: config.textStyle),
      );
    }
    
    return Responsive(
      mobile: buildContainer(screenWidth),
      tablet: buildContainer(screenWidth / 2),
      desktop: buildContainer(screenWidth / 3),
    );
  }


  ///显示一个吐司
  static Future<OverlayEntryManger?> show(
    String msg, {
    BuildContext? context,
    BuildToastStyle? buildToastStyle,
    ToastPosition? position,
    int? showTime,
    BuildOverlayStyle? buildOverlayStyle,
    Color backgroundColor = Colors.transparent,
    ToastAnimationConfig? animationConfig,
    ToastStyleConfig? styleConfig,
  }) async {
    ///防止多次弹出，外部设置间隔时间 默认2秒
    if (_instance._startedTime != null &&
        DateTime.now().difference(_instance._startedTime!).inMilliseconds <
            _instance.intervalTime) {
      return null;
    }

    buildToastStyle = buildToastStyle ?? _instance.globalBuildToastStyle;
    final animConfig = animationConfig ?? _instance.globalAnimationConfig;
    final styleCfg = styleConfig ?? _instance.globalToastStyleConfig;
    
    _instance._startedTime = DateTime.now();
    
    final _overlayEntry = buildOverlayStyle?.call() ?? OverlayEntry(
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                _ToastWidget(
                  msg: msg,
                  buildToastStyle: buildToastStyle!,
                  position: position ?? _instance.globalPosition,
                  backgroundColor: backgroundColor,
                  animationConfig: animConfig,
                  styleConfig: styleCfg,
                ),
              ],
            ),
          );
        });

    ///获取OverlayState
    if (context == null) {
      ///创建和显示顶层OverlayEntry
      navigatorState.currentState?.overlay?.insert(_overlayEntry);
    } else {
      var overlayState = Overlay.of(context);
      overlayState.insert(_overlayEntry);
    }
    var manger = OverlayEntryManger(_overlayEntry);
    _overlayEntryMangers.add(manger);
    manger
        .start(showTime ?? _instance.showTime, _instance._startedTime!)
        .then((value) {
      _overlayEntryMangers.remove(value);
    });
    return manger;
  }

  ///显示加载动画
  ///[child] 自定义加载组件，如果为 null 则使用默认的 CircularProgressIndicator
  ///[backgroundColor] 背景颜色，默认半透明黑色
  ///[barrierDismissible] 点击背景是否可以取消显示，默认 false
  ///[context] 上下文，如果为 null 则使用 navigatorState
  ///[enableAnimation] 是否启用淡入淡出动画，默认 true
  ///[animationDuration] 动画持续时间（毫秒），默认 300
  static void showLoading({
    Widget? child,
    Color? backgroundColor,
    bool barrierDismissible = false,
    BuildContext? context,
    bool enableAnimation = true,
    int animationDuration = 300,
  }) {
    // 如果已经显示，先关闭
    closeLoading();

    final loadingWidget = child ?? const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );

    final bgColor = backgroundColor ?? const Color(0x77000000);

    final overlayEntry = OverlayEntry(
      builder: (BuildContext ctx) {
        return _LoadingWidget(
          loadingWidget: loadingWidget,
          backgroundColor: bgColor,
          barrierDismissible: barrierDismissible,
          enableAnimation: enableAnimation,
          animationDuration: animationDuration,
        );
      },
    );

    // 插入到 Overlay，确保在 Toast 之上
    if (context == null) {
      navigatorState.currentState?.overlay?.insert(overlayEntry);
    } else {
      Overlay.of(context).insert(overlayEntry);
    }

    _loadingOverlayManger = OverlayEntryManger(overlayEntry);
  }

  ///关闭加载动画
  static void closeLoading() {
    _loadingOverlayManger?.cancel();
    _loadingOverlayManger = null;
  }


  ///模板代码,外部可参考定制自己的各种状态样式
  static void showStatus(
      String msg, {
        bool status = true,
        BuildContext? context,
        double? width,
        double? height,
        double radius = 10,
        Color? bgColor = Colors.white,
        Color? toastBgColor = const Color(0x77000000),
        Color? iconColorSuccess = const Color(0xFF3EC3CF),
        Color? iconColorError = Colors.redAccent,
        double? iconSize = 26,
        TextStyle? textStyle = const TextStyle(color: Colors.black),
        int? showTime,
        EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        EdgeInsetsGeometry margin = const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      }) {
    Toast.show(msg,
        context: context,
        buildOverlayStyle: (){
      return OverlayEntry(
          builder: (BuildContext context){
            Size size = MediaQuery.of(context).size;
            return SizedBox(
              width:size.width,
              height: size.height,
              child: Material(
                color: toastBgColor,
                child: Center(
                  child: Container(
                    width: width,
                    height: height,
                    padding: padding,
                    margin: margin,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(radius))),
                    child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(status?Icons.check_circle_outline:Icons.error_outline, size: iconSize, color: status?iconColorSuccess:iconColorError),
                        const SizedBox(width: 5,),
                        Flexible(child: Text(msg, style: textStyle))
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }

  ///显示自定义坐标的吐司
  static Future<OverlayEntryManger?> showCustomPoint({
    BuildContext? context,
    BuildToastStyle? buildToastStyle,
    required BuildToastPoint buildToastPoint,
    int? showTime,
  }) async {
    ///防止多次弹出，外部设置间隔时间 默认2秒
    if (_instance._startedTime != null &&
        DateTime.now().difference(_instance._startedTime!).inMilliseconds <
            _instance.intervalTime) {
      return null;
    }

    buildToastStyle = buildToastStyle ?? _instance.globalBuildToastStyle;
    _instance._startedTime = DateTime.now();
    var _overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            buildToastPoint.call(context, buildToastStyle!));

    ///获取OverlayState
    if (context == null) {
      ///创建和显示顶层OverlayEntry
      navigatorState.currentState?.overlay?.insert(_overlayEntry);
    } else {
      var overlayState = Overlay.of(context);
      overlayState.insert(_overlayEntry);
    }
    var manger = OverlayEntryManger(_overlayEntry);
    _overlayEntryMangers.add(manger);
    manger
        .start(showTime ?? _instance.showTime, _instance._startedTime!)
        .then((value) {
      _overlayEntryMangers.remove(value);
    });
    return manger;
  }

  ///支持队列的方式显示多个 toast
  ///默认自下向上退出 显示的宽高受最大 ScalingFactor 缩放因子决定
  static void showQueueToast(
    String msg, {
    bool status = true,
    BuildContext? context,
    BuildToastQueueStyle? buildStyle,
    Duration showTime = const Duration(milliseconds: 2000),
    Duration animationTime = const Duration(milliseconds: 600),
    Offset startOffset = const Offset(0, 0),
    Offset endOffset = const Offset(0, -100),
    ScalingFactor mobile = const ScalingFactor(0.7, 0.7),
    ScalingFactor tablet = const ScalingFactor(0.5, 0.7),
    ScalingFactor desktop = const ScalingFactor(0.3, 0.7),
    SizedBox divider = const SizedBox(height: 10),
  }) {

    final toastStyle = buildStyle ?? _instance.globalBuildToastQueueStyle;
    ToastTaskQueue(
        msg: msg,
        status: status,
        queue: _queueTask,
        showTime: showTime,
        animationTime: animationTime,
        startOffset: startOffset,
        endOffset: endOffset,
        valueListenable: _valueListenable,
        );
    if (_queueTaskOverlay == null) {
      _queueTaskOverlay = OverlayEntry(builder: (BuildContext context) {
        return ValueListenableBuilder<num>(
            valueListenable: _valueListenable,
            builder: (context, value, child) {
              final tasks = ListView.separated(
                  itemCount: _queueTask.length,
                  physics: const PageScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index)=>divider,
                  itemBuilder: (context, index) {
                    final task = _queueTask.elementAt(index);
                    return ToastTaskView(
                      key: ValueKey(task),
                      task:task,
                      style:toastStyle!,
                      callBack:() {
                        _queueTaskOverlay?.remove();
                        _queueTaskOverlay = null;
                      },
                    );
                  });
              final size = MediaQuery.of(context).size;
              return Center(
                child: Responsive(
                    mobile: SizedBox(
                      width: size.width * mobile.horizontal,
                      height: size.height*mobile.vertical,
                      child: tasks,
                    ),
                    tablet: SizedBox(
                      width: size.width * tablet.horizontal,
                      height: size.height*tablet.vertical,
                      child: tasks,
                    ),
                    desktop: SizedBox(
                      width: size.width * desktop.horizontal,
                      height: size.height*desktop.vertical,
                      child: tasks,
                    )),
              );
            });
      });
      if (context == null) {
        navigatorState.currentState?.overlay?.insert(_queueTaskOverlay!);
        return;
      }
      var overlayState = Overlay.of(context);
      overlayState.insert(_queueTaskOverlay!);
    }
  }

  ///取消toast 显示
  static void cancelAll() async {
    for (var element in _overlayEntryMangers) {
      element.cancel();
    }
  }

  static void cancel(OverlayEntryManger? manger) async {
    manger?.cancel();
  }
}

/// Loading 动画 Widget
class _LoadingWidget extends StatefulWidget {
  final Widget loadingWidget;
  final Color backgroundColor;
  final bool barrierDismissible;
  final bool enableAnimation;
  final int animationDuration;

  const _LoadingWidget({
    required this.loadingWidget,
    required this.backgroundColor,
    required this.barrierDismissible,
    required this.enableAnimation,
    required this.animationDuration,
  });

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.enableAnimation) {
      _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration),
        vsync: this,
      );
      _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.enableAnimation) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // 背景层，可以点击取消
          if (widget.barrierDismissible)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Toast.closeLoading(),
                child: Container(color: widget.backgroundColor),
              ),
            )
          else
            Positioned.fill(
              child: Container(color: widget.backgroundColor),
            ),
          // 加载组件居中显示
          Center(
            child: widget.loadingWidget,
          ),
        ],
      ),
    );

    if (widget.enableAnimation) {
      content = AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: child!,
          );
        },
        child: content,
      );
    }

    return content;
  }
}

/// Toast 动画 Widget
class _ToastWidget extends StatefulWidget {
  final String msg;
  final BuildToastStyle buildToastStyle;
  final ToastPosition position;
  final Color backgroundColor;
  final ToastAnimationConfig animationConfig;
  final ToastStyleConfig styleConfig;

  const _ToastWidget({
    required this.msg,
    required this.buildToastStyle,
    required this.position,
    required this.backgroundColor,
    required this.animationConfig,
    required this.styleConfig,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    if (widget.animationConfig.enableAnimation) {
      _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationConfig.animationDuration),
        vsync: this,
      );

      _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.animationConfig.fadeInCurve,
        ),
      );

      if (widget.animationConfig.enableScaleAnimation) {
        _scaleAnimation = Tween<double>(
          begin: widget.animationConfig.scaleStart,
          end: widget.animationConfig.scaleEnd,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.animationConfig.fadeInCurve,
          ),
        );
      } else {
        _scaleAnimation = const AlwaysStoppedAnimation(1.0);
      }

      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.animationConfig.enableAnimation) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final top = _calToastPosition(context, widget.position);

    Widget content = Material(
      color: widget.backgroundColor,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          child: widget.buildToastStyle.call(context, widget.msg),
        ),
      ),
    );

    // 应用动画
    if (widget.animationConfig.enableAnimation) {
      content = AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child!,
            ),
          );
        },
        child: content,
      );
    }

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: content,
    );
  }

  double _calToastPosition(BuildContext context, ToastPosition position) {
    double backResult;
    if (position == ToastPosition.top) {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (position == ToastPosition.center) {
      backResult = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }
}

class OverlayEntryManger {
  OverlayEntry? overlayEntry;

  OverlayEntryManger(this.overlayEntry);

  Future<OverlayEntryManger> start(int showTime, DateTime startedTime) async {
    await Future.delayed(Duration(milliseconds: showTime));

    ///移除浮层
    cancel();
    return Future.value(this);
  }

  void cancel() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}

///在屏幕上的缩放比例
class ScalingFactor{
  final double horizontal;
  final double vertical;
  const ScalingFactor(this.horizontal,this.vertical);
}

class ToastTaskQueue  with ChangeNotifier{
  String msg;
  bool status;
  Queue queue;
  Duration showTime;
  Duration animationTime;
  Offset startOffset;
  Offset endOffset;

  ValueNotifier<num> valueListenable;

  ToastTaskQueue({
    required this.msg,
    required this.status,
    required this.queue,
    required this.showTime,
    required this.animationTime,
    required this.startOffset,
    required this.endOffset,
    required this.valueListenable,
  }) {
    queue.add(this);
    valueListenable.notifyListeners();
  }
}

class ToastTaskView extends StatefulWidget {

  final ToastTaskQueue task;
  final BuildToastQueueStyle style;
  final Function? callBack;

  const ToastTaskView({required this.task, required this.style, this.callBack, Key? key}) : super(key: key);

  @override
  State<ToastTaskView> createState() => _ToastTaskViewState();

}

class _ToastTaskViewState extends State<ToastTaskView> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.task.animationTime,
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _positionAnimation =
        Tween<Offset>(begin:widget.task.startOffset, end: widget.task.endOffset)
            .animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(widget.task.showTime, () {
        if (mounted) {
          _animationController.forward();
        }
      });
    });
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        final taskQueue = widget.task.queue;
        taskQueue.remove(widget.task);
        if (taskQueue.isEmpty) {
          widget.callBack?.call();
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.translate(
                  offset: _positionAnimation.value,
                  child: widget.style.call(context, widget.task),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
