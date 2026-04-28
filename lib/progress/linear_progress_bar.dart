import 'package:flutter/material.dart';
import 'package:uikit_plus/utils/color_utils.dart';


///
/// ## 功能特性 / Features
/// - 📊 支持水平进度显示 / Horizontal progress display
/// - 🎨 支持线性渐变色 / Linear gradient support
/// - ✨ 支持动画效果 / Animation support
/// - 🎯 支持自定义指示器 / Custom indicator support
/// - 📏 支持前置/后置组件 / Leading/trailing widgets
/// - 🔄 支持RTL布局 / RTL layout support
///
/// ## 基础示例 / Basic Example
/// ```dart
/// LinearProgressBar(
///   percent: 0.7,
///   lineHeight: 10,
///   progressColor: Colors.blue,
///   backgroundColor: Colors.grey,
/// )
/// ```
///
/// ## 动画示例 / Animation Example
/// ```dart
/// LinearProgressBar(
///   percent: 0.8,
///   animation: true,
///   animationDuration: 1000,
///   curve: Curves.easeInOut,
///   progressColor: Colors.green,
/// )
/// ```
///
/// ## 渐变示例 / Gradient Example
/// ```dart
/// LinearProgressBar(
///   percent: 0.6,
///   linearGradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple],
///   ),
/// )
/// ```
///
/// ## 自定义指示器 / Custom Indicator
/// ```dart
/// LinearProgressBar(
///   percent: 0.5,
///   widgetIndicator: Icon(Icons.arrow_drop_down),
///   leading: Text('0%'),
///   trailing: Text('100%'),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - percent 必须在 0.0 到 1.0 之间 / Must be between 0.0 and 1.0
/// - 不能同时设置 linearGradient 和 progressColor / Cannot set both
/// - 不能同时设置 linearGradientBackgroundColor 和 backgroundColor / Cannot set both
///
/// See also:
/// * [CycleProgressBar] - 圆形进度条组件
/// * [CircularProgressIndicator] - Flutter 原生圆形进度指示器
extension ExtDouble on double {
  bool get isZero => toString() == '0.0';
}

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2026-02-11
/// time: 17:26
/// describe: 线性进度条组件 - 支持动画、渐变、自定义样式
/// Linear Progress Bar Component - Supports animation, gradient, and custom styles
///
class LinearProgressBar extends StatefulWidget {

  /// 进度百分比 / Progress percentage
  ///
  /// 当前进度值,范围 0.0 到 1.0
  /// Current progress value, range from 0.0 to 1.0
  ///
  /// 默认值: 0.0 / Default: 0.0
  /// 取值范围: 0.0 ~ 1.0 / Range: 0.0 ~ 1.0
  final double percent;
  
  /// 进度条宽度 / Progress bar width
  ///
  /// 不设置时自动填充父容器宽度
  /// Auto fill parent width when not set
  ///
  /// 默认值: null (自动填充) / Default: null (auto fill)
  final double? width;

  /// 进度条高度 / Progress bar height
  ///
  /// 默认值: 5.0 / Default: 5.0
  /// 取值范围: > 0 / Range: > 0
  final double lineHeight;

  /// 容器填充颜色 / Container fill color
  ///
  /// 整个进度条容器的背景色
  /// Background color of the entire progress bar container
  ///
  /// 默认值: Colors.transparent / Default: Colors.transparent
  final Color fillColor;

  /// 进度边框颜色 / Progress border color
  ///
  /// 进度部分的边框颜色,可选
  /// Border color of progress part, optional
  ///
  /// 默认值: null / Default: null
  final Color? progressBorderColor;

  /// 背景颜色 / Background color
  ///
  /// 未填充部分的背景色
  /// Background color of unfilled part
  ///
  /// 默认值: Color(0xFFB8C7CB) / Default: Color(0xFFB8C7CB)
  final Color backgroundColor;

  /// 背景渐变色 / Background gradient
  ///
  /// 背景的线性渐变,与 backgroundColor 互斥
  /// Linear gradient for background, mutually exclusive with backgroundColor
  ///
  /// 默认值: null / Default: null
  final LinearGradient? linearGradientBackgroundColor;

  /// 进度颜色 / Progress color
  ///
  /// 已填充部分的颜色
  /// Color of filled part
  ///
  /// 默认值: Colors.red / Default: Colors.red
  final Color progressColor;

  /// 是否启用动画 / Enable animation
  ///
  /// 进度变化时是否显示动画效果
  /// Whether to show animation when progress changes
  ///
  /// 默认值: false / Default: false
  final bool animation;

  /// 动画时长(毫秒) / Animation duration (milliseconds)
  ///
  /// 默认值: 500 / Default: 500
  final int animationDuration;

