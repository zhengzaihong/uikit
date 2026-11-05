import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/utils/measure_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('measureTextSize does not cap long text at 29 lines', () {
    final text = List.generate(60, (index) => 'line$index').join('\n');
    final size = MeasureUtils.measureTextSize(
      text,
      const TextStyle(fontSize: 10, height: 1),
      maxWidth: 200,
    );

    expect(size.height, greaterThan(29 * 10));
  });

  test('measureTextSize respects explicit maxLines', () {
    final text = List.generate(60, (index) => 'line$index').join('\n');
    final size = MeasureUtils.measureTextSize(
      text,
      const TextStyle(fontSize: 10, height: 1),
      maxLines: 2,
      maxWidth: 200,
    );

    expect(size.height, lessThanOrEqualTo(20));
  });
}