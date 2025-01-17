

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Tab icon, text animated with pop transition.
class TitledTabStyle extends InnerBuilder {
  /// Curve for tab transition.
  final Curve curve;

  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Previous active tab index.
  int _preActivate = -1;

  /// Create style builder.
  TitledTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color color,
    required this.curve,
    required this.backgroundColor,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var pre = _preActivate;
    if (active) {
      _preActivate = index;
    }
    var item = items[index];
    var style = ofStyle(context);
    var margin = style.activeIconMargin;

    if (active) {
      return TransitionContainer.slide(
        data: index,
        duration: Duration(milliseconds: 200),
        curve: curve,
        child: Container(
          // necessary otherwise the badge will not large enough
          width: style.layoutSize,
          height: style.layoutSize,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(shape: BoxShape.circle, color: activeColor),
          child: BlendImageIcon(
            item.activeIcon ?? item.icon,
            size: style.activeIconSize,
            color: item.blend ? backgroundColor : null,
          ),
        ),
      );
    }

    var textStyle = style.textStyle(activeColor, item.fontFamily);
    if (pre == index) {
      return Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: <Widget>[
          Text(item.title ?? '', style: textStyle),
          TransitionContainer.slide(
            reverse: true,
            curve: curve,
            child: Container(
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor,
              ),
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                size: style.activeIconSize,
                color: item.blend ? backgroundColor : null,
              ),
            ),
          )
        ],
      );
    }
    return Center(child: Text(item.title ?? '', style: textStyle));
  }
}
