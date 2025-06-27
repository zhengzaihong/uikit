import 'dart:ui';

import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/6
/// create_time: 14:45
/// describe: 去除列表类的波纹效果
///
class OverScrollBehavior extends ScrollBehavior {

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
