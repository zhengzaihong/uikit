import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ComponentsNavigationExample extends StatefulWidget {
  const ComponentsNavigationExample({super.key});

  @override
  State<ComponentsNavigationExample> createState() =>
      _ComponentsNavigationExampleState();
}

class _ComponentsNavigationExampleState
    extends State<ComponentsNavigationExample> {
  int _bottomIndex = 0;
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('导航与动画')),
      drawer: SmartDrawer(
        width: 260,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E3A59), Color(0xFF4A5A82)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              Text(
                'SmartDrawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text('这是一个可自定义宽度与装饰的抽屉。',
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        children: [
          ShowcaseSection(
            title: 'CustomAnimatedBottomBar 底部导航',
            description: '支持徽章、选中态动画与触觉反馈',
            child: Column(
              children: [
                CustomAnimatedBottomBar(
                  selectedIndex: _bottomIndex,
                  onChanged: (index) =>
                      setState(() => _bottomIndex = index),
                  items: [
                    MyBottomNavigationBarItem(
                      checkedIcon: const Icon(Icons.home),
                      unCheckedIcon: const Icon(Icons.home_outlined),
                      title: const Text('首页'),
                    ),
                    MyBottomNavigationBarItem(
                      checkedIcon: const Icon(Icons.explore),
                      unCheckedIcon: const Icon(Icons.explore_outlined),
                      title: const Text('发现'),
                      showBadge: true,
                      badgeCount: 5,
                    ),
                    MyBottomNavigationBarItem(
                      checkedIcon: const Icon(Icons.person),
                      unCheckedIcon: const Icon(Icons.person_outline),
                      title: const Text('我的'),
                      activeColor: Colors.deepPurple,
                    ),
                  ],
                ),
const SizedBox(height: 12),
                Text('当前索引：$_bottomIndex'),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'SmartDrawer 自定义抽屉',
            description: '配合 Scaffold.drawer 使用，支持宽度与装饰',
            child: Builder(
              builder: (context) => ElevatedButton.icon(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
                label: const Text('打开抽屉'),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Responsive 响应式布局',
            description: '根据宽度自动选择 mobile / tablet / desktop 布局',
            child: Responsive(
              mobile: _deviceCard('Mobile 布局', Colors.orange),
              tablet: _deviceCard('Tablet 布局', Colors.blue),
              desktop: _deviceCard('Desktop 布局', Colors.green),
            ),
          ),
          ShowcaseSection(
            title: 'RotatingView 持续旋转',
            description: '适合加载指示器与循环动画',
            child: Center(
              child: RotatingView(
                speed: const Duration(seconds: 2),
                child: const Icon(Icons.refresh, size: 44, color: Colors.blue),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'RotateView 可控角度旋转',
            description: '角度变化时自动播放过渡动画',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotateView(
                      angle: _angle,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.navigation,
                        size: 44,
                        color: Colors.deepPurple,
                      ),
                    ),
                    hGap(16),
                    Text('${_angle.round()}°'),
                  ],
                ),
                Slider(
                  value: _angle,
                  min: 0,
                  max: 360,
                  onChanged: (value) => setState(() => _angle = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceCard(String label, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}