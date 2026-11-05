import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'city_picker_example.dart';
import 'components_basic_example.dart';
import 'components_button_example.dart';
import 'components_navigation_example.dart';
import 'components_progress_example.dart';
import 'components_selection_example.dart';
import 'date_select_example.dart';
import 'event_example.dart';
import 'infinite_levels_example.dart';
import 'input_example.dart';
import 'input_extend_example.dart';
import 'often_widget_example.dart';
import 'pager_example.dart';
import 'radar_chart_example.dart';
import 'selection_menu_example.dart';
import 'shimmer_example.dart';
import 'splash_bobble_demo.dart';
import 'tableview_example.dart';
import 'toast_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uikit_plus components',
      navigatorKey: Toast.navigatorState,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      builder: (context, child) => GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: child,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({Key? key}):super(key: key);

  static const String version = '0.4.4';

  static final List<_DemoSection> _sections = [
    const _DemoSection('表单与选择', [
      _DemoEntry('输入框', '实时校验与全部 TextField 属性', Icons.text_fields,
          InputExample()),
      _DemoEntry('输入框拓展', '搜索建议与关联结果', Icons.search,
          InputExtendExample()),
      _DemoEntry('仿系统下拉框', '高度自定义的选择菜单', Icons.arrow_drop_down_circle,
          SelectionMenuExample()),
      _DemoEntry('无限层级菜单', '树形展开与多选', Icons.account_tree,
          InfiniteLevelsExample()),
      _DemoEntry('城市选择器', '省市区三级联动', Icons.location_city,
          CityPickerExample()),
      _DemoEntry('日期选择器', '日期范围与时间选择', Icons.calendar_month,
          DateSelectExample()),
      _DemoEntry('选择与拖拽', 'MultiSelector / SelectableGroup / DragBox',
          Icons.checklist, ComponentsSelectionExample()),
    ]),
    const _DemoSection('数据与进度', [
      _DemoEntry('表格布局', '双向滚动、固定表头与列', Icons.table_chart,
          TableViewExample()),
      _DemoEntry('分页组件', '页码、跳转与主题配置', Icons.pages,
          PagerExample()),
      _DemoEntry('进度条组件', '线性与环形进度条', Icons.donut_large,
          ComponentsProgressExample()),
      _DemoEntry('基础组件', '开关、复选、评分、虚线、模糊', Icons.widgets,
          ComponentsBasicExample()),
      _DemoEntry('雷达图表', '多维度雷达图展示', Icons.radar,
          RadarChartExample()),
    ]),
    const _DemoSection('反馈与弹窗', [
      _DemoEntry('Toast 提示', '队列提示与自定义样式', Icons.message,
          ToastExample()),
      _DemoEntry('微光加载', 'Shimmer 骨架屏效果', Icons.blur_on,
          ShimmerLoadingExample()),
      _DemoEntry('按钮与弹窗', '悬浮菜单、全局对话框、右键菜单', Icons.smart_button,
          ComponentsButtonExample()),
      _DemoEntry('常用小组件', '跑马灯、卡片、提示等', Icons.auto_awesome,
          OftenWidgetExample()),
    ]),
    const _DemoSection('动画与导航', [
      _DemoEntry('动画组件', '气泡爆炸动画', Icons.animation,
          SplashBobbleDemo()),
      _DemoEntry('导航与动画', '底部导航、抽屉、响应式、旋转', Icons.navigation,
          ComponentsNavigationExample()),
      _DemoEntry('事件工具', '非 UI 的全局事件总线', Icons.bolt,
          EventExample()),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('uikit_plus 组件示例'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'v$version',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final crossAxisCount = width >= 1100
              ? 4
              : width >= 700
                  ? 3
                  : 2;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            children: [
              const _WelcomeCard(),
              for (final section in _sections) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: section.entries.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.45,
                  ),
                  itemBuilder: (context, index) =>
                      _DemoCard(entry: section.entries[index]),
                ),
              ],
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  '更多用法请查看源码与组件头部的 API 注释。',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DemoSection {
  const _DemoSection(this.title, this.entries);

  final String title;
  final List<_DemoEntry> entries;
}

class _DemoEntry {
  const _DemoEntry(this.title, this.subtitle, this.icon, this.page);

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget page;
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.entry});

  final _DemoEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => entry.page),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(entry.icon, color: scheme.primary, size: 26),
              const Spacer(),
              Text(
                entry.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.25,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'uikit_plus',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '纯 Dart 跨平台 Flutter UI 组件库\n选择器 · 表格 · 输入框 · 动画 · 导航 · 弹窗',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}