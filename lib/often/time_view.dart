import 'dart:async';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/13
/// create_time: 9:43
/// describe: 用于倒计时类的控件，
/// 使用规范: 外部请不要将 TimeViewState 持久化。
///

typedef Child = Widget Function(BuildContext context, TimeViewState controller, int time);

class TimeView extends StatefulWidget {
  /// 倒计时的秒数
  final int countdown;

  ///返回子控件的回调
  final Child? child;

  ///时间单位
  final Duration duration;

  const TimeView(
      {required this.countdown,
      required this.child,
      this.duration = const Duration(seconds: 1),
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

  ///提供给外部的控制器
  late TimeViewState _controller;

  @override
  void initState() {
    super.initState();
    _controller = this;
    _currentTime = widget.countdown;
  }


  bool isStart(){
    return _timer!=null;
  }

  /// 启动倒计时的计时器。
  void startTimer() {
    if(_timer!=null){
      return;
    }
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentTime == 0) {
        cancelTimer();
        notyChange();
        return;
      }
      _currentTime--;
      notyChange();
    });
  }

  /// 取消倒计时的计时器。
  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
    _currentTime = 0;
    notyChange();
  }

  void notyChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!.call(context, _controller, _currentTime);
  }
}
