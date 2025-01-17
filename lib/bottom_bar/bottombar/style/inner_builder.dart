

import 'package:flutter/cupertino.dart';

import '../bar.dart';
import '../interface.dart';
import '../item.dart';
import 'internal_style_config.dart';

/// Simple builder which extend [DelegateBuilder] to provide some necessary config.
abstract class InnerBuilder extends DelegateBuilder {
  /// List of [TabItem] stands for tabs.
  final List<TabItem> items;

  /// Color used when tab is active.
  final Color activeColor;

  /// Color used for tab.
  final Color color;

  /// Style hook to override the internal tab style
  StyleHook? _style;

  /// Create style builder.
  InnerBuilder(
      {required this.items, required this.activeColor, required this.color});

  /// Get style config
  StyleHook ofStyle(BuildContext context) {
    return StyleProvider.of(context)?.style ?? (_style ??= InternalStyle());
  }

  /// Return true if title text exists
  bool hasNoText(TabItem item) {
    return item.title == null || item.title!.isEmpty;
  }
}
