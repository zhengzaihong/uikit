import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/29
/// create_time: 18:10
/// describe: 线性进度条
///
class LinearProgressBar extends StatefulWidget {

  final bool? enableAnimation;
  final double progress;
  final int? animationTime;
  final double width;
  final double height;

  final Color bgColor;
  final Color progressBgColor;
  final double strokeWidth;

  const LinearProgressBar({
    required this.progress,
    required this.width,
    required this.height,
    this.enableAnimation =false,
    this.animationTime = 2000,
    this.bgColor = Colors.grey,
    this.progressBgColor = Colors.red,
    this.strokeWidth = 14,
    Key? key}) : super(key: key);

  @override
  _LinearProgressBarState createState() => _LinearProgressBarState();
}

class _LinearProgressBarState extends State<LinearProgressBar> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: widget.animationTime!),
        vsync: this);

    var widgetsBinding=WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback){
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
              painter: LinearPainter(
                  bgColor:  widget.bgColor,
                  progressBgColor:widget.progressBgColor,
                  strokeWidth: widget.strokeWidth,
                  progress: widget.progress*animation.value),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
              ),
            );
          });
    }
    return CustomPaint(
      painter: LinearPainter(
          bgColor:  widget.bgColor,
          progressBgColor:widget.progressBgColor,
          strokeWidth: widget.strokeWidth,
          progress: widget.progress),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
class LinearPainter extends CustomPainter {

  double progress;
  final Color bgColor;
  final Color progressBgColor;
  final double strokeWidth;

  LinearPainter({
    required this.bgColor,
    required this.progressBgColor,
    required this.strokeWidth,
    this.progress = 0});

  @override
  void paint(Canvas canvas, Size size) {

    final shdowPaint = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;


    ///绘制底色进度条
    var start = Offset(0.0, size.height / 2);
    var end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, shdowPaint);


    final paint = Paint()
      ..color = progressBgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    if(progress>size.width){
      progress = size.width;
    }
    end = Offset(progress, size.height / 2);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}