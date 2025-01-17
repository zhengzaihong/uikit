

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Convex shape is moved after selection.
class ReactTabStyle extends InnerBuilder {
  /// Curve for tab transition.
  final Curve curve;

  /// Create style builder.
  ReactTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color color,
    required this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    var style = ofStyle(context);
    var noLabel = style.hideEmptyLabel && hasNoText(item);

    if (active) {
      var children = <Widget>[
        TransitionContainer.scale(
          data: index,
          curve: curve,
          child: BlendImageIcon(
            item.activeIcon ?? item.icon,
            color: item.blend ? activeColor : null,
            size: style.activeIconSize,
          ),
        ),
      ];
      if (!noLabel) {
        children.add(Text(item.title ?? '',
            style: style.textStyle(activeColor, item.fontFamily)));
      }
      return Container(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment:
              noLabel ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: children,
        ),
      );
    }
    var children = <Widget>[
      BlendImageIcon(item.icon,
          color: item.blend ? color : null, size: style.iconSize),
    ];
    if (!noLabel) {
      children.add(Text(item.title ?? '',
          style: style.textStyle(color, item.fontFamily)));
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment:
            noLabel ? MainAxisAlignment.center : MainAxisAlignment.end,
        children: children,
      ),
    );
  }
}
