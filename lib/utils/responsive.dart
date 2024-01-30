import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/8
/// create_time: 14:58
/// describe: 响应式布局 基类
///

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final double? mobileSize;
  final double? tabletSize;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.mobileSize = 650,
    this.tabletSize = 1100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletSize!) {
          return desktop;
        } else if (constraints.maxWidth >= mobileSize!) {
          return tablet;
        }
        return mobile;
      },
    );
  }
}

