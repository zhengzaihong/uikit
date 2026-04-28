import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2022/7/8
/// time: 14:58
/// describe: 响应式布局 基类
///
// Widget build(BuildContext context) {
//   return Responsive(
//     mobile: MobileHomePage(),
//     tablet: TabletHomePage(),
//     desktop: DesktopHomePage(),
//   );
// }
// //在子组件里判断
// if (Responsive.isMobile(context)) {
//   // 手机逻辑
// }

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  final double mobileSize;
  final double tabletSize;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.mobileSize = 650,
    this.tabletSize = 1100,
  }) : super(key: key);

  // 🔹 提供便捷判断方法
  static bool isMobile(BuildContext context, {double mobileSize = 650}) =>
      MediaQuery.of(context).size.width < mobileSize;

  static bool isTablet(BuildContext context,
      {double mobileSize = 650, double tabletSize = 1100}) =>
      MediaQuery.of(context).size.width >= mobileSize &&
          MediaQuery.of(context).size.width < tabletSize;

  static bool isDesktop(BuildContext context, {double tabletSize = 1100}) =>
      MediaQuery.of(context).size.width >= tabletSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletSize) {
          return desktop;
        } else if (constraints.maxWidth >= mobileSize) {
          return tablet ?? desktop; // 🔹 tablet 可选
        }
        return mobile;
      },
    );
  }
}

