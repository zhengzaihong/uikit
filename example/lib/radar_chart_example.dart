import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

class RadarChartExample extends StatefulWidget {

  const RadarChartExample({Key? key}) : super(key: key);

  @override
  State<RadarChartExample> createState() => _RadarChartExampleState();
}

class _RadarChartExampleState extends State<RadarChartExample> {

  final dims =const [
    RadarDimension(name: '速度', max: 100, scoreStyle:  TextStyle(color: Colors.white), labelBgColor: Colors.red),
    RadarDimension(name: '力量', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.blue),
    RadarDimension(name: '耐力', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.green),
    RadarDimension(name: '敏捷', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.orange),
    RadarDimension(name: '智力', max: 100, scoreStyle: TextStyle(color: Colors.white), labelBgColor: Colors.purple),
    // 想要更多维度？加上即可（≥ 3）
  ];

// 多组数据
  final series = const[
    RadarSeries(
      values: [80, 100, 70, 60, 90],
      labelBgColor: Colors.pink,
      fillColor: Colors.blue,
      fillOpacity: 0.28,
      strokeColor: Colors.transparent,
      legend: '玩家 A',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            RouteUtils.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.red,),
        ),
        title: const Text("多维雷达组件"),
      ),
      body: Column(children: [
        Center(
          child: RadarChart(
            dimensions: dims,
            series: series,
            radius: 90,
            levels: 5,
            outerLabelStyle: RadarOuterLabelStyle.scoreOverTitle,
            gridShape: RadarGridShape.polygon,
            // 或 RadarGridShape.circle
            labelMode: RadarLabelMode.inner, // inner / outerBadge / none
            showInnerLabelBg: true, // 在inner模式下，不显示背景
            showScore: true,
            // 是否同时显示分数
            badgeRadius: 20,
            titlePadding: 10,
            titleMargin: 10,
            // axisLinePaint: Paint()
            //   ..color = Colors.cyanAccent.setAlpha(0.3)
            //   ..strokeWidth = 0.5
            //   ..style = PaintingStyle.stroke,
            // gridLinePaint: Paint()
            //   ..color = Colors.cyanAccent.withAlpha(100)
            //   ..strokeWidth = 0.1
            //   ..style = PaintingStyle.stroke,
            // gridFillPaint: Paint()
            //   ..color = Colors.cyanAccent.setAlpha(0.1)
            //   ..strokeWidth = 1
            //   ..style = PaintingStyle.fill,
            animate: true,
            animationDuration: const Duration(milliseconds: 1000),
            animationCurve: Curves.bounceIn,
            showLegend: false,
            onDimensionTapped: (index) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('你点击了维度: ${dims[index].name}'),
                  duration: const Duration(seconds: 1),
                ),
              );
              debugPrint('你点击了维度: ${dims[index].name}');
            },
          ),
        ),

        const SizedBox(height: 200),

        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Radar5DimensionsChart(
                radius: 70,
                padding: 20,
                cycleRadius: 20,
                radarType: RadarType.normal,
                showScore: false,
                zeroToPointPaint: Paint()
                  ..style = PaintingStyle.stroke
                  ..color = Colors.cyanAccent.setAlpha(0.3)
                  ..strokeWidth = 0.5,
                contentPaint: Paint()
                  ..color = Colors.cyanAccent.withAlpha(100)
                  ..strokeWidth = 2
                  ..style = PaintingStyle.fill,
                pentagonPaint: Paint()
                  ..color = Colors.cyanAccent.setAlpha(0.1)
                  ..strokeWidth = 1,
                data: [
                  RadarBean(40, '认知',
                      bgColor: Colors.blue,
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 14)),
                  RadarBean(55, '心理',
                      bgColor: Colors.green,
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 14)),
                  RadarBean(30, '运动',
                      bgColor: Colors.red,
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 14)),
                  RadarBean(20, '活力',
                      bgColor: Colors.yellow,
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 14)),
                  RadarBean(10, '感官',
                      bgColor: Colors.purple,
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 14)),
                ]),
          ),
        ),
      ]),
    );
  }
}
