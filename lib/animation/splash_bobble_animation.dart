
import 'package:flutter/material.dart';

/// author:郑再红
/// email:1096877329@qq.com
/// date:2026-04-28
/// describe: 开屏动画效果 - 气泡动画
///
/// ## 功能特性 / Features
/// - 🎨 支持自定义气泡颜色 / Custom bubble colors
/// - 📏 支持自定义尺寸和轨迹 / Custom size and trajectory
/// - ⚡ 支持透明度和缩放动画 / Opacity and scale animation
/// - 🎯 支持自定义气泡数量和位置 / Custom bubble count and positions
/// - 🔄 支持动画状态监听 / Animation status listener
/// - 🎭 支持自定义绘制器 / Custom painter support
///
/// ## 基础示例 / Basic Example
/// ```dart
/// SplashBobbleAnimation(
///   width: MediaQuery.of(context).size.width,
///   height: MediaQuery.of(context).size.height,
///   duration: Duration(milliseconds: 2000),
/// )
/// ```
///
/// ## 自定义颜色示例 / Custom Colors Example
/// ```dart
/// SplashBobbleAnimation(
///   bubbleColors: [
///     Colors.red,
///     Colors.blue,
///     Colors.green,
///     Colors.orange,
///   ],
/// )
/// ```
///
/// ## 自定义气泡配置 / Custom Bubble Configuration
/// ```dart
/// SplashBobbleAnimation(
///   bubbles: [
///     BubbleConfig(
///       color: Colors.red,
///       startAngle: 0,
///       radius: 15,
///     ),
///     BubbleConfig(
///       color: Colors.blue,
///       startAngle: 90,
///       radius: 20,
///     ),
///   ],
/// )
/// ```
//class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SplashBobbleAnimation(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         duration: Duration(milliseconds: 2500),
//         bubbleColors: [
//           Colors.blue,
//           Colors.purple,
//           Colors.pink,
//           Colors.orange,
//         ],
//         animationStatusListener: (status) {
//           if (status == AnimationStatus.completed) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
class SplashBobbleAnimation extends StatefulWidget {

  /// 动画容器高度 / Animation container height
  final double? height;
  
  /// 动画容器宽度 / Animation container width
  final double? width;
  
  /// 小球的运动轨迹弧度 / Bubble motion curve radius
  final double motionCurveRadius;

  /// 动画时长 / Animation duration
  final Duration? duration;
  
  /// 动画状态监听器 / Animation status listener
  final AnimationStatusListener? animationStatusListener;
  
  /// 是否启用透明度动画 / Enable opacity animation
  final bool? enableOpacity;
  
  /// 是否启用缩放动画 / Enable scale animation
  final bool? enableScale;
  
  /// 气泡半径 / Bubble radius
  final double? bobbleRadius;
  
  /// 背景颜色 / Background color
  final Color? backgroundColor;
  
  /// 气泡颜色列表（按上、右、下、左顺序）/ Bubble colors (top, right, bottom, left order)
  /// 
  /// 如果提供少于4个颜色，将使用默认颜色填充
  /// If less than 4 colors provided, will use default colors to fill
  final List<Color>? bubbleColors;
  
  /// 自定义气泡配置列表 / Custom bubble configurations
  /// 
  /// 如果提供此参数，将覆盖 bubbleColors 和默认配置
  /// If provided, will override bubbleColors and default configuration
  final List<BubbleConfig>? bubbles;
  
  /// 缩放因子 / Scale factor
  /// 
  /// 控制气泡在动画过程中的缩放程度
  /// Controls the scale degree of bubbles during animation
  final double scaleFactor;
  
  /// 动画曲线 / Animation curve
  final Curve curve;

  const SplashBobbleAnimation({
    this.height = 1920,
    this.width = 1080,
    this.motionCurveRadius = 100,
    this.duration = const Duration(milliseconds: 3000),
    this.animationStatusListener,
    this.enableOpacity = true,
    this.enableScale = true,
    this.bobbleRadius = 10,
    this.backgroundColor = Colors.white,
    this.bubbleColors,
    this.bubbles,
    this.scaleFactor = 5.0,
    this.curve = Curves.easeInOut,
    Key? key}) : super(key: key);

