import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/utils/responsive.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/23
/// create_time: 15:14
/// describe: toast工具,整体优化，改动较大 0.1.2 之后版本
///

typedef BuildToastStyle = Widget Function(BuildContext context, String msg);

///toast的显示位置
enum ToastPosition {
  center,
  bottom,
  top,
}

typedef BuildToastPoint = Positioned Function(
    BuildContext context, BuildToastStyle style);

class Toast {
  Toast._();

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

  /// 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  DateTime? _startedTime;

  factory Toast() => _instance;
  static final Toast _instance = Toast._internal();

  // static Toast get instance => _instance;

  static final List<OverlayEntryManger> _overlayEntryMangers = [];

  /// 队列方式显示 toast
  static final Queue<ToastTaskQueue> _queueTask = Queue<ToastTaskQueue>();
  static OverlayEntry? _queueTaskOverlay;
  static final _valueListenable = ValueNotifier(_queueTask.length);

  ///toast全局样式基础配置，使用内部的方式，外部传参控制
  ///当需要多种样式请使用 globalBuildToastStyle 或者 show时 传入样式
  static EdgeInsetsGeometry? _globalToastMargin =
      const EdgeInsets.only(left: 10, right: 10);
  static EdgeInsetsGeometry? _globalToastPadding =
      const EdgeInsets.fromLTRB(10, 15, 10, 15);
  static AlignmentGeometry? _globalToastAlignment = Alignment.center;
  static TextStyle? _globalToastTextStyle = const TextStyle(
      decoration: TextDecoration.none, color: Colors.white, fontSize: 16);
  static BoxDecoration? _globalToastDecoration = const BoxDecoration(
    color: Colors.black38,
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

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

  Toast._internal() {
    globalBuildToastStyle ??= (context, msg) {
      return Responsive(
        mobile: Container(
            width: MediaQuery.of(context).size.width,
            margin: _globalToastMargin,
            padding: _globalToastPadding,
            alignment: _globalToastAlignment,
            decoration: _globalToastDecoration,
            child: Text(msg, style: _globalToastTextStyle)),
        tablet: Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: _globalToastMargin,
            padding: _globalToastPadding,
            alignment: _globalToastAlignment,
            decoration: _globalToastDecoration,
            child: Text(msg, style: _globalToastTextStyle)),
        desktop: Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: _globalToastMargin,
            padding: _globalToastPadding,
            alignment: _globalToastAlignment,
            decoration: _globalToastDecoration,
            child: Text(msg, style: _globalToastTextStyle)),
      );
    };
  }

  ///显示一个吐司
  static Future<OverlayEntryManger?> show(
    String msg, {
    BuildContext? context,
    BuildToastStyle? buildToastStyle,
    ToastPosition? position,
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
        builder: (BuildContext context) => Positioned(
              top: _calToastPosition(
                  context, position ?? _instance.globalPosition),
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: buildToastStyle?.call(context, msg))),
            ));

    ///获取OverlayState
    if (context == null) {
      ///创建和显示顶层OverlayEntry
      navigatorState.currentState?.overlay?.insert(_overlayEntry);
    } else {
      var overlayState = Overlay.of(context);
      overlayState?.insert(_overlayEntry);
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
      overlayState?.insert(_overlayEntry);
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
  ///默认自下向上退出
  static void showQueueToast(
    String msg, {
    BuildContext? context,
    BuildToastStyle? buildToastStyle,
    Duration showTime = const Duration(milliseconds: 2000),
    Duration animationTime = const Duration(milliseconds: 600),
    Offset startOffset = const Offset(0, 0),
    Offset endOffset = const Offset(0, -100),
    ScalingFactor mobile = const ScalingFactor(0.7, 0.7),
    ScalingFactor tablet = const ScalingFactor(0.5, 0.8),
    ScalingFactor desktop = const ScalingFactor(0.3, 0.8),
    SizedBox divider = const SizedBox(height: 10),
  }) {

    buildToastStyle = buildToastStyle ?? _instance.globalBuildToastStyle;

    ToastTaskQueue(
        msg: msg,
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
                      style:buildToastStyle!,
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
      overlayState?.insert(_queueTaskOverlay!);
    }
  }

  ///设置toast位置
  static double _calToastPosition(context, ToastPosition position) {
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

class ToastTaskQueue {
  String msg;
  Queue queue;
  Duration showTime;
  Duration animationTime;
  Offset startOffset;
  Offset endOffset;

  ValueNotifier<num> valueListenable;

  ToastTaskQueue({
    required this.msg,
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
  final BuildToastStyle style;
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: _positionAnimation.value,
            child: widget.style.call(context, widget.task.msg),
          ),
        );
      },
    );
  }
}
