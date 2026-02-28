import 'dart:math' show max, min;
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/16
/// create_time: 9:19
/// describe: 气泡组件 - 支持多种箭头样式和完整的Material装饰
/// Enterprise-level bubble component - Supports multiple arrow styles and full Material decoration
///
/// ✨ 功能特性 / Features:
/// • 🎨 完整装饰 - 支持颜色、渐变、圆角、阴影、边框
/// • 🎯 箭头方向 - 支持上下左右四个方向
/// • 🔺 箭头形状 - 三角形、圆角三角、弧形等多种样式
/// • 📏 自适应大小 - 箭头大小可自动适配避免超出边界
/// • 🎪 Material风格 - 箭头和气泡保持一致的视觉效果
/// • ✂️ 裁剪控制 - 支持clipBehavior控制内容裁剪
/// • 📍 位置控制 - 箭头位置可通过百分比精确控制
/// • 🎭 灵活组合 - 可与任意Widget组合使用
///
/// 📖 使用示例 / Usage Examples:
///
/// ```dart
/// // 示例1: 基础气泡(顶部箭头)
/// // Example 1: Basic bubble with top arrow
/// Bubble(
///   radius: 8,
///   arrowWidth: 12,
///   arrowHeight: 8,
///   direction: BubbleArrowDirection.top,
///   decoration: BoxDecoration(
///     color: Colors.black87,
///     borderRadius: BorderRadius.circular(8),
///   ),
///   child: Padding(
///     padding: EdgeInsets.all(12),
///     child: Text(
///       '这是气泡提示内容',
///       style: TextStyle(color: Colors.white),
///     ),
///   ),
/// )
///
/// // 示例2: 带阴影和边框的气泡
/// // Example 2: Bubble with shadow and border
/// Bubble(
///   radius: 10,
///   arrowWidth: 15,
///   arrowHeight: 10,
///   direction: BubbleArrowDirection.bottom,
///   decoration: BoxDecoration(
///     color: Colors.white,
///     borderRadius: BorderRadius.circular(10),
///     border: Border.all(color: Colors.blue, width: 2),
///     boxShadow: [
///       BoxShadow(
///         color: Colors.black26,
///         blurRadius: 8,
///         offset: Offset(0, 4),
///       ),
///     ],
///   ),
///   child: Container(
///     padding: EdgeInsets.all(16),
///     child: Text('带边框和阴影的气泡'),
///   ),
/// )
///
/// // 示例3: 渐变色气泡
/// // Example 3: Gradient bubble
/// Bubble(
///   radius: 12,
///   arrowWidth: 16,
///   arrowHeight: 12,
///   direction: BubbleArrowDirection.left,
///   decoration: BoxDecoration(
///     gradient: LinearGradient(
///       colors: [Colors.purple, Colors.blue],
///       begin: Alignment.topLeft,
///       end: Alignment.bottomRight,
///     ),
///     borderRadius: BorderRadius.circular(12),
///   ),
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text(
///       '渐变色气泡',
///       style: TextStyle(color: Colors.white),
///     ),
///   ),
/// )
///
/// // 示例4: 圆角箭头气泡
/// // Example 4: Rounded arrow bubble
/// Bubble(
///   radius: 8,
///   arrowWidth: 14,
///   arrowHeight: 10,
///   arrowShape: BubbleArrowShape.rounded,
///   direction: BubbleArrowDirection.right,
///   decoration: BoxDecoration(
///     color: Colors.orange,
///     borderRadius: BorderRadius.circular(8),
///   ),
///   child: Padding(
///     padding: EdgeInsets.all(12),
///     child: Text('圆角箭头'),
///   ),
/// )
///
/// // 示例5: 自定义箭头位置
/// // Example 5: Custom arrow position
/// Bubble(
///   radius: 8,
///   arrowWidth: 12,
///   arrowHeight: 8,
///   arrowPositionPercent: 0.8, // 箭头位置在80%处
///   direction: BubbleArrowDirection.top,
///   decoration: BoxDecoration(
///     color: Colors.green,
///     borderRadius: BorderRadius.circular(8),
///   ),
///   child: Padding(
///     padding: EdgeInsets.all(12),
///     child: Text('箭头在右侧'),
///   ),
/// )
///
/// // 示例6: 弧形箭头气泡
/// // Example 6: Curved arrow bubble
/// Bubble(
///   radius: 10,
///   arrowWidth: 16,
///   arrowHeight: 12,
///   arrowShape: BubbleArrowShape.curved,
///   arrowAdaptive: true,
///   direction: BubbleArrowDirection.bottom,
///   decoration: BoxDecoration(
///     color: Colors.red,
///     borderRadius: BorderRadius.circular(10),
///     boxShadow: [
///       BoxShadow(
///         color: Colors.red.withOpacity(0.3),
///         blurRadius: 12,
///         spreadRadius: 2,
///       ),
///     ],
///   ),
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text(
///       '弧形箭头气泡',
///       style: TextStyle(color: Colors.white, fontSize: 16),
///     ),
///   ),
/// )
/// ```
///
/// ⚠️ 注意事项 / Notes:
/// • 箭头和气泡会自动保持一致的装饰效果(颜色、渐变、边框、阴影)
/// • arrowPositionPercent取值范围0.0-1.0,表示箭头在边上的位置百分比
/// • arrowAdaptive为true时,箭头会自动避开圆角区域
/// • 支持三种箭头形状: triangle(三角形)、rounded(圆角三角)、curved(弧形)
/// • clipBehavior控制是否裁剪超出气泡边界的内容
/// • 建议箭头大小与气泡大小成比例,避免视觉不协调
/// • 渐变色会同时应用到箭头和气泡主体
///

/// 箭头方向枚举
/// Arrow direction enum
enum BubbleArrowDirection {
  /// 左侧箭头 / Left arrow
  left,
  /// 顶部箭头 / Top arrow
  top,
  /// 右侧箭头 / Right arrow
  right,
  /// 底部箭头 / Bottom arrow
  bottom
}

/// 箭头形状枚举
/// Arrow shape enum
enum BubbleArrowShape {
  /// 普通三角形 / Normal triangle
  triangle,
  /// 圆角三角形 / Rounded triangle
  rounded,
  /// 弧形箭头 / Curved arrow
  curved,
}

/// 气泡组件
/// Bubble component
class Bubble extends StatelessWidget {
  /// 子组件 / Child widget
  final Widget child;
  
  /// 圆角半径 / Border radius
  /// 默认值: 8
  final double radius;
  
  /// 箭头宽度 / Arrow width
  /// 默认值: 12
  final double arrowWidth;
  
  /// 箭头高度 / Arrow height
  /// 默认值: 8
  final double arrowHeight;
  
  /// 箭头位置偏移百分比 / Arrow position percent (0.0-1.0)
  /// 默认值: 0.5 (居中)
  /// 范围: 0.0-1.0
  final double arrowPositionPercent;
  
  /// 箭头方向 / Arrow direction
  /// 默认值: BubbleArrowDirection.top
  final BubbleArrowDirection direction;
  
  /// 箭头形状 / Arrow shape
  /// 默认值: BubbleArrowShape.triangle
  final BubbleArrowShape arrowShape;
  
  /// 箭头大小是否自适应 / Arrow size adaptive
  /// 默认值: true
  /// 为true时箭头会自动避开圆角区域
  final bool arrowAdaptive;
  
  /// 气泡装饰器 / Bubble decoration
  /// 支持颜色、渐变、边框、阴影等
  final BoxDecoration? decoration;
  
  /// 裁剪行为 / Clip behavior
  /// 默认值: Clip.none
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
