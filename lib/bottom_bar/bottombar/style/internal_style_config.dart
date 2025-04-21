

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
    return (action_layout_size - action_inner_button_size) / 4;
  }

  @override
  double get activeIconSize {
    return action_inner_button_size;
  }

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(color: color, fontFamily: fontFamily);
  }
}
