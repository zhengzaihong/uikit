// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

import '../lib/main.dart';


void main() {

  String info = "我是一个25岁的男人，我的English Name is May。我有3000万存款";

  List<String> list = KitMath.parseStrPlus(info);
  print(list);
  list.forEach((element) {
    print("element:$element");
  });

}
