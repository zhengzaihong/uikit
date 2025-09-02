
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uikit_plus/utils/color_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/29
/// create_time: 14:42
/// describe: 5维度雷达图  N维 使用[RadarChart]
///

enum RadarType {
  inner,
  normal,
  none,
}
typedef CustomPosition = Offset Function(Offset,RadarBean);

@Deprecated("Please use a more powerful RadarChart component instead")
class Radar5DimensionsChart extends StatefulWidget {

  ///半径
  final double? radius;

  ///文字和图像的间距
  final double padding;
  final double titleMargin;

  final List<RadarBean> data;

  final double cycleRadius;
  final Paint? zeroToPointPaint;
  final Paint? pentagonPaint;
  final Paint? contentPaint;
  final RadarType radarType;

  final CustomPosition? customPosition;
  final bool showScore;
  //分值计算标准，默认100
  final double totalScore;

  const Radar5DimensionsChart({
    required this.data,
    this.radius = 70,
    this.padding = 10,
    this.titleMargin = 10,
    this.cycleRadius=22,
    this.zeroToPointPaint,
    this.pentagonPaint,
    this.contentPaint,
    this.radarType = RadarType.normal,
    this.customPosition,
    this.showScore = true,
    this.totalScore = 100,
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
    zeroToPointPaint = widget.zeroToPointPaint??(
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.white.setAlpha(0.3)
          ..strokeWidth = 0.5
    );

    ///5层五边形画笔
    pentagonPaint = widget.pentagonPaint??(Paint()
      ..color = Colors.grey.setAlpha(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill);

    ///覆盖内容颜色
    contentPaint = widget.contentPaint??(
        Paint()
          ..color = Colors.grey.withAlpha(100)
          ..strokeWidth = 2
          ..style = PaintingStyle.fill

    );

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
    if(widget.radarType == RadarType.none){
      for (int i = 0; i < points.length; i++) {
        final score = widget.data[i].emptyScoreGrid;
        list.add(points[i].scale(score * scale / widget.totalScore,score * scale / widget.totalScore));
      }
    }else{
      for (int i = 0; i < points.length; i++) {
        final score = widget.data[i].score;
        list.add(points[i].scale(score * scale / widget.totalScore,score * scale / widget.totalScore));
      }
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
          titleMargin: widget.titleMargin,
          zeroToPointPaint: zeroToPointPaint,
          pentagonPaint: pentagonPaint,
          contentPaint: contentPaint,
          radarType: widget.radarType,
          customPosition: widget.customPosition,
          showScore: widget.showScore
      ),
    );
  }
}

class RadarMapPainter extends CustomPainter {

  double radius;
  double cycleRadius;
  double padding;
  double titleMargin;
  Paint zeroToPointPaint;
  Paint pentagonPaint;
  Paint contentPaint;
  List<RadarBean> data;
  AnimationController animationController;
  ValueNotifier<List<Offset>> values;
  RadarType radarType;
  CustomPosition? customPosition;
  bool showScore;

