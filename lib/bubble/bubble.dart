import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/bubble/bubble_arrow_direction.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/16
/// create_time: 9:19
/// describe: 气泡组件(需要固定宽高，通常用于背景)
///
class Bubble extends StatefulWidget {
  // 尖角位置
  final BubbleArrowDirection position;

  // 尖角高度
  final double arrHeight;

  // 尖角角度
  final double arrAngle;

  // 圆角半径
  final double radius;

  // 宽度
  final double width;

  // 高度
  final double height;

  // 边距
  final double length;

  // 颜色
  final Color color;

  // 边框颜色
  final Color borderColor;

  // 边框宽度
  final double strokeWidth;

  // 填充样式
  final PaintingStyle style;

  // 子 Widget
  final Widget? child;

  // 子 Widget 与起泡间距
  final double innerPadding;

  const Bubble({
    required this.width,
    required this.height,
    required this.color,
    required this.position,
    this.length = 1,
    this.arrHeight = 12.0,
    this.arrAngle = 60.0,
    this.radius = 10.0,
    this.strokeWidth = 4.0,
    this.style = PaintingStyle.fill,
    this.borderColor = Colors.transparent,
    this.child,
    this.innerPadding = 6.0,
    Key? key,
  }) : super(key: key);

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  late double length;
  late double radius;
  late double arrHeight;
  late double arrAngle;
  late Color borderColor;
  late double innerPadding;

  @override
  void initState() {
    super.initState();
    length = widget.length;
    radius = widget.radius;
    arrHeight = widget.arrHeight;
    arrAngle = widget.arrAngle;
    borderColor = widget.borderColor;
    innerPadding = widget.innerPadding;

    if (widget.style == PaintingStyle.stroke) {
      borderColor = widget.color;
    }
    if (widget.arrAngle < 0.0 || widget.arrAngle >= 180.0) {
      arrAngle = 60.0;
    }
    if (widget.arrHeight < 0.0) {
      arrHeight = 0.0;
    }
    if (widget.radius < 0.0 ||
        widget.radius > widget.width * 0.5 ||
        widget.radius > widget.height * 0.5) {
      radius = 0.0;
    }
    if (widget.position == BubbleArrowDirection.top ||
        widget.position == BubbleArrowDirection.bottom) {
      if (widget.length < 0.0 ||
          widget.length >= widget.width - 2 * widget.radius) {
        length = widget.width * 0.5 -
            widget.arrHeight * tan(_angle(widget.arrAngle * 0.5)) -
            widget.radius;
      }
    } else {
      if (widget.length < 0.0 ||
          widget.length >= widget.height - 2 * widget.radius) {
        length = widget.height * 0.5 -
            widget.arrHeight * tan(_angle(widget.arrAngle * 0.5)) -
            widget.radius;
      }
    }
    if (widget.innerPadding < 0.0 ||
        widget.innerPadding >= widget.width * 0.5 ||
        widget.innerPadding >= widget.height * 0.5) {
      innerPadding = 2.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bubbleWidget;
    if (widget.style == PaintingStyle.fill) {
      bubbleWidget = SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(children: <Widget>[
            CustomPaint(
                painter: BubbleCanvas(
                    context,
                    widget.width,
                    widget.height,
                    widget.color,
                    widget.position,
                    arrHeight,
                    arrAngle,
                    radius,
                    widget.strokeWidth,
                    widget.style,
                    length)),
            _paddingWidget()
          ]));
    } else {
      bubbleWidget = SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(children: <Widget>[
            CustomPaint(
                painter: BubbleCanvas(
                    context,
                    widget.width,
                    widget.height,
                    widget.color,
                    widget.position,
                    arrHeight,
                    arrAngle,
                    radius,
                    widget.strokeWidth,
                    PaintingStyle.fill,
                    length)),
            CustomPaint(
                painter: BubbleCanvas(
                    context,
                    widget.width,
                    widget.height,
                    borderColor,
                    widget.position,
                    arrHeight,
                    arrAngle,
                    radius,
                    widget.strokeWidth,
                    widget.style,
                    length)),
            _paddingWidget()
          ]));
    }
    return bubbleWidget;
  }

  Widget _paddingWidget() {
    return Padding(
        padding: EdgeInsets.only(
            top: (widget.position == BubbleArrowDirection.top)
                ? arrHeight + innerPadding
                : innerPadding,
            right: (widget.position == BubbleArrowDirection.right)
                ? arrHeight + innerPadding
                : innerPadding,
            bottom: (widget.position == BubbleArrowDirection.bottom)
                ? arrHeight + innerPadding
                : innerPadding,
            left: (widget.position == BubbleArrowDirection.left)
                ? arrHeight + innerPadding
                : innerPadding),
        child: Center(child: widget.child));
  }
}

