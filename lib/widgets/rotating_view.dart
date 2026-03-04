import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/8
/// create_time: 9:15
/// describe: 持续旋转动画组件 / Continuous Rotating Animation Component
///
/// 让子组件持续旋转的动画组件
/// Component that continuously rotates its child widget
///
/// ## 功能特性 / Features
/// - 🔄 持续旋转动画 / Continuous rotation animation
/// - ⚙️ 可自定义旋转速度 / Customizable rotation speed
/// - 🎯 自动循环播放 / Auto-loop playback
/// - 💫 流畅的动画效果 / Smooth animation effect
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单旋转
/// RotatingView(
///   child: Icon(Icons.refresh, size: 50),
/// )
///
/// // 自定义速度
/// RotatingView(
///   speed: Duration(seconds: 1),
///   child: Image.asset('assets/loading.png'),
/// )
///
/// // 加载指示器
/// RotatingView(
///   speed: Duration(milliseconds: 800),
///   child: Container(
///     width: 40,
///     height: 40,
///     decoration: BoxDecoration(
///       border: Border.all(color: Colors.blue, width: 3),
///       borderRadius: BorderRadius.circular(20),
///     ),
///   ),
/// )
///
/// // 旋转Logo
/// RotatingView(
///   speed: Duration(seconds: 3),
///   child: FlutterLogo(size: 100),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - speed 越小旋转越快 / Smaller speed means faster rotation
/// - 组件会持续旋转直到销毁 / Rotates continuously until disposed
/// - 适合用作加载指示器 / Suitable for loading indicators
///
class RotatingView extends StatefulWidget {
  /// 子组件 / Child widget
  /// 
  /// 需要旋转的组件
  /// Widget to be rotated
  /// 
  /// 必填参数 / Required
  final Widget child;

  /// 旋转速度 / Rotation speed
  /// 
  /// 完成一次360度旋转所需的时间
  /// Time required for one 360-degree rotation
  /// 
  /// 默认值: Duration(seconds: 2) / Default: Duration(seconds: 2)
  final Duration? speed;

  const RotatingView(
      {required this.child,
        this.speed = const Duration(seconds: 2),
        Key? key})
      : super(key: key);

  @override
  State<RotatingView> createState() => _RotatingViewState();
}

class _RotatingViewState extends State<RotatingView> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.speed,
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
