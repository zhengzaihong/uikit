import 'dart:math' show max, min;
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/16
/// create_time: 9:19
/// describe: 气泡组件
/// 箭头支持渐变、边框、阴影 → 箭头和气泡保持一致的视觉效果。
/// 可配置 arrowShape → 支持三角形 / 圆角三角形 / 弧形等扩展。
/// 箭头大小自适应 → 可选开关 arrowAdaptive，自动缩放避免超过边界或圆角。
/// 支持 clipBehavior → 控制是否裁剪气泡内容。
/// 支持 BoxDecoration（颜色、渐变、圆角、阴影、边框）。

/// 箭头方向
enum BubbleArrowDirection { left, top, right, bottom }

/// 箭头形状
enum BubbleArrowShape {
  triangle,      // 普通三角形
  rounded,       // 圆角三角
  curved,        // 弧形
}

/// 气泡组件
class Bubble extends StatelessWidget {
  //子组件
  final Widget child;
  //圆角
  final double radius;
  //箭头宽
  final double arrowWidth;
  //箭头高
  final double arrowHeight;
  //位置上的偏移（0-1）
  final double arrowPositionPercent;
  // 箭头方向
  final BubbleArrowDirection direction;
  // 箭头形状
  final BubbleArrowShape arrowShape;
  // 箭头大小是否自适应
  final bool arrowAdaptive;
  //气泡装饰器
  final BoxDecoration? decoration;
  //裁剪
  final Clip clipBehavior;

  const Bubble({
    super.key,
    required this.child,
    this.radius = 8,
    this.arrowWidth = 12,
    this.arrowHeight = 8,
    this.arrowPositionPercent = 0.5,
    this.direction = BubbleArrowDirection.top,
    this.arrowShape = BubbleArrowShape.triangle,
    this.arrowAdaptive = true,
    this.decoration,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(
        radius: radius,
        arrowWidth: arrowWidth,
        arrowHeight: arrowHeight,
        arrowPositionPercent: arrowPositionPercent,
        direction: direction,
        arrowShape: arrowShape,
        arrowAdaptive: arrowAdaptive,
        decoration: decoration,
      ),
      child: ClipPath(
        clipper: clipBehavior == Clip.none
            ? null
            : _BubbleClipper(
          radius: radius,
          arrowWidth: arrowWidth,
          arrowHeight: arrowHeight,
          arrowPositionPercent: arrowPositionPercent,
          direction: direction,
          arrowShape: arrowShape,
          arrowAdaptive: arrowAdaptive,
        ),
        clipBehavior: clipBehavior,
        child: Padding(
          padding: EdgeInsets.all(arrowHeight),
          child: child,
        ),
      ),
    );
  }
}

/// 绘制气泡
class _BubblePainter extends CustomPainter {
  final double radius;
  final double arrowWidth;
  final double arrowHeight;
  final double arrowPositionPercent;
  final BubbleArrowDirection direction;
  final BubbleArrowShape arrowShape;
  final bool arrowAdaptive;
  final BoxDecoration? decoration;

  _BubblePainter({
    required this.radius,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.arrowPositionPercent,
    required this.direction,
    required this.arrowShape,
    required this.arrowAdaptive,
    required this.decoration,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (decoration == null) return;

    final path = _buildBubblePath(size);

    // === 阴影 ===
    if (decoration!.boxShadow != null) {
      for (final shadow in decoration!.boxShadow!) {
        final shadowPaint = Paint()
          ..color = shadow.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius);
        canvas.save();
        canvas.translate(shadow.offset.dx, shadow.offset.dy);
        canvas.drawPath(path, shadowPaint);
        canvas.restore();
      }
    }

    // === 填充 ===
    if (decoration!.gradient != null) {
      final rect = Offset.zero & size;
      final paint = Paint()
        ..shader = decoration!.gradient!.createShader(rect);
      canvas.drawPath(path, paint);
    } else if (decoration!.color != null) {
      final paint = Paint()..color = decoration!.color!;
      canvas.drawPath(path, paint);
    }

    // === 边框 ===
    if (decoration!.border != null) {
      final border = decoration!.border as Border?;
      if (border != null) {
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = border.top.width
          ..color = border.top.color;
        canvas.drawPath(path, paint);
      }
    }
  }