class BubbleCanvas extends CustomPainter {
  BuildContext context;
  BubbleArrowDirection position;
  double arrHeight;
  double arrAngle;
  double radius;
  double width;
  double height;
  double length;
  Color color;
  double strokeWidth;
  PaintingStyle style;

  BubbleCanvas(
      this.context,
      this.width,
      this.height,
      this.color,
      this.position,
      this.arrHeight,
      this.arrAngle,
      this.radius,
      this.strokeWidth,
      this.style,
      this.length);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.left)
                    ? radius + arrHeight
                    : radius,
                (position == BubbleArrowDirection.top)
                    ? radius + arrHeight
                    : radius),
            radius: radius),
        pi,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.top) {
      path.lineTo(length + radius, arrHeight);
      path.lineTo(
          length + radius + arrHeight * tan(_angle(arrAngle * 0.5)), 0.0);
      path.lineTo(length + radius + arrHeight * tan(_angle(arrAngle * 0.5)) * 2,
          arrHeight);
    }
    path.lineTo(
        (position == BubbleArrowDirection.right)
            ? width - radius - arrHeight
            : width - radius,
        (position == BubbleArrowDirection.top) ? arrHeight : 0.0);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.right)
                    ? width - radius - arrHeight
                    : width - radius,
                (position == BubbleArrowDirection.top)
                    ? radius + arrHeight
                    : radius),
            radius: radius),
        -pi * 0.5,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.right) {
      path.lineTo(width - arrHeight, length + radius);
      path.lineTo(
          width, length + radius + arrHeight * tan(_angle(arrAngle * 0.5)));
      path.lineTo(width - arrHeight,
          length + radius + arrHeight * tan(_angle(arrAngle * 0.5)) * 2);
    }
    path.lineTo(
        (position == BubbleArrowDirection.right) ? width - arrHeight : width,
        (position == BubbleArrowDirection.bottom)
            ? height - radius - arrHeight
            : height - radius);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.right)
                    ? width - radius - arrHeight
                    : width - radius,
                (position == BubbleArrowDirection.bottom)
                    ? height - radius - arrHeight
                    : height - radius),
            radius: radius),
        pi * 0,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.bottom) {
      path.lineTo(width - radius - length, height - arrHeight);
      path.lineTo(
          width - radius - length - arrHeight * tan(_angle(arrAngle * 0.5)),
          height);
      path.lineTo(
          width - radius - length - arrHeight * tan(_angle(arrAngle * 0.5)) * 2,
          height - arrHeight);
    }
    path.lineTo(
        (position == BubbleArrowDirection.left) ? radius + arrHeight : radius,
        (position == BubbleArrowDirection.bottom)
            ? height - arrHeight
            : height);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(
                (position == BubbleArrowDirection.left)
                    ? radius + arrHeight
                    : radius,
                (position == BubbleArrowDirection.bottom)
                    ? height - radius - arrHeight
                    : height - radius),
            radius: radius),
        pi * 0.5,
        pi * 0.5,
        false);
    if (position == BubbleArrowDirection.left) {
      path.lineTo(arrHeight, height - radius - length);
      path.lineTo(0.0,
          height - radius - length - arrHeight * tan(_angle(arrAngle * 0.5)));
      path.lineTo(
          arrHeight,
          height -
              radius -
              length -
              arrHeight * tan(_angle(arrAngle * 0.5)) * 2);
    }
    path.lineTo((position == BubbleArrowDirection.left) ? arrHeight : 0.0,
        (position == BubbleArrowDirection.top) ? radius + arrHeight : radius);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = style
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

double _angle(angle) {
  return angle * pi / 180;
}
