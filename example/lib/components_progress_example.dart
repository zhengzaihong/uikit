import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ComponentsProgressExample extends StatefulWidget {
  const ComponentsProgressExample({super.key});

  @override
  State<ComponentsProgressExample> createState() =>
      _ComponentsProgressExampleState();
}

class _ComponentsProgressExampleState
    extends State<ComponentsProgressExample> {
  double _percent = 0.65;

  @override
  Widget build(BuildContext context) {
    return ShowcasePage(
      title: '进度条组件',
      children: [
        ShowcaseSection(
          title: 'LinearProgressBar 线性进度条',
          description: '纯色与渐变两种样式，支持动画和中心内容',
          child: Column(
            children: [
              LinearProgressBar(
                percent: _percent,
                width: 280,
                lineHeight: 12,
                progressColor: Colors.blue,
                backgroundColor: Colors.blue.shade50,
                barRadius: const Radius.circular(6),
                center: Text('${(_percent * 100).round()}%'),
              ),
              vGap(20),
              LinearProgressBar(
                percent: _percent,
                width: 280,
                lineHeight: 12,
                linearGradient: const LinearGradient(
                  colors: [Colors.orange, Colors.red],
                ),
                backgroundColor: Colors.orange.shade50,
                barRadius: const Radius.circular(6),
              ),
              vGap(20),
              LinearProgressBar(
                percent: _percent,
                width: 280,
                lineHeight: 18,
                animation: true,
                animationDuration: 600,
                progressColor: Colors.green,
                backgroundColor: Colors.green.shade50,
                barRadius: const Radius.circular(9),
                center: const Text('带动画'),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'CycleProgressBar 环形进度条',
          description: '支持纯色、渐变、动画与中心指示器',
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              CycleProgressBar(
                radius: 52,
                percent: _percent,
                lineWidth: 10,
                progressColor: Colors.green,
                center: Text('${(_percent * 100).round()}%'),
              ),
              CycleProgressBar(
                radius: 52,
                percent: _percent,
                lineWidth: 10,
                linearGradient: const LinearGradient(
                  colors: [Colors.blue, Colors.cyan],
                ),
                center: const Text('渐变'),
              ),
              CycleProgressBar(
                radius: 52,
                percent: _percent,
                lineWidth: 10,
                animation: true,
                animationDuration: 1200,
                progressColor: Colors.deepPurple,
                center: const Text('动画'),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '交互控制',
          description: '拖动滑块同时更新线性与环形进度条',
          child: Slider(
            value: _percent,
            onChanged: (value) => setState(() => _percent = value),
          ),
        ),
      ],
    );
  }
}