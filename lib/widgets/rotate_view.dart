import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025-12-26
/// create_time: 17:24
/// describe: 支持配置旋转角度的widget
///
class RotateView extends StatefulWidget {
  //// 0 - 360
  final double angle; 
  final Duration duration;
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