  @override
  State<SplashBobbleAnimation> createState() => _LauncherViewState();
}

class _LauncherViewState extends State<SplashBobbleAnimation> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late final Animation<double> _animation;

  /// 运动到路径上百分比 / Motion progress percentage
  final ValueNotifier<double> _fractionNotifier = ValueNotifier(0);

  /// 气泡路径列表 / Bubble paths list
  late List<Path> _bubblePaths;
  
  /// 气泡配置列表 / Bubble configurations list
  late List<BubbleConfig> _bubbleConfigs;
  
  late double mHeight;
  late double mWidth;

  /// 小球的运动轨迹弧度 / Bubble motion curve radius
  late double motionCurveRadius;

  @override
  void initState() {
    super.initState();

    mHeight = widget.height!;
    mWidth = widget.width!;
    motionCurveRadius = widget.motionCurveRadius;

    // 初始化气泡配置
    _initBubbleConfigs();
    
    // 初始化气泡路径
    _initBubblePaths();

    _animationController = AnimationController(vsync: this, duration: widget.duration!);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: widget.curve),
    )..addListener(() {
         if(mounted && _animationController.status != AnimationStatus.completed)  {
           _fractionNotifier.value = _animation.value;
         }
      });
    if(widget.animationStatusListener!=null){
      _animation.addStatusListener(widget.animationStatusListener!);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }
  
  /// 初始化气泡配置 / Initialize bubble configurations
  void _initBubbleConfigs() {
    if (widget.bubbles != null && widget.bubbles!.isNotEmpty) {
      // 使用自定义气泡配置
      _bubbleConfigs = widget.bubbles!;
    } else {
      // 使用默认配置或自定义颜色
      final defaultColors = [
        Colors.red,
        Colors.purple,
        Colors.yellow,
        Colors.blueAccent,
      ];
      
      final colors = widget.bubbleColors ?? defaultColors;
      
      // 确保至少有4个颜色
      final bubbleColors = List<Color>.from(colors);
      while (bubbleColors.length < 4) {
        bubbleColors.add(defaultColors[bubbleColors.length % defaultColors.length]);
      }
      
      // 创建默认的4个气泡配置（上、右、下、左）
      _bubbleConfigs = [
        BubbleConfig(
          color: bubbleColors[0],
          startAngle: 0,  // 上
          radius: widget.bobbleRadius,
        ),
        BubbleConfig(
          color: bubbleColors[1],
          startAngle: 90,  // 右
          radius: widget.bobbleRadius,
        ),
        BubbleConfig(
          color: bubbleColors[2],
          startAngle: 180,  // 下
          radius: widget.bobbleRadius,
        ),
        BubbleConfig(
          color: bubbleColors[3],
          startAngle: 270,  // 左
          radius: widget.bobbleRadius,
        ),
      ];
    }
  }
  
  /// 初始化气泡路径 / Initialize bubble paths
  void _initBubblePaths() {
    _bubblePaths = [];
    
    for (var config in _bubbleConfigs) {
      final path = Path();
      final angle = config.startAngle * 3.14159 / 180; // 转换为弧度
      
      // 计算起始和结束位置
      final centerX = mWidth / 2;
      final centerY = mHeight / 2;
      
      // 根据角度计算控制点和终点
      final controlX = centerX + motionCurveRadius * (config.startAngle == 90 || config.startAngle == 270 ? 1 : 0) * (config.startAngle == 270 ? -1 : 1);
      final controlY = centerY + motionCurveRadius * (config.startAngle == 0 || config.startAngle == 180 ? 1 : 0) * (config.startAngle == 0 ? -1 : 1);
      
      path.moveTo(centerX, centerY);
      
      // 根据角度创建不同的贝塞尔曲线
      if (config.startAngle == 0) {
        // 上
        path.quadraticBezierTo(centerX - motionCurveRadius, centerY - motionCurveRadius, centerX, centerY - motionCurveRadius);
        path.quadraticBezierTo(centerX + motionCurveRadius, centerY - motionCurveRadius, centerX, centerY);
      } else if (config.startAngle == 90) {
        // 右
        path.quadraticBezierTo(centerX + motionCurveRadius, centerY - motionCurveRadius, centerX + motionCurveRadius, centerY);
        path.quadraticBezierTo(centerX + motionCurveRadius, centerY + motionCurveRadius, centerX, centerY);
      } else if (config.startAngle == 180) {
        // 下
        path.quadraticBezierTo(centerX + motionCurveRadius, centerY + motionCurveRadius, centerX, centerY + motionCurveRadius);
        path.quadraticBezierTo(centerX - motionCurveRadius, centerY + motionCurveRadius, centerX, centerY);
      } else if (config.startAngle == 270) {
        // 左
        path.quadraticBezierTo(centerX - motionCurveRadius, centerY + motionCurveRadius, centerX - motionCurveRadius, centerY);
        path.quadraticBezierTo(centerX - motionCurveRadius, centerY - motionCurveRadius, centerX, centerY);
      }
      
      _bubblePaths.add(path);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fractionNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _fractionNotifier,
        builder: (context, _fraction, child) {
          // 计算缩放值
          double scale = widget.enableScale! ? 1 + _fraction : 1;

          // 构建气泡列表
          final bubbleWidgets = <Widget>[];
          
          for (int i = 0; i < _bubblePaths.length; i++) {
            final path = _bubblePaths[i];
            final config = _bubbleConfigs[i];
            
            // 获取贝塞尔曲线上的点
            final pathMetric = path.computeMetrics().first;
            final point = pathMetric.getTangentForOffset(
              pathMetric.length * _fraction,
            )!.position;
            
            bubbleWidgets.add(
              CustomPaint(
                painter: BezierCurvePainter(
                  point,
                  config.color,
                  config.radius,
                  scale: scale,
                  scaleFactor: widget.scaleFactor,
                ),
              ),
            );
          }

          return Container(
              color: widget.backgroundColor,
              width: mWidth,
              height: mHeight,
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: Opacity(
                  opacity: widget.enableOpacity! ? 1 - _fraction : 1,
                  child: Stack(
                    children: bubbleWidgets,
                  ),
                ),
              )
          );
        });
  }
}

