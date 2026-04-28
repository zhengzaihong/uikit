import 'dart:ui';

import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2022/7/6
/// time: 14:45
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