  Path _buildBubblePath(Size size) {
    final path = Path();

    final width = size.width;
    final height = size.height;

    final left = direction == BubbleArrowDirection.left ? arrowHeight : 0.0;
    final top = direction == BubbleArrowDirection.top ? arrowHeight : 0.0;
    final right =
        width - (direction == BubbleArrowDirection.right ? arrowHeight : 0);
    final bottom =
        height - (direction == BubbleArrowDirection.bottom ? arrowHeight : 0);

    final innerWidth = right - left;
    final innerHeight = bottom - top;

    // final r = radius.clamp(0.0, min(innerWidth / 2.0, innerHeight / 2.0));
    //安全计算圆角上界，避免 clamp 上界 < 0 导致异常
    final double maxAllowedRadius = max(0.0, min(innerWidth / 2.0, innerHeight / 2.0));
    final double r = radius.clamp(0.0, maxAllowedRadius);

    // 箭头位置
    double arrowPos;
    if (direction == BubbleArrowDirection.top ||
        direction == BubbleArrowDirection.bottom) {
      arrowPos = left + arrowPositionPercent.clamp(0.0, 1.0) * innerWidth;
    } else {
      arrowPos = top + arrowPositionPercent.clamp(0.0, 1.0) * innerHeight;
    }

    if (arrowAdaptive) {
      if (direction == BubbleArrowDirection.top ||
          direction == BubbleArrowDirection.bottom) {
        arrowPos = arrowPos.clamp(left + r + arrowWidth / 2,
            right - r - arrowWidth / 2);
      } else {
        arrowPos = arrowPos.clamp(top + r + arrowWidth / 2,
            bottom - r - arrowWidth / 2);
      }
    }

    // --- 开始绘制 ---
    path.moveTo(left + r, top);

    // 顶部
    if (direction == BubbleArrowDirection.top) {
      _drawArrow(path, arrowPos, top, direction);
    }
    path.lineTo(right - r, top);
    path.quadraticBezierTo(right, top, right, top + r);

    // 右侧
    if (direction == BubbleArrowDirection.right) {
      _drawArrow(path, arrowPos, right, direction);
    }
    path.lineTo(right, bottom - r);
    path.quadraticBezierTo(right, bottom, right - r, bottom);

    // 底部
    if (direction == BubbleArrowDirection.bottom) {
      _drawArrow(path, arrowPos, bottom, direction);
    }
    path.lineTo(left + r, bottom);
    path.quadraticBezierTo(left, bottom, left, bottom - r);

    // 左侧
    if (direction == BubbleArrowDirection.left) {
      _drawArrow(path, arrowPos, left, direction);
    }
    path.lineTo(left, top + r);
    path.quadraticBezierTo(left, top, left + r, top);
    path.close();

    return path;
  }

