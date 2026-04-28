import 'dart:async';
import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2021/12/13
/// time: 9:43
/// describe: 倒计时组件 / Countdown Timer Component
///
/// 用于实现倒计时功能的通用组件
/// Universal component for countdown timer functionality
///
/// ## 功能特性 / Features
/// - ⏱️ 支持自定义倒计时时长 / Custom countdown duration
/// - 🎯 支持自定义时间单位 / Custom time unit
/// - 🔄 支持启动/取消/暂停/恢复控制 / Start/cancel/pause/resume control
/// - 📢 支持完成回调和进度回调 / Completion and progress callbacks
/// - 🎨 完全自定义UI / Fully customizable UI
/// - 📊 支持进度追踪 / Progress tracking support
/// - 🔁 支持自动重启 / Auto-restart support
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
///
/// // 带暂停/恢复的倒计时
/// final controller = TimeViewController();
/// TimeView(
///   countdown: 300,
///   controller: controller,
///   build: (context, time) {
///     return Column(
///       children: [
///         Text('剩余: ${time}秒'),
///         Row(
///           children: [
///             ElevatedButton(
///               onPressed: () => controller.pauseTimer(),
///               child: Text('暂停'),
///             ),
///             ElevatedButton(
///               onPressed: () => controller.resumeTimer(),
///               child: Text('恢复'),
///             ),
///           ],
///         ),
///       ],
///     );
///   },
/// )
///
/// // 带进度回调的倒计时
/// TimeView(
///   countdown: 100,
///   onProgress: (current, total, progress) {
///     print('进度: ${(progress * 100).toStringAsFixed(1)}%');
///   },
///   build: (context, time) {
///     return LinearProgressIndicator(
///       value: (100 - time) / 100,
///     );
///   },
/// )
///
/// // 自动重启的倒计时
/// TimeView(
///   countdown: 10,
///   autoRestart: true,
///   onComplete: (context) {
///     print('倒计时完成,即将重启');
///   },
///   build: (context, time) {
///     return Text('循环倒计时: $time');
///   },
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - countdown 必须大于 0 / Must be greater than 0
/// - 使用 controller 可以手动控制倒计时 / Use controller for manual control
/// - enableCancel 为 true 时可以重复启动 / Can restart when true
/// - 组件销毁时会自动取消计时器 / Timer auto-cancels on dispose
/// - pauseTimer() 暂停后可以用 resumeTimer() 恢复 / Can resume after pause
/// - autoRestart 为 true 时倒计时会自动循环 / Auto loops when true
/// - onProgress 回调在每次时间变化时触发 / onProgress triggers on each tick
/// - onComplete 优先级高于 buildCompleter / onComplete has higher priority
///

typedef _BuildChild = Widget Function(BuildContext context, int time);
typedef BuildCompleter = void Function(BuildContext context);
typedef OnProgressCallback = void Function(int current, int total, double progress);

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

  /// 完成回调(新) / Completion callback (new)
  /// 
  /// 倒计时结束时触发,优先级高于buildCompleter
  /// Triggered when countdown completes, higher priority than buildCompleter
  final BuildCompleter? onComplete;

  /// 进度回调 / Progress callback
  /// 
  /// 每次时间变化时触发
  /// Triggered on each time change
  /// 
  /// 参数 / Parameters:
  /// - current: 当前剩余时间 / Current remaining time
  /// - total: 总时长 / Total duration
  /// - progress: 进度(0.0-1.0) / Progress (0.0-1.0)
  final OnProgressCallback? onProgress;

  /// 是否自动重启 / Auto restart
  /// 
  /// 倒计时结束后自动重新开始
  /// Automatically restart after countdown completes
  /// 
  /// 默认值: false / Default: false
  final bool autoRestart;

  /// 控制器 / Controller
  /// 
  /// 用于手动控制倒计时的启动、取消、暂停、恢复
  /// For manual control of start, cancel, pause, resume
  final TimeViewController? controller;

  const TimeView({
    required this.countdown,
    required this.build,
    this.controller,
    this.enableCancel = false,
    this.duration = const Duration(seconds: 1),
    this.buildCompleter,
    this.onComplete,
    this.onProgress,
    this.autoRestart = false,
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

  /// 是否暂停
  bool _isPaused = false;

  /// 暂停时的剩余时间
  int _pausedTime = 0;

  @override
  void initState() {
    super.initState();
    widget.controller?.bind(this);
    _currentTime = widget.countdown;
    if (widget.buildCompleter != null || widget.onComplete != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onComplete?.call(context);
        widget.buildCompleter?.call(context);
      });
    }
  }

  bool isStart() {
    return _timer != null && _currentTime != 0;
  }

  bool isPaused() {
    return _isPaused;
  }

  /// 获取当前进度 / Get current progress
  double getProgress() {
    if (widget.countdown == 0) return 1.0;
    return 1.0 - (_currentTime / widget.countdown);
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
    _isPaused = false;
    _currentTime = widget.countdown - 1;
    _notifyProgress();
    notyChange();

    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentTime == 1) {
        _handleComplete();
        return;
      }
      _currentTime = widget.countdown - timer.tick - 1;
      _notifyProgress();
      notyChange();
    });
  }

  /// 暂停倒计时 / Pause timer
  void pauseTimer() {
    if (_timer == null || _isPaused) return;
    _isPaused = true;
    _pausedTime = _currentTime;
    _timer?.cancel();
    _timer = null;
    notyChange();
  }

  /// 恢复倒计时 / Resume timer
  void resumeTimer() {
    if (!_isPaused) return;
    _isPaused = false;
    
    if (_pausedTime <= 0) {
      _handleComplete();
      return;
    }

    _currentTime = _pausedTime;
    int elapsedTicks = widget.countdown - _pausedTime;
    
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentTime == 1) {
        _handleComplete();
        return;
      }
      _currentTime = widget.countdown - (elapsedTicks + timer.tick) - 1;
      _notifyProgress();
      notyChange();
    });
    notyChange();
  }

  /// 处理完成事件 / Handle completion
  void _handleComplete() {
    cancelTimer();
    if (widget.autoRestart) {
      // 自动重启
      Future.delayed(Duration.zero, () {
        if (mounted) {
          startTimer();
        }
      });
    }
  }

  /// 通知进度变化 / Notify progress change
  void _notifyProgress() {
    if (widget.onProgress != null) {
      final progress = getProgress();
      widget.onProgress!(_currentTime, widget.countdown, progress);
    }
  }

  /// 取消倒计时的计时器。
  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
    _isPaused = false;
    _pausedTime = 0;
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

  /// 启动倒计时 / Start timer
  void startTimer() {
    _state?.startTimer();
  }

  /// 取消倒计时 / Cancel timer
  void cancelTimer() {
    _state?.cancelTimer();
  }

  /// 暂停倒计时 / Pause timer
  void pauseTimer() {
    _state?.pauseTimer();
  }

  /// 恢复倒计时 / Resume timer
  void resumeTimer() {
    _state?.resumeTimer();
  }

  /// 是否正在运行 / Is running
  bool isStart() {
    return _state?.isStart() ?? false;
  }

  /// 是否已暂停 / Is paused
  bool isPaused() {
    return _state?.isPaused() ?? false;
  }

  /// 获取当前进度 / Get current progress
  /// 返回值范围: 0.0-1.0 / Return range: 0.0-1.0
  double getProgress() {
    return _state?.getProgress() ?? 0.0;
  }

  /// 获取当前剩余时间 / Get current remaining time
  int getCurrentTime() {
    return _state?._currentTime ?? 0;
  }
}
