import 'package:flutter/material.dart';

import 'function_container.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:11
/// describe: 封装一个功能按钮组件 背景切换 功能组件 顶层需要FunctionContainer包装
///  解决系统自带的 Radio 的一些问题，此按钮组件不支持 多选功能，切勿设置。
/// 待完善...
///
class FunctionRadioButton extends StatefulWidget {
  final TextStyle checkedTextStyle;
  final TextStyle unCheckTextStyle;

  ///外部传入的图片样式组件
  final Widget checkedIconWidget;
  final Widget unCheckedWidget;
  final bool radioStart;
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

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const FunctionRadioButton(
      {this.title = "",
      this.index = 0,
      required this.checkedIconWidget,
      required this.unCheckedWidget,
      this.checkedTextStyle =
          const TextStyle(color: Color(0xffFF5400), fontSize: 12),
      this.unCheckTextStyle =
          const TextStyle(color: Color(0xff000000), fontSize: 12),
      this.radioStart = true,
      this.width = 100,
      this.height = 40,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.alignment = Alignment.center,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.min,
      this.highlightColor = Colors.transparent,
      this.hoverColor = Colors.transparent,
      this.focusColor,
      this.splashColor,
      this.radius,
      Key? key})
      : super(key: key);

  @override
  _FunctionRadioButtonState createState() => _FunctionRadioButtonState();
}

class _FunctionRadioButtonState extends State<FunctionRadioButton> {
  @override
  Widget build(BuildContext context) {
    final containerManger = FunctionContainer.of(context);
    final check = containerManger?.defaultCheck;

    TextStyle style;
    Widget radio;

    if (check == widget.index) {
      style = widget.checkedTextStyle;
      radio = widget.checkedIconWidget;
    } else {
      style = widget.unCheckTextStyle;
      radio = widget.unCheckedWidget;
    }

    return InkWell(
        onTap: () {
          containerManger?.mangerState?.updateChange(widget.index);
        },
        highlightColor: widget.highlightColor,
        hoverColor: widget.hoverColor,
        focusColor: widget.focusColor,
        splashColor: widget.splashColor,
        radius: widget.radius,
        child: Container(
            padding: widget.padding,
            margin: widget.margin,
            alignment: widget.alignment,
            width: widget.width,
            height: widget.height,
            child: widget.radioStart
                ? Row(
                    mainAxisSize: widget.mainAxisSize,
                    crossAxisAlignment: widget.crossAxisAlignment,
                    mainAxisAlignment: widget.mainAxisAlignment,
                    children: [
                      radio,
                      Padding(
                          padding: widget.padding,
                          child: Text(widget.title, style: style)),
                    ],
                  )
                : Row(
                    mainAxisSize: widget.mainAxisSize,
                    crossAxisAlignment: widget.crossAxisAlignment,
                    mainAxisAlignment: widget.mainAxisAlignment,
                    children: [
                      Padding(
                          padding: widget.padding,
                          child: Text(widget.title, style: style)),
                      radio
                    ],
                  )));
  }
}
