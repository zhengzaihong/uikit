import 'dart:ui';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/18
/// create_time: 15:08
/// describe: 全局全屏弹窗,
/// 支持模糊背景,此组件不用于组件树child,通常用于事件弹出等
/// 它是 drawer的一种简单替代方案。
///

typedef BuildChild = Widget Function(FullPopView popView);

class FullPopView {

  final BuildChild buildChild;
  final Color backgrounColor;
  final AlignmentGeometry alignment;
  final double sigmaX;
  final double sigmaY;
  final TileMode tileMode;
  final double contentOpacity;
  final bool outTouchSide;
  final int interval;

  FullPopView({
    required this.buildChild,
    this.alignment = Alignment.center,
    this.backgrounColor = Colors.transparent,
    this.sigmaX=5.0,
    this.sigmaY = 5.0,
    this.tileMode = TileMode.clamp,
    this.contentOpacity = 1,
    this.outTouchSide = false,
    this.interval = 2000,

  });

  OverlayEntry? _overlayEntry;

  DateTime? _startedTime;

  void showPop(BuildContext context) {
    if (_startedTime != null &&
        DateTime
            .now()
            .difference(_startedTime!)
            .inMilliseconds < interval) {
      return;
    }

    _startedTime = DateTime.now();

    Size size = MediaQuery
        .of(context)
        .size;

    ///获取OverlayState
    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            GestureDetector(
              onTap: (){
                if(outTouchSide){
                  closePop();
                }
              },
              child: Container(
                  alignment: alignment,
                  color: backgrounColor,
                  width: size.width,
                  height: size.height,
                  child: BackdropFilter(
                    /// 背景过滤器
                    filter: ImageFilter.blur(sigmaX:sigmaX, sigmaY:sigmaY),
                    child: Opacity(
                      opacity: contentOpacity,
                      child: buildChild(this),
                    ),
                  )),
            ));
    overlayState?.insert(_overlayEntry!);
  }

  void closePop() {
    _overlayEntry?.remove();
  }
}
