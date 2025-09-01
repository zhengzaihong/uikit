import 'dart:async';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/13
/// create_time: 9:43
/// describe: 用于倒计时类的控件，
///

typedef _BuildChild = Widget Function(BuildContext context, int time);
typedef BuildCompleter = void Function(BuildContext context);

class TimeView extends StatefulWidget {
  /// 倒计时的秒数
  final int countdown;

  ///返回子控件的回调
  final _BuildChild? build;

  ///时间单位
  final Duration duration;

  final bool enableCancel;

  final BuildCompleter? buildCompleter;

  final TimeViewController? controller;

  const TimeView(
      {required this.countdown,
      required this.build,
      this.controller,
      this.enableCancel = false,
      this.duration = const Duration(seconds: 1),
      this.buildCompleter,
      Key? key})
      : super(key: key);

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
