

import 'package:flutter/material.dart';

import '../bar.dart';
import '../interface.dart';


/// Internal style configuration.
class InternalStyle extends StyleHook {
  @override
  double? get iconSize {
    // use null will fallback to size of IconTheme
    return null;
  }

  @override
  double get activeIconMargin {
    return (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 4;
  }

  @override
  double get activeIconSize {
    return ACTION_INNER_BUTTON_SIZE;
  }

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(color: color, fontFamily: fontFamily);
  }
}