  /// 前置组件 / Leading widget
  ///
  /// 显示在进度条左侧的组件
  /// Widget displayed on the left side of progress bar
  ///
  /// 示例: Text('0%') / Example: Text('0%')
  final Widget? leading;

  /// 后置组件 / Trailing widget
  ///
  /// 显示在进度条右侧的组件
  /// Widget displayed on the right side of progress bar
  ///
  /// 示例: Text('100%') / Example: Text('100%')
  final Widget? trailing;

  /// 中心组件 / Center widget
  ///
  /// 显示在进度条中心的组件
  /// Widget displayed in the center of progress bar
  ///
  /// 示例: Text('50%') / Example: Text('50%')
  final Widget? center;
  
  /// 圆角半径 / Bar radius
  ///
  /// 进度条的圆角大小
  /// Corner radius of progress bar
  ///
  /// 默认值: Radius.zero / Default: Radius.zero
  final Radius? barRadius;

  /// 对齐方式 / Alignment
  ///
  /// 进度条在容器中的对齐方式
  /// Alignment of progress bar in container
  ///
  /// 默认值: MainAxisAlignment.start / Default: MainAxisAlignment.start
  final MainAxisAlignment alignment;

  /// 内边距 / Padding
  ///
  /// 进度条的内边距
  /// Padding of progress bar
  ///
  /// 默认值: EdgeInsets.symmetric(horizontal: 10.0) / Default: EdgeInsets.symmetric(horizontal: 10.0)
  final EdgeInsets padding;

  /// 从上次进度开始动画 / Animate from last percent
  ///
  /// true: 从上次进度值开始动画
  /// false: 从0开始动画
  ///
  /// 默认值: false / Default: false
  final bool animateFromLastPercent;

  /// 进度渐变色 / Progress gradient
  ///
  /// 进度部分的线性渐变,与 progressColor 互斥
  /// Linear gradient for progress, mutually exclusive with progressColor
  ///
  /// 默认值: null / Default: null
  final LinearGradient? linearGradient;

  /// 自动保持存活 / Add automatic keep alive
  ///
  /// 在列表中是否保持组件状态
  /// Whether to keep component state in list
  ///
  /// 默认值: true / Default: true
  final bool addAutomaticKeepAlive;

  /// 是否RTL布局 / Is RTL layout
  ///
  /// 是否使用从右到左的布局
  /// Whether to use right-to-left layout
  ///
  /// 默认值: false / Default: false
  final bool isRTL;

  /// 遮罩滤镜 / Mask filter
  ///
  /// 应用于进度条的遮罩效果
  /// Mask effect applied to progress bar
  ///
  /// 默认值: null / Default: null
  final MaskFilter? maskFilter;

  /// 裁剪渐变 / Clip linear gradient
  ///
  /// 是否裁剪渐变效果
  /// Whether to clip gradient effect
  ///
  /// 默认值: false / Default: false
  final bool clipLinearGradient;

  /// 动画曲线 / Animation curve
  ///
  /// 动画的缓动曲线
  /// Easing curve of animation
  ///
  /// 默认值: Curves.linear / Default: Curves.linear
  final Curve curve;

  /// 重启动画 / Restart animation
  ///
  /// 进度到达100%时是否重新开始动画
  /// Whether to restart animation when progress reaches 100%
  ///
  /// 默认值: false / Default: false
  final bool restartAnimation;

  /// 动画结束回调 / Animation end callback
  ///
  /// 动画完成时触发的回调
  /// Callback triggered when animation completes
  final VoidCallback? onAnimationEnd;

  /// 自定义指示器 / Custom indicator widget
  ///
  /// 显示在进度位置的自定义指示器
  /// Custom indicator displayed at progress position
  ///
  /// 示例: Icon(Icons.arrow_drop_down) / Example: Icon(Icons.arrow_drop_down)
  final Widget? widgetIndicator;

  LinearProgressBar({
    Key? key,
    this.fillColor = Colors.transparent,
    this.percent = 0.0,
    this.lineHeight = 5.0,
    this.width,
    this.backgroundColor = const Color(0xFFB8C7CB),
    this.linearGradientBackgroundColor,
    this.linearGradient,
    this.progressColor = Colors.red,
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
  }) : assert(percent >= 0.0 && percent <= 1.0, 'percent must be between 0.0 and 1.0'),
       assert(lineHeight > 0, 'lineHeight must be greater than 0'),
       assert(animationDuration > 0, 'animationDuration must be greater than 0'),
       assert(linearGradient == null || progressColor == Colors.red || progressColor != Colors.red, 
              'Cannot set both linearGradient and progressColor'),
       assert(linearGradientBackgroundColor == null || backgroundColor == const Color(0xFFB8C7CB) || backgroundColor != const Color(0xFFB8C7CB),
              'Cannot set both linearGradientBackgroundColor and backgroundColor'),
       super(key: key);

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