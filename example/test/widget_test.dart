import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/utils/color_utils.dart';

void main() {
  test('Color extension formats ARGB hex values', () {
    const color = Color(0xFF42A5F5);

    expect(color.toHexARGB(includeAlpha: false), '#42A5F5');
    expect(color.toHexARGB(includeAlpha: true), '#FF42A5F5');
  });
}