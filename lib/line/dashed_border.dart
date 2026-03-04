import 'package:flutter/material.dart';
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025-12-26
/// create_time: 16:13
/// describe: 虚线边框容器
/// eg:
//   DashedBorder(
//         color: borderColor,
//         strokeWidth: 2,
//         dashWidth: 5,
//         dashSpace: 3,
//         borderRadius: BorderRadius.circular(12),
//         child: widget,
//       )
class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius? borderRadius;

  const DashedBorder({
    Key? key,
    required this.child,
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/// 虚线边框绘制器
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius? borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (borderRadius != null) {
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      final rrect = borderRadius!.toRRect(rect);
      _drawDashedRRect(canvas, rrect, paint);
    } else {
      final rect = Rect.fromLTWH(0, 0, size.width, size.height);
      _drawDashedRect(canvas, rect, paint);
    }
  }

  void _drawDashedRRect(Canvas canvas, RRect rrect, Paint paint) {
    final path = Path()..addRRect(rrect);
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedRect(Canvas canvas, Rect rect, Paint paint) {
    final path = Path()..addRect(rect);
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final dashPaint = paint;
    final metric = path.computeMetrics().first;
    double distance = 0.0;

    while (distance < metric.length) {
      final start = metric.getTangentForOffset(distance);
      distance += dashWidth;
      final end = metric.getTangentForOffset(distance);

      if (start != null && end != null) {
        canvas.drawLine(start.position, end.position, dashPaint);
      }
      distance += dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace;
  }
}

