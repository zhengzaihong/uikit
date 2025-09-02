import 'dart:math';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/29
/// create_time: 14:42
/// describe: N维度雷达图
///
// 基础示例：
// final dims = [
//   RadarDimension(name: '速度', max: 100, scoreStyle:  TextStyle(color: Colors.white), labelBgColor: Colors.red),
//   RadarDimension(name: '力量', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.blue),
//   RadarDimension(name: '耐力', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.green),
//   RadarDimension(name: '敏捷', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.orange),
//   RadarDimension(name: '智力', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.purple),
//   // 想要更多维度？加上即可（≥ 3）
// ];
// // 多组数据
// final series = [
//   RadarSeries(
//     values: [80, 100, 70, 60, 90],
//     labelBgColor: Colors.pink,
//     fillColor: Colors.blue,
//     fillOpacity: 0.28,
//     strokeColor: Colors.transparent,
//     legend: '玩家 A',
//   ),
//    .....
// ];
//         RadarChart(
//               dimensions: dims,
//               series: series,
//               radius: 90,
//               levels: 5,
//               outerLabelStyle: RadarOuterLabelStyle.scoreOverTitle,
//               gridShape: RadarGridShape.polygon,
//               // 或 RadarGridShape.circle
//               labelMode: RadarLabelMode.inner, // inner / outerBadge / none
//               showInnerLabelBg: true, // 在inner模式下，不显示背景
//               showScore: true,
//               // 是否同时显示分数
//               badgeRadius: 20,
//               titlePadding: 10,
//               titleMargin: 10,
//               // axisLinePaint: Paint()
//               //   ..color = Colors.cyanAccent.setAlpha(0.3)
//               //   ..strokeWidth = 0.5
//               //   ..style = PaintingStyle.stroke,
//               // gridLinePaint: Paint()
//               //   ..color = Colors.cyanAccent.withAlpha(100)
//               //   ..strokeWidth = 0.1
//               //   ..style = PaintingStyle.stroke,
//               // gridFillPaint: Paint()
//               //   ..color = Colors.cyanAccent.setAlpha(0.1)
//               //   ..strokeWidth = 1
//               //   ..style = PaintingStyle.fill,
//               animate: true,
//               animationDuration: const Duration(milliseconds: 1000),
//               animationCurve: Curves.bounceIn,
//               showLegend: false,
//               onDimensionTapped: (index) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('你点击了维度: ${dims[index].name}'),
//                     duration: const Duration(seconds: 1),
//                   ),
//                 );
//                 print('你点击了维度: ${dims[index].name}');
//               },
//             )


/// ========== 公共类型 & 模型 ==========

enum RadarLabelMode {
  /// normal：外侧标题 + 可选外侧圆形分数徽章
  outerBadge,

  /// 标签（可含分数）绘制在最外层顶点处
  inner,

  /// 仅绘制雷达，不绘制任何文本/徽章
  none,
}

/// 配合 [RadarLabelMode.outerBadge] 使用
enum RadarOuterLabelStyle {
  /// 徽章在标题外侧（方向随象限变化）
  radial,
  /// 标题在上，分数徽章在下
  titleOverScore,
  /// 分数徽章在上，标题在下
  scoreOverTitle,
}


enum RadarGridShape {
  polygon, // 正多边形网格
  circle,  // 同心圆网格
}

/// 自定义标签位置回调（可覆盖自动布局）
/// anchor: 该轴最外层顶点（外圈）
/// axisIndex: 维度索引
/// radius: 雷达半径
/// textSize: 文本的大小（便于你做细调）
/// 返回应为“文本中心”坐标（相对画布中心的偏移量）
typedef LabelPositioner = Offset Function(
    Offset anchor,
    int axisIndex,
    double radius,
    Size textSize,
    );

/// 维度定义（每条轴）
/// [name] 轴名称
/// [max] 该维最大值（用于归一化）
/// [titleStyle] 名称样式
/// [scoreStyle] 分数样式（显示分数时）
/// [labelBgColor] 徽章背景色
class RadarDimension {
  final String name;
  final double max;
  final TextStyle titleStyle;
  final TextStyle scoreStyle;
  final Color? labelBgColor;

