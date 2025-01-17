

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Tab item are flipped when click.
class FlipTabStyle extends InnerBuilder {
  /// Curve for flip transition.
  final Curve curve;

  /// Create style builder.
  FlipTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color color,
    required this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    var style = ofStyle(context);
    var textStyle = style.textStyle(activeColor, item.fontFamily);
    if (active) {
      var children = <Widget>[
        BlendImageIcon(
          item.activeIcon ?? item.icon,
          color: item.blend ? activeColor : null,
          size: style.activeIconSize,
        ),
      ];
      var noLabel = style.hideEmptyLabel && hasNoText(item);
      if (!noLabel) {
        children.add(Text(item.title ?? '', style: textStyle.copyWith(
            fontSize: 20,
            fontWeight:  FontWeight.w600
        )));
      }
      return TransitionContainer.flip(
        data: index,
        duration: Duration(milliseconds: 500),
        height: style.activeIconMargin + style.activeIconSize,
        bottomChild: Container(
          padding: EdgeInsets.only(bottom: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: children,
          ),
        ),
        topChild: Container(
          child: Center(
            child: BlendImageIcon(
              item.icon,
              color: item.blend ? color : null,
              size: style.iconSize,
            ),
          ),
        ),
        curve: curve,
      );
    }
    return Center(
      child: BlendImageIcon(
        item.icon,
        color: item.blend ? color : null,
        size: style.iconSize,
      ),
    );
  }
}
