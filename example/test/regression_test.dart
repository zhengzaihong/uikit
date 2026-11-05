import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_example/city_picker_example.dart';
import 'package:uikit_example/components_selection_example.dart';
import 'package:uikit_example/event_example.dart';
import 'package:uikit_plus/uikit_lib.dart';

void main() {
  tearDown(() {
    EventNotifier.remove('login');
    EventBus.clear();
  });

  testWidgets('city picker renders without explicit data', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CityPickerExample()));

    await tester.tap(find.text('城市选择'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
    expect(find.byType(GeneralPickerView), findsOneWidget);
  });

  testWidgets('event example keeps receiving after re-entering',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EventExample()));

    EventNotifier.sendNotification<String?>('login', 'first');
    await tester.pump();
    expect(find.text('target事件数据: first'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pumpWidget(const MaterialApp(home: EventExample()));

    EventNotifier.sendNotification<String?>('login', 'second');
    await tester.pump();
    expect(find.text('target事件数据: second'), findsOneWidget);

    EventNotifier.sendNotification<String?>('login', 'second');
    await tester.pump();
    expect(find.text('target事件数据: second'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('selection and drag page renders without layout errors',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ComponentsSelectionExample()),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('MultiSelector 无限层级多选'), findsOneWidget);

  });
}