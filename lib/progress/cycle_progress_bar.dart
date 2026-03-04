import 'package:flutter/material.dart';
import 'dart:math' as math;


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/26
/// create_time: 17:26
/// describe: 圆形进度条 / Circular Progress Bar
///
/// 支持完整圆形、半圆、反向等多种样式的进度条组件
/// Supports full circle, semi-circle, reversed and other styles
///
/// ## 功能特性 / Features
/// - 🎨 支持纯色和渐变色 / Solid and gradient colors
/// - 🔄 支持动画效果 / Animation support
/// - 📐 支持多种弧形类型 / Multiple arc types
/// - 🎯 支持自定义指示器 / Custom indicator widget
/// - 🔁 支持正向和反向 / Forward and reverse
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单圆形进度条
/// CycleProgressBar(
///   percent: 0.7,
///   radius: 50,
///   lineWidth: 10,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey,
/// )
///
/// // 带动画的进度条
/// CycleProgressBar(
///   percent: 0.8,
///   radius: 60,
///   animation: true,
///   animationDuration: 1000,
///   progressColor: Colors.green,
///   center: Text('80%'),
/// )
///
/// // 渐变色进度条
/// CycleProgressBar(
///   percent: 0.6,
///   radius: 50,
///   linearGradient: LinearGradient(
///     colors: [Colors.red, Colors.orange, Colors.yellow],
///   ),
/// )
///
/// // 半圆进度条
/// CycleProgressBar(
///   percent: 0.75,
///   radius: 80,
///   arcType: ArcType.half,
///   arcBackgroundColor: Colors.grey.shade200,
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - percent 必须在 0.0 到 1.0 之间 / Must be between 0.0 and 1.0
/// - 不能同时设置 linearGradient 和 progressColor / Cannot set both
/// - 使用 arcType 时必须设置 arcBackgroundColor / arcBackgroundColor required with arcType
///

/// 弧形类型 / Arc Type
/// - half: 半圆 / Semi-circle
/// - full: 完整圆 / Full circle
/// - fullReversed: 反向完整圆 / Reversed full circle
enum ArcType { half, full, fullReversed }

/// 圆形进度条端点样式 / Circular Stroke Cap Style
/// - butt: 平头 / Flat
/// - round: 圆头 / Round
/// - square: 方头 / Square
enum CircularStrokeCap { butt, round, square }

extension CircularStrokeCapExtension on CircularStrokeCap {
  StrokeCap get strokeCap {
    switch (this) {
      case CircularStrokeCap.butt:
        return StrokeCap.butt;
      case CircularStrokeCap.round:
        return StrokeCap.round;
      case CircularStrokeCap.square:
        return StrokeCap.square;
    }
  }
}

num radians(num deg) => deg * (math.pi / 180.0);

// ignore: must_be_immutable
class CycleProgressBar extends StatefulWidget {

  /// 进度百分比 / Progress percentage
  /// 取值范围: 0.0 ~ 1.0 / Range: 0.0 ~ 1.0
  /// 默认值: 0.0 / Default: 0.0
  final double percent;

  /// 圆形半径 / Circle radius
  /// 必填参数 / Required
  final double radius;

  /// 进度条宽度 / Progress bar width
  /// 默认值: 5.0 / Default: 5.0
  final double lineWidth;

  /// 背景条宽度 / Background bar width
  /// -1 表示使用 lineWidth / -1 means use lineWidth
  /// 默认值: -1 / Default: -1
  final double backgroundWidth;

  /// 填充颜色(外部容器) / Fill color (outer container)
  /// 默认值: Colors.transparent / Default: Colors.transparent
  final Color fillColor;

  /// 进度条边框颜色 / Progress border color
  /// 可选 / Optional
  final Color? progressBorderColor;

  /// 背景颜色 / Background color
  /// 默认值: Color(0xFFB8C7CB) / Default: Color(0xFFB8C7CB)
  final Color backgroundColor;

  /// 进度条颜色 / Progress color
  /// 注意: 不能与 linearGradient 同时使用 / Note: Cannot use with linearGradient
  Color get progressColor => _progressColor;
  late Color _progressColor;

  /// 是否启用动画 / Enable animation
  /// 默认值: false / Default: false
  final bool animation;

  /// 动画时长(毫秒) / Animation duration (milliseconds)
  /// 默认值: 500 / Default: 500
  final int animationDuration;

  /// 顶部组件 / Header widget
  final Widget? header;

