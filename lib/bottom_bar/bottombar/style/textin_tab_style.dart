

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Tab icon, text animated with pop transition.
class TextInTabStyle extends InnerBuilder {
  /// Curve for tab transition.
  final Curve curve;

  /// Create style builder.
  TextInTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color color,
    required this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    var style = ofStyle(context);
    if (active) {
      var textStyle = style.textStyle(activeColor, item.fontFamily);
      return Container(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TransitionContainer.scale(
              data: index,
              curve: curve,
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: style.activeIconSize,
              ),
            ),
            TransitionContainer.slide(
              curve: curve,
              child: Text(item.title ?? '', style: textStyle),
            ),
          ],
        ),
      );
    }

    return Center(
      child: BlendImageIcon(item.icon,
          size: style.iconSize, color: item.blend ? color : null),
    );
  }
}
