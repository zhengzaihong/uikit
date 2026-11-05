import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/loading/shimmer.dart';

Widget _app({required bool isLoading}) => MaterialApp(
      home: Scaffold(
        body: Shimmer(
          isLoading: isLoading,
          builder: (context) => const Text('content'),
        ),
      ),
    );

void main() {
  testWidgets('stops the animation when loading finishes', (tester) async {
    await tester.pumpWidget(_app(isLoading: true));
    await tester.pump(const Duration(milliseconds: 100));

    await tester.pumpWidget(_app(isLoading: false));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));

    expect(find.text('content'), findsOneWidget);
  });
}