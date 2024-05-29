
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/radar/radar_bean.dart';
import 'package:flutter_uikit_forzzh/radar/radar_ndimensions_chart.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/29
/// create_time: 14:42
/// describe: 5维度雷达图   N维 使用[RadarNDimensionsChart]
///
class Radar5DimensionsChart extends StatefulWidget {

  ///半径
  final double? radius;

  ///文字和图像的间距
  final double padding;

  ///最下面两个的间距
  final double bottomPadding;

  final List<RadarBean> data;

  final double cycleRadius;

  const Radar5DimensionsChart({
    required this.data,
    this.radius = 70,
    this.padding = 10,
    this.bottomPadding = 8,
    this.cycleRadius=22,
    Key? key}):super(key: key);

  @override
  State<Radar5DimensionsChart> createState() => _Radar5DimensionsChartState();
}

class _Radar5DimensionsChartState extends State<Radar5DimensionsChart> with SingleTickerProviderStateMixin {

  ValueNotifier<List<Offset>> values = ValueNotifier([]);

  late AnimationController animationController;
  late Animation animation;
  late List<Offset> points;
  late Paint zeroToPointPaint;
  late Paint pentagonPaint;
  late Paint contentPaint;

  @override
  void initState() {
    super.initState();

    final radius = widget.radius!;

    points = [
      Offset(0, -radius),
      Offset(radius * cos(angleToRadian(18)), -radius * sin(angleToRadian(18))),
      Offset(radius * cos(angleToRadian(54)), radius * sin(angleToRadian(54))),
      Offset(-radius * cos(angleToRadian(54)), radius * sin(angleToRadian(54))),
      Offset(-radius * cos(angleToRadian(18)), radius * -sin(angleToRadian(18))),
    ];

    ///原点到5个定点的连线
    zeroToPointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.lightBlueAccent.withOpacity(0.3)
      ..strokeWidth = 0.5;

    ///5层五边形画笔
    pentagonPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    ///覆盖内容颜色
    contentPaint = Paint()
      ..color = Colors.lightBlue.withAlpha(100)
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;


    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(() {
        values.value = convertPoint(points, widget.data, animation.value);
      });
    animation = CurvedAnimation(parent: animationController,curve: Curves.bounceOut);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.forward(from: 0);
    });
  }

  List<Offset> convertPoint(List<Offset> points, List<RadarBean> score, double scale) {
    List<Offset> list = [];
    for (int i = 0; i < points.length; i++) {
      list.add(points[i].scale(score[i].score * scale / 100, score[i].score * scale / 100));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadarMapPainter(
          data:widget.data,
          cycleRadius: widget.cycleRadius,
          animationController:animationController,
          values:values,
          radius: widget.radius!,
          padding: widget.padding,
          bottomPadding: widget.bottomPadding,
          zeroToPointPaint: zeroToPointPaint,
          pentagonPaint: pentagonPaint,
          contentPaint: contentPaint),
    );
  }
}

class RadarMapPainter extends CustomPainter {

  double radius;
  double cycleRadius;
  double padding;
  double bottomPadding;
  Paint zeroToPointPaint;
  Paint pentagonPaint;
  Paint contentPaint;
  List<RadarBean> data;
  AnimationController animationController;
  ValueNotifier<List<Offset>> values;

  RadarMapPainter(
      {
        required this.data,
        required this.animationController,
        required this.values,
        required this.radius,
        required this.cycleRadius,
        required this.padding,
        required this.bottomPadding,
        required this.zeroToPointPaint,
        required this.pentagonPaint,
        required this.contentPaint
      })
      : super(repaint: values);

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> points = [
      Offset(0, -radius),
      Offset(radius * cos(angleToRadian(18)), -radius * sin(angleToRadian(18))),
      Offset(radius * cos(angleToRadian(54)), radius * sin(angleToRadian(54))),
      Offset(-radius * cos(angleToRadian(54)), radius * sin(angleToRadian(54))),
      Offset(-radius * cos(angleToRadian(18)), radius * -sin(angleToRadian(18))),
    ];

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawPoints(
        PointMode.points,
        [const Offset(0, 0)],
        Paint()
          ..color = Colors.green
          ..strokeWidth = 2);

