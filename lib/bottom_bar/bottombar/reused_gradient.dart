

import 'package:flutter/painting.dart';

/// Wrapper for [Gradient], we don't want to re-create instance frequently in
/// hot method, such as paint().
class ReusedGradient {
  Gradient? _gradient;

  Shader? _shader;
  Rect? _size;

  /// Create gradient
  ReusedGradient();

  /// Setter to reset the [Gradient] instance
  set gradient(Gradient? gradient) {
    _gradient = gradient;
    _size = null;
  }

  /// Update the paint with provided size
  void updateWith(Paint paint, {Rect? size}) {
    if (size == _size || size == null) {
      return;
    }
    if (_gradient == null) {
      return;
    }
    _shader ??= _gradient!.createShader(size);
    paint.shader = _shader;
    _size = size;
  }

  /// check if the gradient is valid or not
  bool get valid {
    return _size != null && _gradient != null;
  }
}
