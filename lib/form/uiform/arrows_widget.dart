
import 'package:flutter/material.dart';

///自定义输入框右边箭头
abstract class ArrowsWidget extends StatelessWidget {
  Widget createArrow();
  @override
  Widget build(BuildContext context) {
    return createArrow();
  }
}
