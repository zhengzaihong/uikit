

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Decorate the provided [Image] or [IconData].
class BlendImageIcon<T> extends StatelessWidget {
  /// Create image widget
  const BlendImageIcon(this.image, {Key? key, this.color, this.size})
      : assert(image is Widget || image is IconData,
            'image must be IconData or Widget'),
        super(key: key);

  /// Color used for Icon and gradient.
  final Color? color;

  /// Child image.
  final T image;

  /// Size of icon.
  final double? size;

  @override
  Widget build(BuildContext context) {
    var s = size ?? IconTheme.of(context).size;
    if (image is Widget) {
      // flutter web do not support shader mask. (flutter v1.12.x)
      var showRawImage = kIsWeb || color == null;
      if (showRawImage) {
        return SizedBox(
          width: s,
          height: s,
          child: image as Widget,
        );
      }
      return SizedBox(
        width: s,
        height: s,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(colors: [color!, color!])
                .createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: image as Widget,
        ),
      );
    }
    return Icon(image as IconData, size: s, color: color);
  }
}
