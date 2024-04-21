import 'package:flutter/material.dart';
import 'function_container.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:11
/// describe: 封装一个功能按钮组件 背景切换 功能组件 顶层需要FunctionContainer包装
///
///
class FunctionButton extends StatefulWidget {
  final TextStyle checkedTextStyle;
  final TextStyle unCheckTextStyle;
  final BoxDecoration checkedBoxDecoration;
  final BoxDecoration unCheckedBoxDecoration;
  final int index;
  final String title;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final Color highlightColor;
  final Color hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final double? radius;

  const FunctionButton(
    this.title,
    this.index, {
    this.checkedTextStyle =
        const TextStyle(color: Colors.lightBlue, fontSize: 20),
    this.unCheckTextStyle = const TextStyle(color: Colors.black, fontSize: 20),
    this.checkedBoxDecoration = const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.unCheckedBoxDecoration = const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.width = 20,
    this.height = 20,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.alignment = Alignment.center,
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.focusColor,
    this.splashColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  _FunctionButtonState createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  @override
  Widget build(BuildContext context) {
    final containerManger = FunctionContainer.of(context);
    final checkeds = containerManger?.defaultChecks;
    final allow = containerManger?.allowMultipleChoice;
    final check = containerManger?.defaultCheck;

    Decoration decoration;
    TextStyle style;

    if (allow!) {
      if (checkeds!.contains(widget.index)) {
        decoration = widget.checkedBoxDecoration;
        style = widget.checkedTextStyle;
      } else {
        decoration = widget.unCheckedBoxDecoration;
        style = widget.unCheckTextStyle;
      }
    } else {
      if (check == widget.index) {
        decoration = widget.checkedBoxDecoration;
        style = widget.checkedTextStyle;
      } else {
        decoration = widget.unCheckedBoxDecoration;
        style = widget.unCheckTextStyle;
      }
    }

    return InkWell(
        highlightColor: widget.highlightColor,
        hoverColor: widget.hoverColor,
        focusColor: widget.focusColor,
        splashColor: widget.splashColor,
        radius: widget.radius,
        onTap: () {
          containerManger?.mangerState?.updateChange(widget.index);
        },
        child: Container(
            padding: widget.padding,
            margin: widget.margin,
            alignment: widget.alignment,
            width: widget.width,
            height: widget.height,
            decoration: decoration,
            child: Text(widget.title, style: style)));
  }
}
