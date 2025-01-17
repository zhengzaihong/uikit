

import 'package:flutter/cupertino.dart';

import '../bar.dart';
import '../interface.dart';
import '../item.dart';
import 'fixed_circle_tab_style.dart';
import 'fixed_tab_style.dart';
import 'flip_tab_style.dart';
import 'react_circle_tab_style.dart';
import 'react_tab_style.dart';
import 'textin_tab_style.dart';
import 'titled_tab_style.dart';

/// Factory method to return the [DelegateBuilder] for each [TabStyle].
DelegateBuilder supportedStyle(
  TabStyle style, {
  required List<TabItem> items,
  required Color color,
  required Color activeColor,
  required Color backgroundColor,
  required Curve curve,
}) {
  assert(items.isNotEmpty, 'items should not be empty');
  assert(
      ((style == TabStyle.fixed || style == TabStyle.fixedCircle) &&
              items.length.isOdd) ||
          (style != TabStyle.fixed && style != TabStyle.fixedCircle),
      'item count should be an odd number when using fixed/fixedCircle');
  DelegateBuilder builder;
  switch (style) {
    case TabStyle.fixed:
      builder = FixedTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        convexIndex: items.length ~/ 2,
      );
      break;
    case TabStyle.fixedCircle:
      builder = FixedCircleTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        backgroundColor: backgroundColor,
        convexIndex: items.length ~/ 2,
      );
      break;
    case TabStyle.react:
      builder = ReactTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        curve: curve,
      );
      break;
    case TabStyle.reactCircle:
      builder = ReactCircleTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        backgroundColor: backgroundColor,
        curve: curve,
      );
      break;
    case TabStyle.textIn:
      assert(items.every((it) => it.title != null && it.title!.isNotEmpty),
          'title is necessary for TabStyle.textIn');
      builder = TextInTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        curve: curve,
      );
      break;
    case TabStyle.titled:
      assert(items.every((it) => it.title != null && it.title!.isNotEmpty),
          'title is necessary for TabStyle.titled');
      builder = TitledTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        curve: curve,
        backgroundColor: backgroundColor,
      );
      break;
    case TabStyle.flip:
      builder = FlipTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        curve: curve,
      );
      break;
    default:
      builder = ReactCircleTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        backgroundColor: backgroundColor,
        curve: curve,
      );
      break;
  }
  return builder;
}
