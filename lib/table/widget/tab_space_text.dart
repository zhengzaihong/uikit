import 'package:flutter/material.dart';

/// 如果想让标题类的 左右对齐可使用该文本组件
/// 外部可直接使用该组件，
/// eg:  return TabSpaceText(
///  contents: KitMath.parseStr((cellBean.name).toString()),
///  padding: const EdgeInsets.only(left: 10,right: 10),
///  style: const TextStyle(fontSize: 14,color: Colors.black));
///
class TabSpaceText extends StatelessWidget {

  final List<String> contents;
  final TextStyle style;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const TabSpaceText(
      {Key? key,
        required this.contents,
        this.margin,
        this.padding,
        this.backgroundColor,
        this.width,
        this.height,
        this.alignment,
        this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
        this.crossAxisAlignment = CrossAxisAlignment.center,
        this.mainAxisSize = MainAxisSize.max,
        this.style = const TextStyle(color: Colors.red, fontSize: 12)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      alignment: alignment,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [...contents.map((e) => Text(e, style: style)).toList()],
      ),
    );
  }
}