  const RadarDimension({
    required this.name,
    required this.max,
    this.titleStyle = const TextStyle(fontSize: 12, color: Colors.black87),
    this.scoreStyle = const TextStyle(fontSize: 12, color: Colors.black),
    this.labelBgColor,
  });
}

/// 一组数据（可一次渲染多组）
/// [values] 与 [dimensions] 一一对应
/// [fillColor]/[fillGradient]/[fillOpacity] 填充
/// [strokeColor]/[strokeWidth] 描边
/// [showPoints]/[pointRadius] 顶点圆点
/// [labelBgColor] 外侧徽章/内侧徽章背景（与 labelMode 相关）
/// [legend] 用于图例显示
class RadarSeries {
  final List<double> values;

  final Color? fillColor;
  final Gradient? fillGradient;
  final double fillOpacity;

  final Color strokeColor;
  final double strokeWidth;

  final bool showPoints;
  final double pointRadius;

  final Color labelBgColor;

  final String? legend;

  const RadarSeries({
    required this.values,
    this.fillColor,
    this.fillGradient,
    this.fillOpacity = 0.35,
    this.strokeColor = const Color(0xFF607D8B),
    this.strokeWidth = 2,
    this.showPoints = true,
    this.pointRadius = 3,
    this.labelBgColor = Colors.white,
    this.legend,
  }) : assert(fillOpacity >= 0 && fillOpacity <= 1);
}

/// ========== 主组件 ==========

class RadarChart extends StatefulWidget {
  /// 维度定义（长度 = 轴数，≥ 3）
  final List<RadarDimension> dimensions;

  /// 数据系列（可多组）
  final List<RadarSeries> series;

  /// 半径（不含标签外扩），若父级无约束会使用该半径计算尺寸
  final double radius;

  /// 网格层数（圈数/多边形层数）
  final int levels;

  /// 网格形状
  final RadarGridShape gridShape;

  /// 起始角度（度），默认 -90° 从正上方开始
  final double startAngle;

  /// 顺时针方向绘制
  final bool clockwise;

  /// 轴线画笔
  final Paint? axisLinePaint;

  /// 网格画笔（线框）
  final Paint? gridLinePaint;

  /// 网格填充（仅 polygon 模式可见，circle 模式可选填充）
  final Paint? gridFillPaint;

  /// 标签模式：outerBadge / inner / none
  final RadarLabelMode labelMode;
  
  /// 当 labelMode = inner 时，是否显示圆形背景
  final bool showInnerLabelBg;

  /// 当 labelMode = outerBadge 时，标题与分数徽章的布局风格
  final RadarOuterLabelStyle outerLabelStyle;

  /// 是否显示分数（结合 labelMode 生效）
  final bool showScore;

  /// 外侧徽章/内侧徽章的圆半径
  final double badgeRadius;

  /// 文本与图形的距离（外侧模式）
  final double titlePadding;

  /// 文本与徽章之间的额外间距（外侧模式）
  final double titleMargin;

  /// 文本布局自定义回调（若返回非空，覆盖默认布局）
  final LabelPositioner? customLabelPosition;

  /// 动画
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  /// 图例（底部水平），传 null 或空则不显示
  final TextStyle legendTextStyle;
  final double legendSpacing;
  final double legendDotSize;
  final bool showLegend;
  
  /// 每个维度标签的点击事件
  final ValueChanged<int>? onDimensionTapped;

