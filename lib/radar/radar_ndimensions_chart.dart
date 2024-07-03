import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/radar/radar_bean.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/5/29
/// create_time: 14:42
/// describe: N维度雷达图
///

class RadarNDimensionsChart extends StatefulWidget {

  final List<RadarBean> data;
  final int maxDataValue;
  final Paint? gridPaint;
  final Paint? dataPaint;
  final Paint? labelBackgroundPaint;
  final double cycleRadius;
  final int dimension;

  const RadarNDimensionsChart(
      {required this.data,
      this.maxDataValue = 100,
      this.cycleRadius = 22,
      this.dimension = 5,
        this.gridPaint,
        this.dataPaint,
        this.labelBackgroundPaint,
      Key? key})
      : super(key: key);

  @override
  State<RadarNDimensionsChart> createState() => _RadarNDimensionsChartState();
}

class _RadarNDimensionsChartState extends State<RadarNDimensionsChart> {

  late Paint gridPaint;
  late Paint dataPaint;
  late Paint labelBackgroundPaint;

  @override
  void initState() {
    super.initState();

    gridPaint = widget.gridPaint??(
        Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
    );

    dataPaint = widget.dataPaint??(
        Paint()
          ..color = Colors.green.withOpacity(0.5)
          ..style = PaintingStyle.fill
    );

    labelBackgroundPaint = widget.labelBackgroundPaint??(
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill
    );

  }


  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadarNDimensionsPainter(
        data: widget.data,
        maxDataValue: widget.maxDataValue,
        cycleRadius: widget.cycleRadius,
        dimension: widget.dimension,
        gridPaint: gridPaint,
        dataPaint: dataPaint,
        labelBackgroundPaint: labelBackgroundPaint,
      ),
    );
  }
}

class RadarNDimensionsPainter extends  CustomPainter {

  final List<RadarBean> data;
  final int maxDataValue;
  final Paint gridPaint;
  final Paint dataPaint;
  final Paint labelBackgroundPaint;
  final double cycleRadius;
  final int dimension;

  RadarNDimensionsPainter({
    required this.data,
    required this.maxDataValue,
    required this.cycleRadius,
    required this.dimension,
    required this.gridPaint,
    required this.dataPaint,
    required this.labelBackgroundPaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final angle = (2 * pi) / data.length;
    final radius = min(size.width / 2, size.height / 2);

    /// 绘制网格
    for (int i = 1; i <= dimension; i++) {
      final r = radius * i / 5;
      final path = Path();
      for (int j = 0; j < data.length; j++) {
        final x = center.dx + r * cos(angle * j - pi / 2);
        final y = center.dy + r * sin(angle * j - pi / 2);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    final dataPath = Path();
    for (int i = 0; i < data.length; i++) {
      final value = data[i].score.toDouble() / maxDataValue;
      final x = center.dx + radius * value * cos(angle * i - pi / 2);
      final y = center.dy + radius * value * sin(angle * i - pi / 2);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, dataPaint);

    /// 绘制标签
    for (int i = 0; i < data.length; i++) {
      final scoreBackgroundX =
          center.dx + (radius + 30) * cos(angle * i - pi / 2);
      final scoreBackgroundY =
          center.dy + (radius + 30) * sin(angle * i - pi / 2);

      /// 绘制分数和背景
      final scoreBackgroundOffset = Offset(
        scoreBackgroundX - 30,
        scoreBackgroundY - 30,
      );
      labelBackgroundPaint.color = data[i].bgColor;
      canvas.drawCircle(scoreBackgroundOffset.translate(30, 30), cycleRadius,
          labelBackgroundPaint); // Adjust radius as needed
      final scoreTextPainter = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '${data[i].name}\n${data[i].score}',
          style: data[i].textStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      scoreTextPainter.layout();
      final scoreOffset = Offset(
        scoreBackgroundX - scoreTextPainter.width / 2,
        scoreBackgroundY - scoreTextPainter.height / 2,
      );
      scoreTextPainter.paint(canvas, scoreOffset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}