  RadarMapPainter(
      {
        required this.data,
        required this.animationController,
        required this.values,
        required this.radius,
        required this.cycleRadius,
        required this.padding,
        required this.titleMargin,
        required this.zeroToPointPaint,
        required this.pentagonPaint,
        required this.contentPaint,
        required this.radarType,
        required this.customPosition,
        required this.showScore
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

    if(radarType == RadarType.none){
      for (int i = 0; i < points.length; i++) {
        final offset = points[i];
        TextStyle textStyle = data[i].textStyle;
        double textSize = textStyle.fontSize??12;
        if(customPosition!=null){
          layoutTitle(customPosition!.call(offset,data[i]),data[i],canvas);
          continue;
        }
        switch (i) {
          case 0:
            layoutTitle(Offset(offset.dx, offset.dy-padding- cycleRadius - titleMargin-textSize),data[i],canvas);
            break;
          case 1:
            layoutTitle(Offset(offset.dx+cycleRadius/2+padding, offset.dy-cycleRadius),data[i],canvas);
            break;
          case 2:
            layoutTitle(Offset(offset.dx, offset.dy+padding),data[i],canvas);
            break;
          case 3:
            layoutTitle(Offset(offset.dx, offset.dy+padding),data[i],canvas);
            break;
          case 4:
            layoutTitle(Offset(offset.dx-cycleRadius/2 -padding, offset.dy-cycleRadius),data[i],canvas);
            break;
          default:
        }
      }
      return;
    }

    if(radarType == RadarType.normal){
      for (int i = 0; i < points.length; i++) {
        final offset = points[i];
        TextStyle textStyle = data[i].textStyle;
        double textSize = textStyle.fontSize??12;
        final labelBackgroundPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

        switch (i) {
          case 0:
            labelBackgroundPaint.color = data[i].bgColor;
            if(showScore){
              layoutTitle(Offset(offset.dx, offset.dy-padding- cycleRadius - titleMargin-textSize),data[i],canvas);
              canvas.drawCircle(Offset(offset.dx, offset.dy -padding - cycleRadius/2), cycleRadius, labelBackgroundPaint);
              layoutScore(Offset(offset.dx, offset.dy-padding - cycleRadius/2),data[i],canvas);
            } else{
              layoutTitle(Offset(offset.dx, offset.dy-padding),data[i],canvas);
            }
            break;
          case 1:
            labelBackgroundPaint.color = data[i].bgColor;
            if(showScore){
              layoutTitle(Offset(offset.dx+cycleRadius/2+padding, offset.dy-cycleRadius),data[i],canvas);
              canvas.drawCircle(Offset(offset.dx+cycleRadius/2+padding, offset.dy - cycleRadius/2+textSize+titleMargin), cycleRadius, labelBackgroundPaint);
              layoutScore(Offset(offset.dx+cycleRadius/2+padding, offset.dy - cycleRadius/2+textSize+titleMargin),data[i],canvas);
            }else{
              layoutTitle(Offset(offset.dx+padding, offset.dy),data[i],canvas);
            }
            break;
          case 2:
            labelBackgroundPaint.color = data[i].bgColor;
            if(showScore){
              layoutTitle(Offset(offset.dx, offset.dy+padding),data[i],canvas);
              canvas.drawCircle(Offset(offset.dx, offset.dy+padding + cycleRadius/2+titleMargin+textSize), cycleRadius, labelBackgroundPaint);
              layoutScore(Offset(offset.dx, offset.dy+padding +  cycleRadius/2+titleMargin+textSize),data[i],canvas);
            }else{
              layoutTitle(Offset(offset.dx, offset.dy+padding),data[i],canvas);
            }
            break;
          case 3:
            labelBackgroundPaint.color = data[i].bgColor;
            if(showScore){
              layoutTitle(Offset(offset.dx, offset.dy+padding),data[i],canvas);
              canvas.drawCircle(Offset(offset.dx, offset.dy+padding + cycleRadius/2+titleMargin+textSize), cycleRadius, labelBackgroundPaint);
              layoutScore(Offset(offset.dx, offset.dy+padding +  cycleRadius/2+titleMargin+textSize),data[i],canvas);
            }else{
              layoutTitle(Offset(offset.dx, offset.dy+padding),data[i],canvas);
            }
            break;
          case 4:
            labelBackgroundPaint.color = data[i].bgColor;
            if(showScore){
              layoutTitle(Offset(offset.dx-cycleRadius/2 -padding, offset.dy-cycleRadius),data[i],canvas);
              canvas.drawCircle(Offset(offset.dx-cycleRadius/2 - padding, offset.dy - cycleRadius/2+textSize+titleMargin), cycleRadius, labelBackgroundPaint);
              layoutScore(Offset(offset.dx-cycleRadius/2-padding, offset.dy - cycleRadius/2+textSize+titleMargin),data[i],canvas);
            }else{
              layoutTitle(Offset(offset.dx -padding, offset.dy),data[i],canvas);
            }
            break;
          default:
        }
      }
      return;
    }

    // RadarType.inner
    for (int i = 0; i < points.length; i++) {
      final offset = points[i];
      final labelBackgroundPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      switch (i) {
        case 0:
          labelBackgroundPaint.color = data[i].bgColor;
          canvas.drawCircle(
              Offset(offset.dx, offset.dy - padding - cycleRadius / 2),
              cycleRadius,
              labelBackgroundPaint);
          layoutText(Offset(offset.dx, offset.dy - padding - cycleRadius / 2),
              data[i], canvas);
          break;
        case 1:
          labelBackgroundPaint.color = data[i].bgColor;
          canvas.drawCircle(Offset(offset.dx + padding+cycleRadius/2, offset.dy-cycleRadius/2), cycleRadius,
              labelBackgroundPaint);
          layoutText(Offset(offset.dx + padding+cycleRadius/2, offset.dy-cycleRadius/2), data[i], canvas);
          break;
        case 2:
          labelBackgroundPaint.color = data[i].bgColor;
          canvas.drawCircle(Offset(offset.dx + padding, offset.dy+cycleRadius/2+padding), cycleRadius,
              labelBackgroundPaint);
          layoutText(Offset(offset.dx + padding, offset.dy+cycleRadius/2+padding), data[i], canvas);
          break;
        case 3:
          labelBackgroundPaint.color = data[i].bgColor;
          canvas.drawCircle(Offset(offset.dx-padding, offset.dy+cycleRadius/2+padding), cycleRadius,
              labelBackgroundPaint);
          layoutText(Offset(offset.dx-padding, offset.dy+cycleRadius/2+padding), data[i], canvas);
          break;
        case 4:
          labelBackgroundPaint.color = data[i].bgColor;
          canvas.drawCircle(Offset(offset.dx - padding-cycleRadius/2, offset.dy-cycleRadius/2), cycleRadius,
              labelBackgroundPaint);
          layoutText(Offset(offset.dx - padding-cycleRadius/2, offset.dy-cycleRadius/2), data[i], canvas);
          break;
        default:
      }
    }
  }


  void layoutTitle(Offset offset,RadarBean bean,Canvas canvas){
    final scoreTextPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: bean.name,
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

  void layoutScore(Offset offset,RadarBean bean,Canvas canvas){
    final scoreTextPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "${bean.score}",
        style: bean.scoreTextStyle,
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




  void layoutText(Offset offset,RadarBean bean,Canvas canvas){
    final scoreTextPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: showScore?"${bean.name}\n${bean.score}":bean.name,
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

class RadarBean {
  num score;
  String name;
  Color bgColor;
  TextStyle textStyle;
  TextStyle scoreTextStyle;
  num emptyScoreGrid = 0;

  RadarBean(
      this.score,
      this.name, {
        this.bgColor = Colors.white,
        this.textStyle = const TextStyle(color: Colors.black, fontSize: 12),
        this.scoreTextStyle = const TextStyle(color: Colors.white, fontSize: 12),
        this.emptyScoreGrid = 10,
      });
}

