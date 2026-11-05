import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/switch/kit_switch.dart';

Widget _app(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('syncs external isOpen changes', (tester) async {
    await tester.pumpWidget(_app(const KitSwitch(isOpen: false)));
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);

    await tester.pumpWidget(_app(const KitSwitch(isOpen: true)));
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('uses onChanged as the preferred callback', (tester) async {
    bool? received;
    await tester.pumpWidget(_app(KitSwitch(
      isOpen: false,
      onChanged: (value) => received = value,
    )));

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(received, isTrue);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });
}