  /// 底部组件 / Footer widget
  final Widget? footer;

  /// 中心组件 / Center widget
  final Widget? center;

  /// 线性渐变 / Linear gradient
  /// 注意: 不能与 progressColor 同时使用 / Note: Cannot use with progressColor
  final LinearGradient? linearGradient;

  /// 端点样式 / Stroke cap style
  /// 默认值: CircularStrokeCap.butt / Default: CircularStrokeCap.butt
  final CircularStrokeCap circularStrokeCap;

  /// 起始角度 / Start angle
  /// 默认值: 0.0 / Default: 0.0
  final double startAngle;

  /// 是否从上次进度开始动画 / Animate from last percent
  /// 默认值: false / Default: false
  final bool animateFromLastPercent;

  /// 是否保持状态 / Keep alive
  /// 默认值: true / Default: true
  final bool addAutomaticKeepAlive;

  /// 弧形类型 / Arc type
  /// 可选: half, full, fullReversed / Options: half, full, fullReversed
  final ArcType? arcType;

  /// 弧形背景颜色 / Arc background color
  /// 使用 arcType 时必填 / Required when using arcType
  final Color? arcBackgroundColor;

  /// 是否反向 / Reverse direction
  /// 默认值: false / Default: false
  final bool reverse;

  /// 遮罩滤镜 / Mask filter
  final MaskFilter? maskFilter;

  /// 动画曲线 / Animation curve
  /// 默认值: Curves.linear / Default: Curves.linear
  final Curve curve;

  /// 是否重复动画 / Restart animation
  /// 默认值: false / Default: false
  final bool restartAnimation;

  /// 动画结束回调 / Animation end callback
  final VoidCallback? onAnimationEnd;

  /// 指示器组件 / Indicator widget
  final Widget? widgetIndicator;

  /// 是否旋转渐变 / Rotate linear gradient
  /// 默认值: false / Default: false
  final bool rotateLinearGradient;

  CycleProgressBar({
    Key? key,
    this.percent = 0.0,
    this.lineWidth = 5.0,
    this.startAngle = 0.0,
    required this.radius,
    this.fillColor = Colors.transparent,
    this.backgroundColor = const Color(0xFFB8C7CB),
    Color? progressColor,
    this.backgroundWidth = -1,
    this.linearGradient,
    this.animation = false,
    this.animationDuration = 500,
    this.header,
    this.footer,
    this.center,
    this.addAutomaticKeepAlive = true,
    this.circularStrokeCap = CircularStrokeCap.butt,
    this.arcBackgroundColor,
    this.arcType,
    this.animateFromLastPercent = false,
    this.reverse = false,
    this.curve = Curves.linear,
    this.maskFilter,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
    this.rotateLinearGradient = false,
    this.progressBorderColor,
  }) : assert(percent >= 0.0 && percent <= 1.0, 'percent must be between 0.0 and 1.0'),
       assert(radius > 0, 'radius must be greater than 0'),
       assert(lineWidth > 0, 'lineWidth must be greater than 0'),
       assert(startAngle >= 0.0, 'startAngle must be non-negative'),
       assert(animationDuration > 0, 'animationDuration must be greater than 0'),
       assert(linearGradient == null || progressColor == null, 
              'Cannot set both linearGradient and progressColor'),
       assert(arcType != null || arcBackgroundColor == null,
              'arcBackgroundColor requires arcType to be set'),
       super(key: key) {
    _progressColor = progressColor ?? Colors.red;
  }

  @override
  _CycleProgressBarState createState() =>
      _CycleProgressBarState();
}

