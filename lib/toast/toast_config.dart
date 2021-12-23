import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/23
/// create_time: 14:56
/// describe: toast 配置文件
///

typedef BuildToastWidget = Widget Function(BuildContext context,String msg);

class ToastConfig {

  /// toast显示时间 单位 毫秒
  int showTime;

  /// 两次toast的间隔时间
  int intervalTime;

  ///显示位置
  ToastPosition position;

  ///构建toast样式
  BuildToastWidget buildToastWidget;

  ToastConfig({
    this.showTime=1000,
    this.position = ToastPosition.center,
    this.intervalTime = 2000,
     required this.buildToastWidget,
  });
}


///toast的显示位置
enum ToastPosition {
  center,
  bottom,
  top,
}
