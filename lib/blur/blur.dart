library blur;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/utils/color_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/21
/// create_time: 9:09
/// describe: 高斯模糊
///
class Blur extends StatelessWidget {
  const Blur({
    Key? key,
    required this.child,
    this.blur = 5,
    this.blurColor = Colors.white,
    this.borderRadius,
    this.colorOpacity = 0.5,
    this.overlay,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Widget child;
  final double blur;
  final Color blurColor;
  final BorderRadius? borderRadius;
  final double colorOpacity;
  final Widget? overlay;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                decoration: BoxDecoration(
                  color: blurColor.setOpacity(colorOpacity),
                ),
                alignment: alignment,
                child: overlay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
extension BlurExtension on Widget {
  Blur blurred({
    double blur = 5,
    Color blurColor = Colors.white,
    BorderRadius? borderRadius,
    double colorOpacity = 0.5,
    Widget? overlay,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return Blur(
      child: this,
      blur: blur,
      blurColor: blurColor,
      borderRadius: borderRadius,
      colorOpacity: colorOpacity,
      overlay: overlay,
      alignment: alignment,
    );
  }
}
extension FrostExtension on Widget {
  Blur frosted({
    double blur = 5,
    Color frostColor = Colors.white,
    AlignmentGeometry alignment = Alignment.center,
    double? height,
    double? width,
    double frostOpacity = 0.0,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Blur(
      blur: blur,
      blurColor: frostColor,
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        child: height == null || width == null ? this : const SizedBox.shrink(),
        color: frostColor.setOpacity(frostOpacity),
      ),
      alignment: alignment,
      overlay: Padding(
        padding: padding,
        child: this,
      ),
    );
  }
}
