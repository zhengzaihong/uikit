import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ComponentsBasicExample extends StatefulWidget {
  const ComponentsBasicExample({super.key});

  @override
  State<ComponentsBasicExample> createState() => _ComponentsBasicExampleState();
}

class _ComponentsBasicExampleState extends State<ComponentsBasicExample> {
  bool _switchValue = true;
  bool? _checkValue = true;
  bool _imageSwitchValue = true;
  double _rating = 3;

  @override
  Widget build(BuildContext context) {
    return ShowcasePage(
      title: '基础组件',
      children: [
        ShowcaseSection(
          title: 'KitSwitch 开关',
          description: '支持 Android / iOS 风格、标签位置与触觉反馈',
          child: Column(
            children: [
              KitSwitch(
                isOpen: _switchValue,
                onChanged: (value) => setState(() => _switchValue = value),
                label: const Text('基础开关'),
              ),
              vGap(12),
              const KitSwitch(
                isOpen: true,
                isInnerStyle: true,
                label: Text('内嵌样式'),
              ),
              vGap(12),
              const KitSwitch(
                isOpen: false,
                labelRight: true,
                label: Text('标签在右侧'),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'KitCheckBox 复选框',
          description: '普通、三态与选中态文案切换',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KitCheckBox(
                isChecked: _checkValue,
                text: const Text('同意用户协议'),
                onChanged: (value) => setState(() => _checkValue = value),
              ),
              vGap(8),
              const KitCheckBox(
                tristate: true,
                text: Text('三态复选框（点击循环）'),
              ),
              vGap(8),
              const KitCheckBox(
                isChecked: true,
                text: Text('未选中文案'),
                checkedText: Text('已选中文案'),
              ),
              vGap(8),
              const KitCheckBox(
                isChecked: true,
                iconLeft: true,
                text: Text('图标在左侧'),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'ImageSwitch 图片开关',
          description: '使用任意 Widget 作为开启 / 关闭状态滑块',
          child: ImageSwitch(
            value: _imageSwitchValue,
            width: 72,
            height: 34,
            activeImage: const Icon(Icons.dark_mode,
                size: 18, color: Colors.white),
            inactiveImage: const Icon(Icons.light_mode,
                size: 18, color: Colors.orange),
            onChanged: (value) => setState(() => _imageSwitchValue = value),
          ),
        ),
        ShowcaseSection(
          title: 'RatingBar 评分',
          description: '支持半星、任意步长与只读展示',
          child: Column(
            children: [
              RatingBar(
                value: _rating,
                count: 5,
                maxRating: 5,
                size: 32,
                selectAble: true,
                normalImage: const Icon(Icons.star_border, color: Colors.grey),
                selectImage: const Icon(Icons.star, color: Colors.amber),
                onChanged: (value) => setState(() => _rating = value),
              ),
              vGap(8),
              Text('当前评分：${_rating.toStringAsFixed(1)}'),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'DashedBorder 虚线边框',
          description: '支持圆角、虚线段宽与间距配置',
          child: DashedBorder(
            color: Colors.blue,
            strokeWidth: 2,
            dashWidth: 6,
            dashSpace: 4,
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Text('拖拽文件到此处上传'),
            ),
          ),
        ),
        const ShowcaseSection(
          title: 'DashedRect 虚线矩形',
          description: '纯 CustomPainter 虚线矩形',
          child: SizedBox(
            height: 80,
            child: DashedRect(color: Colors.orange, gap: 8, strokeWidth: 2),
          ),
        ),
        const ShowcaseSection(
          title: 'SeparatorView 虚线分割线',
          description: '支持水平 / 垂直方向',
          child: SizedBox(
            width: double.infinity,
            height: 20,
            child: SeparatorView(
              color: Colors.grey,
              dashWidth: 8,
              dashHeight: 2,
            ),
          ),
        ),
        ShowcaseSection(
          title: 'TextExtend 悬停文本',
          description: '鼠标悬停时切换样式、前后缀与装饰',
          child: TextExtend(
            text: '鼠标悬停查看样式变化',
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            onHoverStyle: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.all(12),
            prefix: const Icon(Icons.article_outlined, size: 18),
            onHoverPrefix: const Icon(Icons.article, size: 18, color: Colors.blue),
          ),
        ),
        ShowcaseSection(
          title: 'Blur 高斯模糊',
          description: 'BackdropFilter 实现的毛玻璃容器',
          child: Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.orange],
                  ),
                ),
              ),
              Positioned.fill(
                child: Blur(
                  blur: 6,
                  borderRadius: BorderRadius.circular(12),
                  overlay: const Center(
                    child: Text(
                      '毛玻璃效果',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '布局工具函数',
          description: 'vGap / hGap / hLine / vLine',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('上方内容'),
              vGap(8),
              hLine(color: Colors.grey.shade300),
              vGap(8),
              Row(
                children: [
                  const Text('左侧'),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 20,
                    child: vLine(color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  const Text('右侧'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}