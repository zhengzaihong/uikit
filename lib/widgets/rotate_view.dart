import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2025-12-26
/// time: 17:24
/// describe: 可控角度旋转组件 / Controllable Angle Rotation Component
///
/// 支持配置旋转角度并带动画过渡的组件
/// Component with configurable rotation angle and animation transition
///
/// ## 功能特性 / Features
/// - 🎯 精确控制旋转角度 / Precise angle control
/// - 🎬 平滑的动画过渡 / Smooth animation transition
/// - 🔄 支持动态更新角度 / Dynamic angle updates
/// - ⚙️ 可自定义动画时长 / Customizable animation duration
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单旋转
/// RotateView(
///   angle: 45,
///   child: Icon(Icons.arrow_forward, size: 50),
/// )
///
/// // 动态旋转
/// class MyWidget extends StatefulWidget {
///   @override
///   _MyWidgetState createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   double angle = 0;
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       children: [
///         RotateView(
///           angle: angle,
///           duration: Duration(milliseconds: 500),
///           child: Icon(Icons.navigation, size: 50),
///         ),
///         Slider(
///           value: angle,
///           min: 0,
///           max: 360,
///           onChanged: (value) {
///             setState(() => angle = value);
///           },
///         ),
///       ],
///     );
///   }
/// }
///
/// // 箭头指示器
/// RotateView(
///   angle: 90,
///   child: Icon(Icons.arrow_upward),
/// )
///
/// // 自定义动画时长
/// RotateView(
///   angle: 180,
///   duration: Duration(milliseconds: 800),
///   child: Container(
///     width: 50,
///     height: 50,
///     color: Colors.blue,
///   ),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - angle 范围 0-360 度 / Angle range 0-360 degrees
/// - 角度改变时会自动播放动画 / Auto-animates on angle change
/// - 使用 Curves.easeOut 曲线 / Uses Curves.easeOut curve
///
class RotateView extends StatefulWidget {
  /// 旋转角度 / Rotation angle
  /// 
  /// 目标旋转角度(度数)
  /// Target rotation angle in degrees
  /// 
  /// 取值范围: 0 ~ 360 / Range: 0 ~ 360
  final double angle;

  /// 动画时长 / Animation duration
  /// 
  /// 旋转动画的持续时间
  /// Duration of rotation animation
  /// 
  /// 默认值: Duration(milliseconds: 300) / Default: Duration(milliseconds: 300)
  final Duration duration;

  /// 子组件 / Child widget
  /// 
  /// 需要旋转的组件
  /// Widget to be rotated
  /// 
  /// 必填参数 / Required
  final Widget child;

  const RotateView({
    super.key,
    required this.angle,
    this.duration = const Duration(milliseconds: 300),
    required this.child,
  });

  @override
  State<RotateView> createState() => _RotateViewState();
}

class _RotateViewState extends State<RotateView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _currentAngle = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _updateAnimation();
  }

  @override
  void didUpdateWidget(covariant RotateView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.angle != widget.angle) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    _animation = Tween<double>(
      begin: _currentAngle,
      end: widget.angle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _currentAngle = widget.angle;
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform.rotate(
          angle: _animation.value * 3.1415926 / 180,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
