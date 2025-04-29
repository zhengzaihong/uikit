import 'package:flutter/material.dart';

class FontIcon extends StatelessWidget {
  final int codePoint;
  final double? size;
  final Color? color;

  const FontIcon(this.codePoint, {this.size, this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(codePoint, fontFamily: "iconfont", matchTextDirection: true),
      color: color ?? Colors.white,
      size: size ?? 20,
    );
  }
}