  const RadarChart({
    Key? key,
    required this.dimensions,
    required this.series,
    this.radius = 72,
    this.levels = 5,
    this.gridShape = RadarGridShape.polygon,
    this.startAngle = -90,
    this.clockwise = true,
    this.axisLinePaint,
    this.gridLinePaint,
    this.gridFillPaint,
    this.labelMode = RadarLabelMode.outerBadge,
    this.showInnerLabelBg = true,
    this.outerLabelStyle = RadarOuterLabelStyle.radial,
    this.showScore = true,
    this.badgeRadius = 18,
    this.titlePadding = 10,
    this.titleMargin = 10,
    this.customLabelPosition,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 900),
    this.animationCurve = Curves.easeOutCubic,
    this.legendTextStyle = const TextStyle(fontSize: 12, color: Colors.black87),
    this.legendSpacing = 12,
    this.legendDotSize = 10,
    this.showLegend = true,
    this.onDimensionTapped,
  })  : assert(dimensions.length >= 3, 'Radar axes must be >= 3'),
        super(key: key);

  @override
  State<RadarChart> createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;
  
  // 保存每个维度标签的可点击区域
  final List<Rect> _dimensionTapAreas = [];

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );
      _anim = CurvedAnimation(parent: _controller, curve: widget.animationCurve);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _controller.forward(from: 0);
      });
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1),
      )..value = 1;
      _anim = AlwaysStoppedAnimation(1.0);
    }
  }

  @override
  void didUpdateWidget(covariant RadarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 若数据或配置变化，重新播放动画
    if (widget.animate &&
        (oldWidget.dimensions.length != widget.dimensions.length ||
            oldWidget.series.length != widget.series.length ||
            oldWidget.radius != widget.radius)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Size _computePaintSize() {
    // 估算一个安全画布：半径 + 徽章与文字外扩
    final maxTitleExtent = widget.dimensions
        .map((e) => e.titleStyle.fontSize ?? 12)
        .fold<double>(0, (p, e) => max(p, e)) +
        4; // 估略字体高度
    final outer = widget.labelMode == RadarLabelMode.none
        ? 6
        : (widget.badgeRadius +
        widget.titlePadding +
        widget.titleMargin +
        maxTitleExtent);
    final r = widget.radius + outer;
    final side = r * 2 + 8; // 额外留白
    // 图例高度简单估算
    final legendH = (widget.showLegend && widget.series.any((s) => s.legend != null))
        ? 24 + widget.legendSpacing
        : 0;
    return Size(side, side + legendH);
  }
  
  void _handleTapUp(TapUpDetails details) {
    if (widget.onDimensionTapped == null) return;
    
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = renderBox.globalToLocal(details.globalPosition);

    for (int i = 0; i < _dimensionTapAreas.length; i++) {
      if (_dimensionTapAreas[i].contains(localPosition)) {
        widget.onDimensionTapped!(i);
        break; 
      }
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    final size = _computePaintSize();

    return RepaintBoundary(
      child: GestureDetector(
         onTapUp: _handleTapUp,
         child: SizedBox(
          width: size.width,
          height: size.height,
          child: AnimatedBuilder(
            animation: _anim,
            builder: (context, _) {
              return CustomPaint(
                painter: _RadarPainter(
                  progress: _anim.value,
                  dimensions: widget.dimensions,
                  series: widget.series,
                  radius: widget.radius,
                  levels: widget.levels,
                  gridShape: widget.gridShape,
                  startAngleDeg: widget.startAngle,
                  clockwise: widget.clockwise,
                  axisLinePaint: widget.axisLinePaint,
                  gridLinePaint: widget.gridLinePaint,
                  gridFillPaint: widget.gridFillPaint,
                  labelMode: widget.labelMode,
                  showInnerLabelBg: widget.showInnerLabelBg,
                  outerLabelStyle: widget.outerLabelStyle,
                  showScore: widget.showScore,
                  badgeRadius: widget.badgeRadius,
                  titlePadding: widget.titlePadding,
                  titleMargin: widget.titleMargin,
                  customLabelPosition: widget.customLabelPosition,
                  legendTextStyle: widget.legendTextStyle,
                  legendSpacing: widget.legendSpacing,
                  legendDotSize: widget.legendDotSize,
                  showLegend: widget.showLegend,
                  dimensionTapAreas: _dimensionTapAreas,
                ),
                size: size,
              );
            },
          ),
        ),
      )
    );
  }
}

/// ========== 画笔实现 ==========

class _RadarPainter extends CustomPainter {
  final double progress;

  final List<RadarDimension> dimensions;
  final List<RadarSeries> series;

  final double radius;
  final int levels;
  final RadarGridShape gridShape;
  final double startAngleDeg;
  final bool clockwise;

  final Paint? axisLinePaint;
  final Paint? gridLinePaint;
  final Paint? gridFillPaint;

  final RadarLabelMode labelMode;
  final bool showInnerLabelBg;
  final RadarOuterLabelStyle outerLabelStyle;
  final bool showScore;
  final double badgeRadius;
  final double titlePadding;
  final double titleMargin;
  final LabelPositioner? customLabelPosition;

  final TextStyle legendTextStyle;
  final double legendSpacing;
  final double legendDotSize;
  final bool showLegend;
  
  // 接收用于存储点击区域的列表
  final List<Rect> dimensionTapAreas;

  _RadarPainter({
    required this.progress,
    required this.dimensions,
    required this.series,
    required this.radius,
    required this.levels,
    required this.gridShape,
    required this.startAngleDeg,
    required this.clockwise,
    required this.axisLinePaint,
    required this.gridLinePaint,
    required this.gridFillPaint,
    required this.labelMode,
    required this.showInnerLabelBg,
    required this.outerLabelStyle,
    required this.showScore,
    required this.badgeRadius,
    required this.titlePadding,
    required this.titleMargin,
    required this.customLabelPosition,
    required this.legendTextStyle,
    required this.legendSpacing,
    required this.legendDotSize,
    required this.showLegend,
    required this.dimensionTapAreas,
  }) : assert(dimensions.length >= 3);

  @override
  void paint(Canvas canvas, Size size) {
    
    // 清空旧的点击区域
    dimensionTapAreas.clear();
    
    final center = Offset(size.width / 2, (size.height - _legendHeight()) / 2);
    canvas.save();
    canvas.translate(center.dx, center.dy);

    final n = dimensions.length;
    final angles = _anglesRad(n, startAngleDeg, clockwise);
    final axisPointsOuter = List.generate(
      n,
          (i) => Offset(
        radius * cos(angles[i]),
        radius * sin(angles[i]),
      ),
    );

    // 画网格
    _drawGrid(canvas, angles);

    // 画轴线
    _drawAxes(canvas, axisPointsOuter);

    // 画多系列数据
    for (final s in series) {
      _drawSeries(canvas, s, angles);
    }

    // 文本 & 徽章
    if (labelMode != RadarLabelMode.none) {
      _drawLabels(canvas, axisPointsOuter, size);
    }

    canvas.restore();

    // 图例
    if (showLegend && series.any((s) => s.legend != null)) {
      _drawLegend(canvas, size);
    }
  }

  double _legendHeight() {
    if (!showLegend || !series.any((s) => s.legend != null)) return 0;
    return 24 + legendSpacing;
  }

  List<double> _anglesRad(int n, double startDeg, bool clockwise) {
    final start = startDeg * pi / 180.0;
    final step = 2 * pi / n;
    return List.generate(n, (i) => start + (clockwise ? i : -i) * step);
  }

  void _drawGrid(Canvas canvas, List<double> angles) {
    // 填充（可选）
    if (gridFillPaint != null) {
      switch (gridShape) {
        case RadarGridShape.polygon:
          for (int level = 1; level <= levels; level++) {
            final r = radius * level / levels;
            final path = Path()
              ..addPolygon(
                List.generate(
                  angles.length,
                      (i) => Offset(r * cos(angles[i]), r * sin(angles[i])),
                ),
                true,
              );
            canvas.drawPath(path, gridFillPaint!);
          }
          break;
        case RadarGridShape.circle:
          for (int level = 1; level <= levels; level++) {
            final r = radius * level / levels;
            canvas.drawCircle(Offset.zero, r, gridFillPaint!);
          }
          break;
      }
    }

    // 线框
    final linePaint = gridLinePaint ??
        (Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0x1F000000)
          ..strokeWidth = 1);
    switch (gridShape) {
      case RadarGridShape.polygon:
        for (int level = 1; level <= levels; level++) {
          final r = radius * level / levels;
          final path = Path()
            ..addPolygon(
              List.generate(
                angles.length,
                    (i) => Offset(r * cos(angles[i]), r * sin(angles[i])),
              ),
              true,
            );
          canvas.drawPath(path, linePaint);
        }
        break;
      case RadarGridShape.circle:
        for (int level = 1; level <= levels; level++) {
          final r = radius * level / levels;
          canvas.drawCircle(Offset.zero, r, linePaint);
        }
        break;
    }
  }

  void _drawAxes(Canvas canvas, List<Offset> outer) {
    final p = axisLinePaint ??
        (Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0x33000000)
          ..strokeWidth = 1);
    for (final o in outer) {
      canvas.drawLine(Offset.zero, o, p);
    }
  }

  void _drawSeries(Canvas canvas, RadarSeries s, List<double> angles) {
    final n = dimensions.length;
    if (s.values.length != n) return;

    final pts = List.generate(n, (i) {
      final maxV = max(1e-9, dimensions[i].max);
      final v = s.values[i].clamp(0, maxV) / maxV;
      final r = radius * v * progress;
      return Offset(r * cos(angles[i]), r * sin(angles[i]));
    });

    // 填充
    if (s.fillGradient != null) {
      final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
      final paint = Paint()
        ..shader = s.fillGradient!.createShader(rect)
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..colorFilter = ColorFilter.mode(
            Colors.black.withValues(alpha: (1 - s.fillOpacity)), BlendMode.dstOut);
      final path = Path()..addPolygon(pts, true);
      canvas.drawPath(path, paint);
    } else if (s.fillColor != null) {
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..color = s.fillColor!.withValues(alpha: s.fillOpacity);
      final path = Path()..addPolygon(pts, true);
      canvas.drawPath(path, paint);
    }

    // 描边
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = s.strokeWidth
      ..color = s.strokeColor;
    final borderPath = Path()..addPolygon(pts, true);
    canvas.drawPath(borderPath, stroke);

    // 顶点
    if (s.showPoints) {
      final dotPaint = Paint()
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..color = s.strokeColor;
      for (final p in pts) {
        canvas.drawCircle(p, s.pointRadius, dotPaint);
      }
    }
  }

  void _drawLabels(Canvas canvas, List<Offset> anchors, Size size) {
    
    final center = Offset(size.width / 2, (size.height - _legendHeight()) / 2);
    
    for (int i = 0; i < anchors.length; i++) {
      final dim = dimensions[i];
      final name = dim.name;

      final titlePainter = TextPainter(
        text: TextSpan(text: name, style: dim.titleStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      // 计算分数（若显示：取“第一组系列”的该维当前动画值作为例子，也可换为平均/最大等策略）
      final showSc = showScore && series.isNotEmpty;
      TextPainter? scorePainter;
      if (showSc) {
        final maxV = max(1e-9, dim.max);
        // 这里以第一组数据为徽章分数字体；如需别的逻辑可扩展
        final raw = series.first.values[i].clamp(0, maxV).toDouble();
        final animatedVal = raw * progress;
        final text = animatedVal.toStringAsFixed(animatedVal % 1 == 0 ? 0 : 1);
        scorePainter = TextPainter(
          text: TextSpan(text: text, style: dim.scoreStyle),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )..layout();
      }

      final Size textSize = Size(
        titlePainter.width,
        titlePainter.height +
            ((showSc && labelMode == RadarLabelMode.outerBadge) ? (titleMargin + badgeRadius * 2) : 0),
      );

      Offset pos;
      if (customLabelPosition != null) {
        pos = customLabelPosition!(anchors[i], i, radius, textSize);
      } else {
        // Fallback to default positioning, though it's now handled inside cases
        pos = Offset.zero;
      }

      switch (labelMode) {
        case RadarLabelMode.outerBadge:
          if (outerLabelStyle == RadarOuterLabelStyle.radial) {
            // --- Radial logic ---
            final out = titlePadding + max(titlePainter.width, titlePainter.height)/2;
            pos = _defaultLabelPos(anchors[i], i, out, textSize: titlePainter.size);

            final titleOffset = Offset(
              pos.dx - titlePainter.width / 2,
              pos.dy - titlePainter.height / 2,
            );
            titlePainter.paint(canvas, titleOffset);
            
            // Store tap area for the title
            dimensionTapAreas.add(Rect.fromLTWH(titleOffset.dx + center.dx, titleOffset.dy + center.dy, titlePainter.width, titlePainter.height));

            if (showSc && series.isNotEmpty && scorePainter != null) {
              final bg = dim.labelBgColor ?? series.first.labelBgColor;
              final paint = Paint()
                ..style = PaintingStyle.fill
                ..isAntiAlias = true
                ..color = bg;
              final a = atan2(anchors[i].dy, anchors[i].dx);
              final dir = Offset(cos(a), sin(a));
              final badgeCenter = Offset(
                pos.dx + dir.dx * (titlePainter.height / 2 + titleMargin + badgeRadius),
                pos.dy + dir.dy * (titlePainter.height / 2 + titleMargin + badgeRadius),
              );
              canvas.drawCircle(badgeCenter, badgeRadius, paint);

              final so = Offset(
                badgeCenter.dx - scorePainter.width / 2,
                badgeCenter.dy - scorePainter.height / 2,
              );
              scorePainter.paint(canvas, so);
            }
          } else {
            // --- Vertical stacking logic ---
            final hasScore = showSc && series.isNotEmpty && scorePainter != null;
            final totalHeight = titlePainter.height + (hasScore ? (titleMargin + badgeRadius * 2) : 0);
            final totalWidth = hasScore ? max(titlePainter.width, scorePainter.width) : titlePainter.width;
            final totalSize = Size(totalWidth, totalHeight);

            final out = titlePadding + totalHeight / 2;
            pos = _defaultLabelPos(anchors[i], i, out, textSize: totalSize);

            double titleY;
            double badgeCenterY;

            if (outerLabelStyle == RadarOuterLabelStyle.titleOverScore) {
              titleY = pos.dy - totalHeight / 2;
              badgeCenterY = titleY + titlePainter.height + titleMargin + badgeRadius;
            } else { // scoreOverTitle
              badgeCenterY = pos.dy - totalHeight / 2 + badgeRadius;
              titleY = badgeCenterY + badgeRadius + titleMargin;
            }

            final titleOffset = Offset(pos.dx - titlePainter.width / 2, titleY);
            titlePainter.paint(canvas, titleOffset);
            
            dimensionTapAreas.add(Rect.fromLTWH(titleOffset.dx + center.dx, titleOffset.dy + center.dy, titlePainter.width, titlePainter.height));


            if (hasScore) {
              final bg = dim.labelBgColor ?? series.first.labelBgColor;
              final paint = Paint()
                ..style = PaintingStyle.fill
                ..isAntiAlias = true
                ..color = bg;
              final badgeCenter = Offset(pos.dx, badgeCenterY);
              canvas.drawCircle(badgeCenter, badgeRadius, paint);

              final so = Offset(
                badgeCenter.dx - scorePainter.width / 2,
                badgeCenter.dy - scorePainter.height / 2,
              );
              scorePainter.paint(canvas, so);
            }
          }
          break;

        case RadarLabelMode.inner:
          final innerTextPainter = TextPainter(
            text: TextSpan(
              children: [
                TextSpan(text: name, style: dim.titleStyle),
                if (showSc && scorePainter?.text != null) ...[
                  TextSpan(text: '\n', style: dim.titleStyle),
                  scorePainter!.text as TextSpan,
                ],
              ],
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          )..layout();

          final out = titlePadding + innerTextPainter.height / 2;
          pos = _defaultLabelPos(anchors[i], i, out, textSize: innerTextPainter.size);

          if (showInnerLabelBg) {
             final bg = dim.labelBgColor ?? series.first.labelBgColor;
             final paint = Paint()
              ..style = PaintingStyle.fill
              ..isAntiAlias = true
              ..color = bg;
             canvas.drawCircle(pos, badgeRadius, paint);
          }
          
          final textOffset = Offset(
              pos.dx - innerTextPainter.width / 2,
              pos.dy - innerTextPainter.height / 2,
          );
          
          innerTextPainter.paint(
            canvas,
            textOffset,
          );
          
          dimensionTapAreas.add(Rect.fromLTWH(textOffset.dx + center.dx, textOffset.dy + center.dy, innerTextPainter.width, innerTextPainter.height));

          break;

        case RadarLabelMode.none:
          break;
      }
    }
  }

  Offset _defaultLabelPos(Offset anchor, int axisIndex, double out, {Size? textSize}) {
    final a = atan2(anchor.dy, anchor.dx);
    final dir = Offset(cos(a), sin(a));

    final p = Offset(anchor.dx + dir.dx * out, anchor.dy + dir.dy * out);

    // 针对接近垂直或水平的轴，做对齐优化，避免“倾斜”感
    double finalX = p.dx;
    double finalY = p.dy;

    // tan(60 deg) = 1.732. If slope is steeper than 60deg, treat as vertical.
    if (dir.dy.abs() > dir.dx.abs() * 1.732) {
      finalX = anchor.dx; // Mostly vertical, align horizontally to anchor
    }
    // tan(30 deg) = 0.577. If slope is shallower than 30deg, treat as horizontal.
    else if (dir.dx.abs() > dir.dy.abs() * 1.732) {
      finalY = anchor.dy; // Mostly horizontal, align vertically to anchor
    }

    return Offset(finalX, finalY);
  }

  void _drawLegend(Canvas canvas, Size size) {
    final items = series
        .asMap()
        .entries
        .where((e) => e.value.legend != null && e.value.legend!.isNotEmpty)
        .toList();
    if (items.isEmpty) return;

    final totalWidth = size.width;
    final y = size.height - legendSpacing - 12;

    // 居中排布
    double xCursor = 0;
    final measures = <_LegendMeasure>[];
    for (final e in items) {
      final tp = TextPainter(
        text: TextSpan(text: e.value.legend, style: legendTextStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      measures.add(_LegendMeasure(e.key, e.value, tp));
      xCursor += legendDotSize + 6 + tp.width + 16;
    }
    final startX = (totalWidth - xCursor).clamp(0, double.infinity) / 2;

    double x = startX;
    for (final m in measures) {
      final color = m.series.strokeColor;
      final dotPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = color;
      canvas.drawCircle(Offset(x + legendDotSize / 2, y), legendDotSize / 2, dotPaint);
      x += legendDotSize + 6;

      m.text.paint(canvas, Offset(x, y - m.text.height / 2));
      x += m.text.width + 16;
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter old) {
    return progress != old.progress ||
        radius != old.radius ||
        levels != old.levels ||
        gridShape != old.gridShape ||
        startAngleDeg != old.startAngleDeg ||
        clockwise != old.clockwise ||
        labelMode != old.labelMode ||
        showInnerLabelBg != old.showInnerLabelBg ||
        outerLabelStyle != old.outerLabelStyle ||
        showScore != old.showScore ||
        badgeRadius != old.badgeRadius ||
        titlePadding != old.titlePadding ||
        titleMargin != old.titleMargin ||
        dimensions != old.dimensions ||
        series != old.series;
  }
}

class _LegendMeasure {
  final int index;
  final RadarSeries series;
  final TextPainter text;

  _LegendMeasure(this.index, this.series, this.text);
}

/// ========== 工具函数 ==========

// double _deg2rad(double deg) => deg / 180.0 * pi;
