import 'package:flutter/material.dart';
import 'package:uikit_plus/utils/color_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/29
/// create_time: 18:10
/// describe: 线性进度条
///
extension ExtDouble on double {
  bool get isZero => toString() == '0.0';
}

// ignore: must_be_immutable
class LinearProgressBar extends StatefulWidget {

  ///百分比进度 0-1
  final double percent;
  final double? width;

  ///高度
  final double lineHeight;

  ///填充颜色
  final Color fillColor;

  ///边框颜色 进度
  final Color? progressBorderColor;

  ///背景色
  Color get backgroundColor => _backgroundColor;
  late Color _backgroundColor;

  ///线性渐变
  final LinearGradient? linearGradientBackgroundColor;

  Color get progressColor => _progressColor;

  late Color _progressColor;

  ///是否开启动画
  final bool animation;

  ///动画时长 milliseconds
  final int animationDuration;

  final Widget? leading;

  final Widget? trailing;

  final Widget? center;
  final Radius? barRadius;

  final MainAxisAlignment alignment;

  final EdgeInsets padding;

  final bool animateFromLastPercent;

  final LinearGradient? linearGradient;

  final bool addAutomaticKeepAlive;

  final bool isRTL;

  final MaskFilter? maskFilter;

  final bool clipLinearGradient;

  final Curve curve;

  final bool restartAnimation;

  final VoidCallback? onAnimationEnd;

  final Widget? widgetIndicator;

  LinearProgressBar({
    Key? key,
    this.fillColor = Colors.transparent,
    this.percent = 0.0,
    this.lineHeight = 5.0,
    this.width,
    Color? backgroundColor,
    this.linearGradientBackgroundColor,
    this.linearGradient,
    Color? progressColor,
    this.animation = false,
    this.animationDuration = 500,
    this.animateFromLastPercent = false,
    this.isRTL = false,
    this.leading,
    this.trailing,
    this.center,
    this.addAutomaticKeepAlive = true,
    this.barRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.alignment = MainAxisAlignment.start,
    this.maskFilter,
    this.clipLinearGradient = false,
    this.curve = Curves.linear,
    this.restartAnimation = false,
    this.onAnimationEnd,
    this.widgetIndicator,
    this.progressBorderColor,
  }) : super(key: key) {
    if (linearGradient != null && progressColor != null) {
      throw ArgumentError(
          '不能同时设置 linearGradient 和 progressColor 属置');
    }
    _progressColor = progressColor ?? Colors.red;

    if (linearGradientBackgroundColor != null && backgroundColor != null) {
      throw ArgumentError(
          '不能同时设置 linearGradientBackgroundColor 和 backgroundColor 属时');
    }
    _backgroundColor = backgroundColor ?? const Color(0xFFB8C7CB);

    if (percent < 0.0 || percent > 1.0) {
      throw Exception(
          "百分百值需在 0.0 和 1.0 之间");
    }
  }

  @override
  _LinearProgressBarState createState() => _LinearProgressBarState();
}

