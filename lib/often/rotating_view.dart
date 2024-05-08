import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/8
/// create_time: 9:15
/// describe: 一直转动view
///
class RotatingView extends StatefulWidget {

  final Widget child;
  final Duration? speed;

  const RotatingView(
      { required this.child,
        this.speed = const Duration(seconds: 2),
        Key? key})
      : super(key: key);

  @override
  State<RotatingView> createState() => _RotatingViewState();
}

class _RotatingViewState extends State<RotatingView>
    with SingleTickerProviderStateMixin {
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