    const n = 5;
    ///画n个五边形
    for (int i = 0; i < n; i++) {
      List<Offset> points = [
        Offset(0, -radius * (i + 1) / n),
        Offset(radius * (i + 1) / n * cos(angleToRadian(18)),
            -radius * (i + 1) / n * sin(angleToRadian(18))),
        Offset(radius * (i + 1) / n * cos(angleToRadian(54)),
            radius * (i + 1) / n * sin(angleToRadian(54))),
        Offset(-radius * (i + 1) / n * cos(angleToRadian(54)),
            radius * (i + 1) / n * sin(angleToRadian(54))),
        Offset(-radius* (i + 1) / n * cos(angleToRadian(18)),
            radius * (i + 1) / n * -sin(angleToRadian(18))),
      ];
      drawPentagon(points, canvas, pentagonPaint);
    }

    ///连接最外层的五个定点
    drawZeroToPoint(points, canvas);

    ///修改成对应的分数，绘制覆盖内容
    drawPentagon(values.value, canvas, contentPaint);

    ///根据位置绘制文字
    drawTextByPosition(points, canvas,size);
    canvas.restore();
  }

  ///根据位置来绘制文字
  void drawTextByPosition(List<Offset> points, Canvas canvas,Size size) {
    for (int i = 0; i < points.length; i++) {
      switch (i) {
        case 0:
          points[i] -= Offset(0, padding * 2);
          break;
        case 1:
          points[i] += Offset(padding, -padding);
          break;
        case 2:
          points[i] += Offset(bottomPadding, padding);
          break;
        case 3:
          points[i] += Offset(-bottomPadding, padding);
          break;
        case 4:
          points[i] -= Offset(padding, padding);
          break;
        default:
      }
      drawText(canvas, points[i], data[i].textStyle, i,size);
    }
  }


  void drawText(Canvas canvas, Offset offset, TextStyle style, int i,Size size)  {
    final labelBackgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    switch (i) {
      case 0:
        labelBackgroundPaint.color = data[i].bgColor;
        canvas.drawCircle(offset.translate(0, -5), cycleRadius, labelBackgroundPaint);
        layoutText(Offset(offset.dx, offset.dy-5),data[i],canvas);
        break;
      case 1:
        labelBackgroundPaint.color = data[i].bgColor;
        canvas.drawCircle(offset.translate(15, 10), cycleRadius, labelBackgroundPaint);
        layoutText(Offset(offset.dx+15, offset.dy+10),data[i],canvas);
        break;
      case 2:
        labelBackgroundPaint.color = data[i].bgColor;
        canvas.drawCircle(offset.translate(10, 10), cycleRadius, labelBackgroundPaint);
        layoutText(Offset(offset.dx+10, offset.dy+10),data[i],canvas);
        break;
      case 3:
        labelBackgroundPaint.color = data[i].bgColor;
        canvas.drawCircle(offset.translate(5, 15), cycleRadius, labelBackgroundPaint);
        layoutText(Offset(offset.dx+5, offset.dy+15),data[i],canvas);
        break;
      case 4:
        labelBackgroundPaint.color = data[i].bgColor;
        canvas.drawCircle(offset.translate(-15, 10), cycleRadius, labelBackgroundPaint);
        layoutText(Offset(offset.dx-15, offset.dy+10),data[i],canvas);
        break;
      default:
    }
  }

  void layoutText(Offset offset,RadarBean bean,Canvas canvas){
    final scoreTextPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "${bean.name}\n${bean.score}",
        style: bean.textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    scoreTextPainter.layout();
    final scoreOffset = Offset(
      offset.dx - scoreTextPainter.width / 2,
      offset.dy - scoreTextPainter.height / 2,
    );
    scoreTextPainter.paint(canvas, scoreOffset);
  }



  void drawZeroToPoint(List<Offset> points, Canvas canvas) {
    for (var element in points) {
      canvas.drawLine(
        Offset.zero,
        element,
        zeroToPointPaint,
      );
    }
  }

  ///画五边形
  void drawPentagon(List<Offset> points, Canvas canvas, Paint paint) {
    if(points.isEmpty){
      return;
    }
    Path path = Path();
    path.moveTo(0, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

double angleToRadian(double angle) {
  return angle / 180.0 * pi;
}