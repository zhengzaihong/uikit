import 'package:flutter/material.dart';

class FontIcon extends StatelessWidget {
  final int codePoint;
  final double? size;
  final Color? color;

  const FontIcon(this.codePoint, {this.size, this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(codePoint),
      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontFamily: 'iconfont',
        fontSize: size ?? 20,
        color: color ?? Colors.white,
      ),
    );
  }
}
