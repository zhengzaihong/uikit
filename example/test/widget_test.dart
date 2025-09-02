// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/material.dart';
import 'package:uikit/utils/color_utils.dart';

void main() {

  Color myColor = const Color(0xFF42A5F5);
  String hex = myColor.toHexARGB(includeAlpha: false);             // #42A5F5
  String hexWithAlpha = myColor.toHexARGB(includeAlpha: true); // #FF42A5F5

  debugPrint(hex);          // 输出: #42A5F5
  debugPrint(hexWithAlpha); // 输出: #FF42A5F5

  // debugPrint(myColor.withOpacity(0.5).toHexARGB());
  debugPrint((myColor.setAlpha(0.5).toHexARGB()));


}
