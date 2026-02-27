import 'dart:async';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/13
/// create_time: 9:43
/// describe: 倒计时组件 / Countdown Timer Component
///
/// 用于实现倒计时功能的通用组件
/// Universal component for countdown timer functionality
///
/// ## 功能特性 / Features
/// - ⏱️ 支持自定义倒计时时长 / Custom countdown duration
/// - 🎯 支持自定义时间单位 / Custom time unit
/// - 🔄 支持启动/取消控制 / Start/cancel control
/// - 📢 支持完成回调 / Completion callback
/// - 🎨 完全自定义UI / Fully customizable UI
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单倒计时
/// TimeView(
///   countdown: 60,
///   build: (context, time) {
///     return Text('剩余 $time 秒');
///   },
/// )
///
/// // 带控制器的倒计时
/// final controller = TimeViewController();
/// TimeView(
///   countdown: 120,
///   controller: controller,
///   build: (context, time) {
///     return Text('$time');
///   },
///   buildCompleter: (context) {
///     print('倒计时完成');
///   },
/// )
///
/// // 启动倒计时
/// controller.startTimer();
///
/// // 取消倒计时
/// controller.cancelTimer();
///
/// // 自定义时间单位(毫秒)
/// TimeView(
///   countdown: 1000,
///   duration: Duration(milliseconds: 100),
///   build: (context, time) {
///     return Text('${time * 100}ms');
///   },
/// )
///
/// // 验证码倒计时示例
/// TimeView(
///   countdown: 60,
///   build: (context, time) {
///     return ElevatedButton(
///       onPressed: time == 60 ? () {
///         // 发送验证码
///       } : null,
///       child: Text(time == 60 ? '发送验证码' : '${time}秒后重试'),
///     );
///   },
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - countdown 必须大于 0 / Must be greater than 0
/// - 使用 controller 可以手动控制倒计时 / Use controller for manual control
/// - enableCancel 为 true 时可以重复启动 / Can restart when true
/// - 组件销毁时会自动取消计时器 / Timer auto-cancels on dispose
///

typedef _BuildChild = Widget Function(BuildContext context, int time);
typedef BuildCompleter = void Function(BuildContext context);

class TimeView extends StatefulWidget {
  /// 倒计时秒数 / Countdown seconds
  /// 
  /// 倒计时的总时长
  /// Total duration of countdown
  /// 
  /// 必填参数 / Required
  /// 取值范围: > 0 / Range: > 0
  final int countdown;

  /// UI构建回调 / UI builder callback
  /// 
  /// 返回要显示的子组件,参数 time 为当前剩余时间
  /// Returns widget to display, parameter time is remaining time
  /// 
  /// 必填参数 / Required
  final _BuildChild? build;

  /// 时间单位 / Time unit
  /// 
  /// 每次递减的时间间隔
  /// Time interval for each decrement
  /// 
  /// 默认值: Duration(seconds: 1) / Default: Duration(seconds: 1)
  final Duration duration;

  /// 是否允许取消后重启 / Allow restart after cancel
  /// 
  /// true: 可以重复启动倒计时 / Can restart countdown
  /// false: 启动后不能重复启动 / Cannot restart after started
  /// 
  /// 默认值: false / Default: false
  final bool enableCancel;

  /// 完成回调 / Completion callback
  /// 
  /// 倒计时结束时触发
  /// Triggered when countdown completes
  final BuildCompleter? buildCompleter;

  /// 控制器 / Controller
  /// 
  /// 用于手动控制倒计时的启动和取消
  /// For manual control of start and cancel
  final TimeViewController? controller;

  const TimeView({
    required this.countdown,
    required this.build,
    this.controller,
    this.enableCancel = false,
    this.duration = const Duration(seconds: 1),
    this.buildCompleter,
    Key? key,
  }) : assert(countdown > 0, 'countdown must be greater than 0'),
       super(key: key);

  @override
  State<TimeView> createState() => TimeViewState();
}

class TimeViewState extends State<TimeView> {
  /// 倒计时的计时器。
  Timer? _timer;

  /// 当前倒计时的时间
  int _currentTime = 0;

  @override
  void initState() {
    super.initState();
    widget.controller?.bind(this);
    _currentTime = widget.countdown;
    if (widget.buildCompleter != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.buildCompleter?.call(context);
      });
    }
  }

  bool isStart() {
    return _timer != null && _currentTime != 0;
  }

  /// 启动倒计时的计时器。
  void startTimer() {
    if (widget.enableCancel) {
      if (_timer != null) {
        cancelTimer();
      }
    }
    if (_timer != null) {
      return;
    }
    _currentTime = widget.countdown - 1;
    notyChange();

    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentTime == 1) {
        cancelTimer();
      }
      _currentTime = widget.countdown - timer.tick - 1;
      notyChange();
    });
  }

  /// 取消倒计时的计时器。
  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
    _currentTime = widget.countdown;
    notyChange();
  }

  void notyChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(TimeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?.bind(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.build!.call(context, _currentTime);
  }
}

class TimeViewController {
  TimeViewState? _state;

  TimeViewState? get state => _state;

  void bind(TimeViewState state) {
    _state = state;
  }

  void dispose() {
    _state = null;
  }

  RenderBox? getRenderBox() {
    final obj = _state?.context.findRenderObject();
    if (obj != null) {
      return obj as RenderBox;
    }
    return null;
  }

  void startTimer() {
    _state?.startTimer();
  }

  void cancelTimer() {
    _state?.cancelTimer();
  }

  bool isStart() {
    return _state?.isStart() ?? false;
  }
}