class _LinearProgressBarState extends State<LinearProgressBar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _animationController;
  Animation? _animation;
  double _percent = 0.0;
  final _containerKey = GlobalKey();
  final _keyIndicator = GlobalKey();
  double _containerWidth = 0.0;
  double _containerHeight = 0.0;
  double _indicatorWidth = 0.0;
  double _indicatorHeight = 0.0;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _containerWidth = _containerKey.currentContext?.size?.width ?? 0.0;
          _containerHeight = _containerKey.currentContext?.size?.height ?? 0.0;
          if (_keyIndicator.currentContext != null) {
            _indicatorWidth = _keyIndicator.currentContext?.size?.width ?? 0.0;
            _indicatorHeight =
                _keyIndicator.currentContext?.size?.height ?? 0.0;
          }
        });
      }
    });
    if (widget.animation) {
      _animationController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.animationDuration));
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
    super.initState();
  }

  void _checkIfNeedCancelAnimation(LinearProgressBar oldWidget) {
    if (oldWidget.animation &&
        !widget.animation &&
        _animationController != null) {
      _animationController!.stop();
    }
  }

  @override
  void didUpdateWidget(LinearProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      if (_animationController != null) {
        _animationController!.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween(
            begin: widget.animateFromLastPercent ? oldWidget.percent : 0.0,
            end: widget.percent)
            .animate(
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
    setState(() {
      _percent = widget.percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var items = List<Widget>.empty(growable: true);
    if (widget.leading != null) {
      items.add(widget.leading!);
    }
    final hasSetWidth = widget.width != null;
    final percentPositionedHorizontal =
        _containerWidth * _percent - _indicatorWidth / 3;
    //LayoutBuilder is used to get the size of the container where the widget is rendered
    var containerWidget = LayoutBuilder(
        builder: (context, constraints) {
          _containerWidth = constraints.maxWidth;
          _containerHeight = constraints.maxHeight;
          return Container(
            width: hasSetWidth ? widget.width : double.infinity,
            height: widget.lineHeight,
            padding: widget.padding,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  key: _containerKey,
                  painter: _LinearPainter(
                    isRTL: widget.isRTL,
                    progress: _percent,
                    progressColor: widget.progressColor,
                    linearGradient: widget.linearGradient,
                    backgroundColor: widget.backgroundColor,
                    progressBorderColor: widget.progressBorderColor,
                    barRadius: widget.barRadius ?? Radius.zero,
                    linearGradientBackgroundColor: widget.linearGradientBackgroundColor,
                    maskFilter: widget.maskFilter,
                    clipLinearGradient: widget.clipLinearGradient,
                  ),
                  child: (widget.center != null)
                      ? Center(child: widget.center)
                      : Container(),
                ),
                if (widget.widgetIndicator != null && _indicatorWidth == 0)
                  Opacity(
                    opacity: 0.0,
                    key: _keyIndicator,
                    child: widget.widgetIndicator,
                  ),
                if (widget.widgetIndicator != null &&
                    _containerWidth > 0 &&
                    _indicatorWidth > 0)
                  Positioned(
                    right: widget.isRTL ? percentPositionedHorizontal : null,
                    left: !widget.isRTL ? percentPositionedHorizontal : null,
                    top: _containerHeight / 2 - _indicatorHeight,
                    child: widget.widgetIndicator!,
                  ),
              ],
            ),
          );
        }
    );

    if (hasSetWidth) {
      items.add(containerWidget);
    } else {
      items.add(Expanded(
        child: containerWidget,
      ));
    }
    if (widget.trailing != null) {
      items.add(widget.trailing!);
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        color: widget.fillColor,
        child: Row(
          mainAxisAlignment: widget.alignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

class _LinearPainter extends CustomPainter {
  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final Paint _paintLineBorder = Paint();
  final double progress;
  final bool isRTL;
  final Color progressColor;
  final Color? progressBorderColor;
  final Color backgroundColor;
  final Radius barRadius;
  final LinearGradient? linearGradient;
  final LinearGradient? linearGradientBackgroundColor;
  final MaskFilter? maskFilter;
  final bool clipLinearGradient;

  _LinearPainter({
    required this.progress,
    required this.isRTL,
    required this.progressColor,
    required this.backgroundColor,
    required this.barRadius,
    required this.progressBorderColor,
    this.linearGradient,
    this.maskFilter,
    required this.clipLinearGradient,
    this.linearGradientBackgroundColor,
  }) {
    _paintBackground.color = backgroundColor;

    _paintLine.color =
    progress == 0 ? progressColor.setAlpha(0.0) : progressColor;

    if (progressBorderColor != null) {
      _paintLineBorder.color = progress == 0
          ? progressBorderColor!.setAlpha(0.0)
          : progressBorderColor!;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path backgroundPath = Path();
    backgroundPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), barRadius));
    canvas.drawPath(backgroundPath, _paintBackground);
    canvas.clipPath(backgroundPath);

    if (maskFilter != null) {
      _paintLineBorder.maskFilter = maskFilter;
      _paintLine.maskFilter = maskFilter;
    }

    if (linearGradientBackgroundColor != null) {
      Offset shaderEndPoint =
      clipLinearGradient ? Offset.zero : Offset(size.width, size.height);
      _paintBackground.shader = linearGradientBackgroundColor
          ?.createShader(Rect.fromPoints(Offset.zero, shaderEndPoint));
    }
    final xProgress = size.width * progress;
    Path linePath = Path();
    Path linePathBorder = Path();
    double factor = progressBorderColor != null ? 2 : 0;
    double correction = factor * 2; //Left and right or top an down
    if (isRTL) {
      if (linearGradient != null) {
        _paintLineBorder.shader =
            _createGradientShaderRightToLeft(size, xProgress);
        _paintLine.shader = _createGradientShaderRightToLeft(size, xProgress);
      }
      linePath.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(
              size.width - size.width * progress, 0, xProgress, size.height),
          barRadius));
    } else {
      if (linearGradient != null) {
        _paintLineBorder.shader =
            _createGradientShaderLeftToRight(size, xProgress);
        _paintLine.shader = _createGradientShaderLeftToRight(size, xProgress);
      }
      if (progressBorderColor != null) {
        linePathBorder.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, xProgress, size.height), barRadius));
      }
      linePath.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(
              factor, factor, xProgress - correction, size.height - correction),
          barRadius));
    }
    if (progressBorderColor != null) {
      canvas.drawPath(linePathBorder, _paintLineBorder);
    }
    canvas.drawPath(linePath, _paintLine);
  }

  Shader _createGradientShaderRightToLeft(Size size, double xProgress) {
    Offset shaderEndPoint =
    clipLinearGradient ? Offset.zero : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset(size.width, size.height),
        shaderEndPoint,
      ),
    );
  }

  Shader _createGradientShaderLeftToRight(Size size, double xProgress) {
    Offset shaderEndPoint = clipLinearGradient
        ? Offset(size.width, size.height)
        : Offset(xProgress, size.height);
    return linearGradient!.createShader(
      Rect.fromPoints(
        Offset.zero,
        shaderEndPoint,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}