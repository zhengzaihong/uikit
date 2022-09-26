import 'package:flutter/material.dart';
import 'dart:math' as math;


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/26
/// create_time: 17:26
/// describe: 圆形进度条
///
class CycleProgressBar extends StatefulWidget {

  final bool? enableAnimation;
  final double angle;
  final int? animationTime;
  final double width;
  final double height;

  final Color cycleBgColor;
  final Color progressBgColor;
  final double strokeWidth;

  const CycleProgressBar({Key? key,
    required this.angle,
    required this.width,
    required this.height,
    this.enableAnimation =false,
    this.animationTime = 2000,
    this.cycleBgColor = Colors.grey,
    this.progressBgColor = Colors.red,
    this.strokeWidth = 14
  }) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<CycleProgressBar> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: widget.animationTime!),
        vsync: this);

    var widgetsBinding=WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback){
      animationController.forward(from: 0);
    });
  }
  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    if(widget.enableAnimation!){
      var  animation= Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.fastOutSlowIn));

      return AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child){
            return CustomPaint(
              painter: CurvePainter(
                  cycleBgColor:  widget.cycleBgColor,
                  progressBgColor:widget.progressBgColor,
                  strokeWidth: widget.strokeWidth,
                  angle: widget.angle*animation.value),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
              ),
            );
          });
    }



    return CustomPaint(
      painter: CurvePainter(
          cycleBgColor:  widget.cycleBgColor,
          progressBgColor:widget.progressBgColor,
          strokeWidth: widget.strokeWidth,
          angle: widget.angle),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}


class CurvePainter extends CustomPainter {

  final double? angle;
  final Color cycleBgColor;
  final Color progressBgColor;

  final double strokeWidth;
  CurvePainter({
    required this.cycleBgColor,
    required this.progressBgColor,
    required this.strokeWidth,
    this.angle = 0,});

  @override
  void paint(Canvas canvas, Size size) {

    final shdowPaint = Paint()
      ..color = cycleBgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final shdowPaintCenter =  Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (strokeWidth / 2);

    ///绘制底色圆形
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        360,
        360,
        false,
        shdowPaint);

    final paint =  Paint()
      ..color = progressBgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final center =  Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (strokeWidth / 2);

    canvas.drawArc(
         Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
