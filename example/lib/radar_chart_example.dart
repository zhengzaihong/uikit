import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class RadarChartExample extends StatefulWidget {
  const RadarChartExample({super.key});

  @override
  State<RadarChartExample> createState() => _RadarChartExampleState();
}

class _RadarChartExampleState extends State<RadarChartExample> {
  static const _dimensions = [
    RadarDimension(
      name: '速度',
      max: 100,
      scoreStyle: TextStyle(color: Colors.white, fontSize: 11),
      labelBgColor: Color(0xFFE84393),
    ),
    RadarDimension(
      name: '力量',
      max: 100,
      scoreStyle: TextStyle(color: Colors.white, fontSize: 11),
      labelBgColor: Color(0xFF0984E3),
    ),
    RadarDimension(
      name: '耐力',
      max: 100,
      scoreStyle: TextStyle(color: Colors.white, fontSize: 11),
      labelBgColor: Color(0xFF00B894),
    ),
    RadarDimension(
      name: '敏捷',
      max: 100,
      scoreStyle: TextStyle(color: Colors.white, fontSize: 11),
      labelBgColor: Color(0xFFFDCB6E),
    ),
    RadarDimension(
      name: '智力',
      max: 100,
      scoreStyle: TextStyle(color: Colors.white, fontSize: 11),
      labelBgColor: Color(0xFF6C5CE7),
    ),
  ];

  static const _series = [
    RadarSeries(
      values: [82, 95, 72, 65, 90],
      labelBgColor: Color(0xFF6C5CE7),
      fillColor: Color(0xFF6C5CE7),
      fillOpacity: 0.26,
      strokeColor: Color(0xFF6C5CE7),
      legend: '玩家 A',
    ),
    RadarSeries(
      values: [68, 78, 92, 80, 70],
      labelBgColor: Color(0xFF00B894),
      fillColor: Color(0xFF00B894),
      fillOpacity: 0.20,
      strokeColor: Color(0xFF00B894),
      legend: '玩家 B',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShowcasePage(
      title: '多维雷达',
      children: [
        ShowcaseSection(
          title: '多维能力雷达',
          icon: Icons.radar,
          description: '两组数据对比，支持维度点击与动画展开',
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  scheme.primary.withValues(alpha: 0.10),
                  scheme.tertiary.withValues(alpha: 0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final radius = ((constraints.maxWidth - 120) / 2)
                    .clamp(70.0, 96.0)
                    .toDouble();
                return SizedBox(
                  height: 400,
                  child: Center(
                    child: RadarChart(
                      dimensions: _dimensions,
                      series: _series,
                      radius: radius,
                      levels: 5,
                      gridShape: RadarGridShape.polygon,
                      labelMode: RadarLabelMode.outerBadge,
                      outerLabelStyle: RadarOuterLabelStyle.titleOverScore,
                      showScore: true,
                      badgeRadius: 15,
                      titlePadding: 8,
                      titleMargin: 8,
                      showLegend: true,
                      legendTextStyle: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
                      ),
                      legendSpacing: 16,
                      animate: true,
                      animationDuration: const Duration(milliseconds: 1000),
                      animationCurve: Curves.easeOutCubic,
                      onDimensionTapped: (index) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text('你点击了维度：${_dimensions[index].name}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        ShowcaseSection(
          title: '五维雷达',
          icon: Icons.pentagon_outlined,
          description: '轻量 Radar5DimensionsChart，适合小尺寸数据展示',
          child: Row(
            children: [
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Radar5DimensionsChart(
                  radius: 78,
                  padding: 18,
                  cycleRadius: 20,
                  radarType: RadarType.normal,
                  showScore: false,
                  zeroToPointPaint: Paint()
                    ..style = PaintingStyle.stroke
                    ..color = scheme.primary.withValues(alpha: 0.18)
                    ..strokeWidth = 0.8,
                  contentPaint: Paint()
                    ..color = scheme.primary.withValues(alpha: 0.28)
                    ..strokeWidth = 1.5
                    ..style = PaintingStyle.fill,
                  pentagonPaint: Paint()
                    ..color = scheme.primary.withValues(alpha: 0.08)
                    ..strokeWidth = 1,
                  data: [
                    RadarBean(40, '认知',
                        bgColor: Color(0xFF0984E3),
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: 12)),
                    RadarBean(55, '心理',
                        bgColor: Color(0xFF00B894),
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: 12)),
                    RadarBean(30, '运动',
                        bgColor: Color(0xFFE84393),
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: 12)),
                    RadarBean(20, '活力',
                        bgColor: Color(0xFFFDCB6E),
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: 12)),
                    RadarBean(10, '感官',
                        bgColor: Color(0xFF6C5CE7),
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '轻量五维视图',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '适合在卡片、列表或信息密度较高的页面中展示五个维度的相对强弱。',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final item in const [
                          ('认知', Color(0xFF0984E3)),
                          ('心理', Color(0xFF00B894)),
                          ('运动', Color(0xFFE84393)),
                          ('活力', Color(0xFFFDCB6E)),
                          ('感官', Color(0xFF6C5CE7)),
                        ])
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 5),
                            decoration: BoxDecoration(
                              color: item.$2.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.$1,
                              style: TextStyle(
                                fontSize: 11,
                                color: item.$2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}