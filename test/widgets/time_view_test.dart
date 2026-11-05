import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/widgets/time_view.dart';

void main() {
  testWidgets('onComplete fires when the countdown ends, not during init',
      (tester) async {
    final controller = TimeViewController();
    var completeCount = 0;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TimeView(
          controller: controller,
          countdown: 2,
          duration: const Duration(milliseconds: 100),
          onComplete: (_) => completeCount++,
          build: (context, current) => Text('$current'),
        ),
      ),
    ));

    expect(completeCount, 0);

    controller.startTimer();
    await tester.pump();
    expect(completeCount, 0);

    await tester.pump(const Duration(milliseconds: 100));
    expect(completeCount, 0);

    await tester.pump(const Duration(milliseconds: 100));
    expect(completeCount, 1);

    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
  });

  testWidgets('one second countdown completes after one second',
      (tester) async {
    final controller = TimeViewController();
    var completeCount = 0;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TimeView(
          controller: controller,
          countdown: 1,
          duration: const Duration(milliseconds: 100),
          onComplete: (_) => completeCount++,
          build: (context, current) => Text('$current'),
        ),
      ),
    ));

    controller.startTimer();
    await tester.pump(const Duration(milliseconds: 100));

    expect(completeCount, 1);

    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
  });
}