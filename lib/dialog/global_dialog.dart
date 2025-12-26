import 'dart:async';

import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025-12-26
/// create_time: 11:20
/// describe:全局对话框
///

class GlobalDialog {
  GlobalDialog._internal();

  static final GlobalDialog _instance = GlobalDialog._internal();

  static GlobalDialog get instance => _instance;

  OverlayEntry? _entry;
  Timer? _timer;

  /// [duration] 自动消失时间
  /// 如果在弹框未消失前再次调用，会仅重置倒计时，不会重复创建弹框。
  static void show({
    required BuildContext context,
    required WidgetBuilder builder,
    Duration? duration}) {
    _instance._show(context:context, builder: builder, duration: duration);
  }

  void _show({
    required BuildContext context,
    required WidgetBuilder builder,
    Duration? duration}) {
    // 首次创建 Overlay
    if (_entry == null) {
      _entry = OverlayEntry(
        builder: (context) => builder(context),
      );
      Overlay.of(context, rootOverlay: true).insert(_entry!);
    }

    // 无论是否已显示，都重置计时器
    if(duration!=null){
      _startTimer(duration);
    }
  }

  void _startTimer(Duration duration) {
    _timer?.cancel();
    _timer = Timer(duration, hide);
  }

  /// 主动关闭告警弹框
  static void hide() {
    _instance._hide();
  }


  void _hide() {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;
  }
}


