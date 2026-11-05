import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_example/components_navigation_example.dart';
import 'package:uikit_example/components_selection_example.dart';
import 'package:uikit_example/infinite_levels_example.dart';
import 'package:uikit_example/often_widget_example.dart';
import 'package:uikit_example/pager_example.dart';
import 'package:uikit_example/radar_chart_example.dart';
import 'package:uikit_example/selection_menu_example.dart';
import 'package:uikit_example/shimmer_example.dart';
import 'package:uikit_example/tableview_example.dart';
import 'package:uikit_example/toast_example.dart';

void main() {
  testWidgets('selection menu page opens popup and selects an item',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SelectionMenuExample()));
    await tester.pump();

    await tester.tap(find.text('选择技术方向'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Flutter'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('navigation page renders', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ComponentsNavigationExample()),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('经典底部导航'), findsOneWidget);
    expect(find.text('胶囊浮岛导航'), findsOneWidget);
  });

  testWidgets('multi selector expands and toggles a leaf', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ComponentsSelectionExample()),
    );
    await tester.pump();

    await tester.tap(find.text('前端开发'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Flutter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('动画与手势'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('动画与手势'), findsWidgets);
  });

  testWidgets('toast page renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToastExample()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('状态提示'), findsOneWidget);

  });

  testWidgets('infinite levels page renders and expands all', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: InfiniteLevelsExample()),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('产品中心'), findsWidgets);
    expect(find.text('层级路径'), findsOneWidget);

    await tester.tap(find.byTooltip('展开全部'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('shimmer page toggles skeleton and real content', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ShimmerLoadingExample()),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('加载控制'), findsOneWidget);

    await tester.tap(find.text('显示真实内容'));
    await tester.pumpAndSettle();

    expect(find.text('真实内容已加载'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('table page renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TableViewExample()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('双向滚动数据表格'), findsOneWidget);
  });

  testWidgets('pager page renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PagerExample()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('分页概览'), findsOneWidget);
  });

  testWidgets('radar page renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RadarChartExample()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('多维能力雷达'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('often widgets page renders top and scrolled content',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: OftenWidgetExample()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('跑马灯 MarqueeView'), findsOneWidget);

    await tester.drag(
      find.byType(ListView).first,
      const Offset(0, -1200),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}