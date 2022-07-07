import 'package:flutter/material.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/6
/// create_time: 14:45
/// describe: 去除列表类的波纹效果
///
class OverScrollBehavior extends ScrollBehavior{

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return ScrollConfiguration(behavior: this, child: child);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return ScrollConfiguration(behavior: this, child: GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).colorScheme.secondary,
        ));
    }
    return const SizedBox();
  }

}