  void _drawArrow(Path path, double arrowPos, double edge, BubbleArrowDirection dir) {
    switch (dir) {
      case BubbleArrowDirection.top:
        if (arrowShape == BubbleArrowShape.triangle) {
          path.lineTo(arrowPos - arrowWidth / 2, edge);
          path.lineTo(arrowPos, 0);
          path.lineTo(arrowPos + arrowWidth / 2, edge);
        } else if (arrowShape == BubbleArrowShape.rounded) {
          path.quadraticBezierTo(
              arrowPos - arrowWidth / 2, edge, arrowPos, 0);
          path.quadraticBezierTo(
              arrowPos + arrowWidth / 2, edge, arrowPos + arrowWidth / 2, edge);
        } else if (arrowShape == BubbleArrowShape.curved) {
          path.arcToPoint(
            Offset(arrowPos + arrowWidth / 2, edge),
            radius: Radius.circular(arrowHeight),
            clockwise: false,
          );
        }
        break;
      case BubbleArrowDirection.bottom:
        if (arrowShape == BubbleArrowShape.triangle) {
          path.lineTo(arrowPos + arrowWidth / 2, edge);
          path.lineTo(arrowPos, edge + arrowHeight);
          path.lineTo(arrowPos - arrowWidth / 2, edge);
        } else if (arrowShape == BubbleArrowShape.rounded) {
          path.quadraticBezierTo(
              arrowPos + arrowWidth / 2, edge, arrowPos, edge + arrowHeight);
          path.quadraticBezierTo(
              arrowPos - arrowWidth / 2, edge, arrowPos - arrowWidth / 2, edge);
        } else if (arrowShape == BubbleArrowShape.curved) {
          path.arcToPoint(
            Offset(arrowPos - arrowWidth / 2, edge),
            radius: Radius.circular(arrowHeight),
            clockwise: false,
          );
        }
        break;
      case BubbleArrowDirection.left:
        if (arrowShape == BubbleArrowShape.triangle) {
          path.lineTo(edge, arrowPos + arrowWidth / 2);
          path.lineTo(0, arrowPos);
          path.lineTo(edge, arrowPos - arrowWidth / 2);
        } else if (arrowShape == BubbleArrowShape.rounded) {
          path.quadraticBezierTo(
              edge, arrowPos + arrowWidth / 2, 0, arrowPos);
          path.quadraticBezierTo(
              edge, arrowPos - arrowWidth / 2, edge, arrowPos - arrowWidth / 2);
        } else if (arrowShape == BubbleArrowShape.curved) {
          path.arcToPoint(
            Offset(edge, arrowPos - arrowWidth / 2),
            radius: Radius.circular(arrowHeight),
            clockwise: false,
          );
        }
        break;
      case BubbleArrowDirection.right:
        if (arrowShape == BubbleArrowShape.triangle) {
          path.lineTo(edge, arrowPos - arrowWidth / 2);
          path.lineTo(edge + arrowHeight, arrowPos);
          path.lineTo(edge, arrowPos + arrowWidth / 2);
        } else if (arrowShape == BubbleArrowShape.rounded) {
          path.quadraticBezierTo(
              edge, arrowPos - arrowWidth / 2, edge + arrowHeight, arrowPos);
          path.quadraticBezierTo(
              edge, arrowPos + arrowWidth / 2, edge, arrowPos + arrowWidth / 2);
        } else if (arrowShape == BubbleArrowShape.curved) {
          path.arcToPoint(
            Offset(edge, arrowPos + arrowWidth / 2),
            radius: Radius.circular(arrowHeight),
            clockwise: false,
          );
        }
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _BubblePainter oldDelegate) =>
      oldDelegate.radius != radius ||
          oldDelegate.arrowWidth != arrowWidth ||
          oldDelegate.arrowHeight != arrowHeight ||
          oldDelegate.arrowPositionPercent != arrowPositionPercent ||
          oldDelegate.direction != direction ||
          oldDelegate.arrowShape != arrowShape ||
          oldDelegate.arrowAdaptive != arrowAdaptive ||
          oldDelegate.decoration != decoration;
}

/// ClipPath 用于裁剪气泡内部
class _BubbleClipper extends CustomClipper<Path> {
  final double radius;
  final double arrowWidth;
  final double arrowHeight;
  final double arrowPositionPercent;
  final BubbleArrowDirection direction;
  final BubbleArrowShape arrowShape;
  final bool arrowAdaptive;

  _BubbleClipper({
    required this.radius,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.arrowPositionPercent,
    required this.direction,
    required this.arrowShape,
    required this.arrowAdaptive,
  });

  @override
  Path getClip(Size size) {
    return _BubblePainter(
      radius: radius,
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      arrowPositionPercent: arrowPositionPercent,
      direction: direction,
      arrowShape: arrowShape,
      arrowAdaptive: arrowAdaptive,
      decoration: const BoxDecoration(color: Colors.transparent),
    )._buildBubblePath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
