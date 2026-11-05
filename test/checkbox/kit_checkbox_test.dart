import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/checkbox/kit_checkbox.dart';

Widget _app(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('syncs external isChecked changes', (tester) async {
    await tester.pumpWidget(_app(const KitCheckBox(
      isChecked: false,
      text: Text('checkbox'),
    )));
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);

    await tester.pumpWidget(_app(const KitCheckBox(
      isChecked: true,
      text: Text('checkbox'),
    )));
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
  });

  testWidgets('notifies through onChanged', (tester) async {
    bool? received;
    await tester.pumpWidget(_app(KitCheckBox(
      isChecked: false,
      text: const Text('checkbox'),
      onChanged: (value) => received = value,
    )));

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(received, isTrue);
  });
}