/// 气泡配置类 / Bubble configuration class
/// 
/// 用于自定义每个气泡的属性
/// Used to customize properties of each bubble
class BubbleConfig {
  /// 气泡颜色 / Bubble color
  final Color color;
  
  /// 起始角度（度数：0=上, 90=右, 180=下, 270=左）/ Start angle (degrees: 0=top, 90=right, 180=bottom, 270=left)
  final double startAngle;
  
  /// 气泡半径 / Bubble radius
  final double? radius;
  
  /// 自定义绘制器 / Custom painter
  /// 
  /// 如果提供，将使用此绘制器代替默认的圆形绘制
  /// If provided, will use this painter instead of default circle drawing
  final CustomPainter? customPainter;

  const BubbleConfig({
    required this.color,
    required this.startAngle,
    this.radius = 10,
    this.customPainter,
  });
}

/// 自定义绘制器 / Custom painter
/// 
/// 用于绘制气泡
/// Used to draw bubbles
class BezierCurvePainter extends CustomPainter {
  /// 气泡颜色 / Bubble color
  final Color color;
  
  /// 要绘制的点 / Point to draw
  final Offset point;

  /// 缩放值 / Scale value
  final double? scale;
  
  /// 气泡半径 / Bubble radius
  final double? bobbleRadius;
  
  /// 缩放因子 / Scale factor
  final double scaleFactor;

  BezierCurvePainter(
    this.point,
    this.color,
    this.bobbleRadius, {
    this.scale = 0,
    this.scaleFactor = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // 计算最终半径
    final radius = bobbleRadius! + scale! * scaleFactor;
    
    canvas.drawCircle(point, radius, paint);
  }
  
  @override
  bool shouldRepaint(covariant BezierCurvePainter oldDelegate) {
    return oldDelegate.point != point ||
        oldDelegate.color != color ||
        oldDelegate.scale != scale ||
        oldDelegate.bobbleRadius != bobbleRadius;
  }
}