class _CycleProgressBarState extends State<CycleProgressBar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation? _animation;
  double _percent = 0.0;
  double _diameter = 0.0;

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (widget.animation) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration),
      );
      _animation = Tween(begin: 0.0, end: widget.percent).animate(
        CurvedAnimation(parent: _animationController!, curve: widget.curve),
      )..addListener(() {
        setState(() {
          _percent = _animation!.value;
        });
        if (widget.restartAnimation && _percent == 1.0) {
          _animationController!.repeat(min: 0, max: 1.0);
        }
      });
      _animationController!.addStatusListener((status) {
        if (widget.onAnimationEnd != null &&
            status == AnimationStatus.completed) {
          widget.onAnimationEnd!();
        }
      });
      _animationController!.forward();
    } else {
      _updateProgress();
    }
    _diameter = widget.radius * 2;
    super.initState();
  }

  void _checkIfNeedCancelAnimation(CycleProgressBar oldWidget) {
    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  @override
  void didUpdateWidget(CycleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent ||
        oldWidget.startAngle != widget.startAngle) {
      if (_animationController != null) {
        _animationController!.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween(
          begin: widget.animateFromLastPercent ? oldWidget.percent : 0.0,
          end: widget.percent,
        ).animate(
          CurvedAnimation(parent: _animationController!, curve: widget.curve),
        );
        _animationController!.forward(from: 0.0);
      } else {
        _updateProgress();
      }
    }
    _checkIfNeedCancelAnimation(oldWidget);
  }

  _updateProgress() {
    setState(() => _percent = widget.percent);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var items = List<Widget>.empty(growable: true);
    if (widget.header != null) {
      items.add(widget.header!);
    }
    items.add(
      SizedBox(
        height: _diameter,
        width: _diameter,
        child: Stack(
          children: [
            CustomPaint(
              painter: _CirclePainter(
                progress: _percent * 360,
                progressColor: widget.progressColor,
                progressBorderColor: widget.progressBorderColor,
                backgroundColor: widget.backgroundColor,
                startAngle: widget.startAngle,
                circularStrokeCap: widget.circularStrokeCap,
                radius: widget.radius - widget.lineWidth / 2,
                lineWidth: widget.lineWidth,
                //negative values ignored, replaced with lineWidth
                backgroundWidth: widget.backgroundWidth >= 0.0
                    ? (widget.backgroundWidth)
                    : widget.lineWidth,
                arcBackgroundColor: widget.arcBackgroundColor,
                arcType: widget.arcType,
                reverse: widget.reverse,
                linearGradient: widget.linearGradient,
                maskFilter: widget.maskFilter,
                rotateLinearGradient: widget.rotateLinearGradient,
              ),
              child: (widget.center != null)
                  ? Center(child: widget.center)
                  : const SizedBox.expand(),
            ),
            if (widget.widgetIndicator != null && widget.animation)
              Positioned.fill(
                child: Transform.rotate(
                  angle: radians(
                      (widget.circularStrokeCap != CircularStrokeCap.butt &&
                          widget.reverse)
                          ? -15
                          : 0)
                      .toDouble(),
                  child: Transform.rotate(
                    angle: getCurrentPercent(_percent),
                    child: Transform.translate(
                      offset: Offset(
                        (widget.circularStrokeCap != CircularStrokeCap.butt)
                            ? widget.lineWidth / 2
                            : 0,
                        (-widget.radius + widget.lineWidth / 2),
                      ),
                      child: widget.widgetIndicator,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.footer != null) {
      items.add(widget.footer!);
    }

    return Material(
      color: widget.fillColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  double getCurrentPercent(double percent) {
    if (widget.arcType != null) {
      final angle = _getStartAngleFixedMargin(widget.arcType!).fixedStartAngle;
      final fixedPercent =
      widget.percent > 0 ? 1.0 / widget.percent * _percent : 0;
      late double margin;
      if (widget.arcType == ArcType.half) {
        margin = 180 * widget.percent;
      } else {
        margin = 280 * widget.percent;
      }
      return radians(angle + margin * fixedPercent).toDouble();
    } else {
      const angle = 360;
      return radians((widget.reverse ? -angle : angle) * _percent).toDouble();
    }
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

_ArcAngles _getStartAngleFixedMargin(ArcType arcType) {
  double fixedStartAngle, startAngleFixedMargin;
  if (arcType == ArcType.fullReversed) {
    fixedStartAngle = 399;
    startAngleFixedMargin = 312 / fixedStartAngle;
  } else if (arcType == ArcType.full) {
    fixedStartAngle = 220;
    startAngleFixedMargin = 172 / fixedStartAngle;
  } else {
    fixedStartAngle = 270;
    startAngleFixedMargin = 135 / fixedStartAngle;
  }
  return _ArcAngles(
    fixedStartAngle: fixedStartAngle,
    startAngleFixedMargin: startAngleFixedMargin,
  );
}

class _ArcAngles {
  const _ArcAngles(
      {required this.fixedStartAngle, required this.startAngleFixedMargin});
  final double fixedStartAngle;
  final double startAngleFixedMargin;
}

class _CirclePainter extends CustomPainter {
  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final Paint _paintLineBorder = Paint();
  final Paint _paintBackgroundStartAngle = Paint();
  final double lineWidth;
  final double backgroundWidth;
  final double progress;
  final double radius;
  final Color progressColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final CircularStrokeCap circularStrokeCap;
  final double startAngle;
  final LinearGradient? linearGradient;
  final Color? arcBackgroundColor;
  final ArcType? arcType;
  final bool reverse;
  final MaskFilter? maskFilter;
  final bool rotateLinearGradient;

  _CirclePainter({
    required this.lineWidth,
    required this.backgroundWidth,
    required this.progress,
    required this.radius,
    required this.progressColor,
    required this.backgroundColor,
    this.progressBorderColor,
    this.startAngle = 0.0,
    this.circularStrokeCap = CircularStrokeCap.butt,
    this.linearGradient,
    required this.reverse,
    this.arcBackgroundColor,
    this.arcType,
    this.maskFilter,
    required this.rotateLinearGradient,
  }) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = backgroundWidth;
    _paintBackground.strokeCap = circularStrokeCap.strokeCap;

    if (arcBackgroundColor != null) {
      _paintBackgroundStartAngle.color = arcBackgroundColor!;
      _paintBackgroundStartAngle.style = PaintingStyle.stroke;
      _paintBackgroundStartAngle.strokeWidth = lineWidth;
      _paintBackgroundStartAngle.strokeCap = circularStrokeCap.strokeCap;
    }

    _paintLine.color = progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth =
    progressBorderColor != null ? lineWidth - 2 : lineWidth;
    _paintLine.strokeCap = circularStrokeCap.strokeCap;

    if (progressBorderColor != null) {
      _paintLineBorder.color = progressBorderColor!;
      _paintLineBorder.style = PaintingStyle.stroke;
      _paintLineBorder.strokeWidth = lineWidth;
      _paintLineBorder.strokeCap = circularStrokeCap.strokeCap;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double fixedStartAngle = startAngle;
    double startAngleFixedMargin = 1.0;
    if (arcType != null) {
      final arcAngles = _getStartAngleFixedMargin(arcType!);
      fixedStartAngle = arcAngles.fixedStartAngle;
      startAngleFixedMargin = arcAngles.startAngleFixedMargin;
    }
    if (arcType == null) {
      canvas.drawCircle(center, radius, _paintBackground);
    }

    if (maskFilter != null) {
      _paintLineBorder.maskFilter = _paintLine.maskFilter = maskFilter;
    }
    if (linearGradient != null) {
      if (rotateLinearGradient && progress > 0) {
        double correction = 0;
        if (_paintLine.strokeCap != StrokeCap.butt) {
          correction = math.atan(_paintLine.strokeWidth / 2 / radius);
        }
        _paintLineBorder.shader = _paintLine.shader = SweepGradient(
          transform: reverse
              ? GradientRotation(
              radians(-90 - progress + startAngle) - correction)
              : GradientRotation(radians(-90.0 + startAngle) - correction),
          startAngle: radians(0).toDouble(),
          endAngle: radians(progress).toDouble(),
          tileMode: TileMode.clamp,
          colors: reverse
              ? linearGradient!.colors.reversed.toList()
              : linearGradient!.colors,
        ).createShader(
          Rect.fromCircle(center: center, radius: radius),
        );
      } else if (!rotateLinearGradient) {
        _paintLineBorder.shader =
            _paintLine.shader = linearGradient!.createShader(
          Rect.fromCircle(center: center, radius: radius),
        );
      }
    }

    if (arcBackgroundColor != null) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        radians(-90.0 + fixedStartAngle).toDouble(),
        radians(360 * startAngleFixedMargin).toDouble(),
        false,
        _paintBackgroundStartAngle,
      );
    }

    if (reverse) {
      final start =
      radians(360 * startAngleFixedMargin - 90.0 + fixedStartAngle)
          .toDouble();
      final end = radians(-progress * startAngleFixedMargin).toDouble();
      if (progressBorderColor != null) {
        canvas.drawArc(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
          start,
          end,
          false,
          _paintLineBorder,
        );
      }
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        end,
        false,
        _paintLine,
      );
    } else {
      final start = radians(-90.0 + fixedStartAngle).toDouble();
      final end = radians(progress * startAngleFixedMargin).toDouble();
      if (progressBorderColor != null) {
        canvas.drawArc(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
          start,
          end,
          false,
          _paintLineBorder,
        );
      }
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        end,
        false,
        _paintLine,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}