import 'package:flutter/material.dart';
import 'package:uikit/functionbutton/function_container.dart';

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
      this.height = 20,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.alignment = Alignment.center,
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
        child: Container(
            padding: widget.padding,
            margin: widget.margin,
            alignment: widget.alignment,
            width: widget.width,
            height: widget.height,
            child: widget.radioStart
                ? Row(
                    children: [
                      radio,
                      Padding(
                          padding: widget.padding,
                          child: Text(widget.title, style: style)),
                    ],
                  )
                : Row(
                    children: [
                      Padding(
                          padding: widget.padding,
                          child: Text(widget.title, style: style)),
                      radio
                    ],
                  )));
  }
}
