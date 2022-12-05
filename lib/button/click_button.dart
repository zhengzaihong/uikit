import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/button/function_container.dart';
import 'package:flutter_uikit_forzzh/src/position_enum.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/1
/// create_time: 9:40
/// describe: 封装一个功能按钮组件 背景切换 功能组件 顶层需要FunctionContainer包装
/// 支持 上下左右 添加其他元素的组件
///
class ClickButton extends StatefulWidget {
  final TextStyle checkedTextStyle;
  final TextStyle unCheckTextStyle;
  final BoxDecoration checkedBoxDecoration;
  final BoxDecoration unCheckedBoxDecoration;
  final int index;
  final String title;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;

  final Color highlightColor;
  final Color hoverColor;

  final double drawPadding;

  ///通常设置的图标 （选中和未选中支持）
  final Widget? drawableWidget;
  final Widget? drawablePressWidget;

  ///图标显示位置
  final PositionEnum drawablePositon;

  ///是否可点击
  final bool enableClick;


  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const ClickButton({
    required this.title,
    required this.index,
    this.checkedTextStyle = const TextStyle(color: Colors.white, fontSize: 20),
    this.unCheckTextStyle =
    const TextStyle(color: Colors.black38, fontSize: 20),
    this.checkedBoxDecoration = const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.unCheckedBoxDecoration = const BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.width = 20,
    this.height = 20,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.alignment = Alignment.center,
    this.drawPadding = 5.0,
    this.drawablePositon = PositionEnum.drawableRight,
    this.drawableWidget,
    this.drawablePressWidget,
    this.enableClick = true,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    Key? key,
  }) : super(key: key);

  @override
  _ClickButtonState createState() => _ClickButtonState();
}

class _ClickButtonState extends State<ClickButton> {
  Decoration? decoration;
  TextStyle? style;
  Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    final containerManger = FunctionContainer.of(context);
    final checkeds = containerManger?.defaultCheckeds;
    final allow = containerManger?.allowMultipleChoice;
    final check = containerManger?.defaultCheck;

    if (allow!) {
      if (checkeds!.contains(widget.index)) {
        decoration = widget.checkedBoxDecoration;
        style = widget.checkedTextStyle;
        iconWidget = widget.drawablePressWidget;
      } else {
        decoration = widget.unCheckedBoxDecoration;
        style = widget.unCheckTextStyle;
        iconWidget = widget.drawableWidget;
      }
    } else {
      if (check == widget.index) {
        decoration = widget.checkedBoxDecoration;
        style = widget.checkedTextStyle;
        iconWidget = widget.drawablePressWidget;
      } else {
        decoration = widget.unCheckedBoxDecoration;
        style = widget.unCheckTextStyle;
        iconWidget = widget.drawableWidget;
      }
    }

    return InkWell(
        highlightColor: widget.highlightColor,
        hoverColor: widget.hoverColor,
        onTap: () {
          if (widget.enableClick) {
            containerManger?.mangerState?.updateChange(widget.index);
          }
        },
        child: Container(
            padding: widget.padding,
            margin: widget.margin,
            alignment: widget.alignment,
            width: widget.width,
            height: widget.height,
            decoration: decoration,
            child: createButtonStyle()));
  }

  Widget createButtonStyle() {
    if (iconWidget != null) {
      switch (widget.drawablePositon) {
        case PositionEnum.drawableLeft:
          {

            return Row(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  iconWidget!,
                  SizedBox(width: widget.drawPadding),
                  Expanded(child: Text(
                      widget.title,
                      maxLines: widget.maxLines,
                      semanticsLabel: widget.semanticsLabel,
                      strutStyle: widget.strutStyle,
                      textAlign: widget.textAlign,
                      textDirection: widget.textDirection,
                      locale: widget.locale,
                      softWrap: widget.softWrap,
                      overflow:widget.overflow,
                      textScaleFactor: widget.textScaleFactor,
                      style: style))
                ]);
          }
        case PositionEnum.drawableRight:
          {
            return Row(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  Expanded(child: Text(
                      widget.title,
                      maxLines: widget.maxLines,
                      semanticsLabel: widget.semanticsLabel,
                      strutStyle: widget.strutStyle,
                      textAlign: widget.textAlign,
                      textDirection: widget.textDirection,
                      locale: widget.locale,
                      softWrap: widget.softWrap,
                      overflow:widget.overflow,
                      textScaleFactor: widget.textScaleFactor,
                      style: style)),
                  SizedBox(width: widget.drawPadding),
                  iconWidget!,
                ]);
          }
        case PositionEnum.drawableTop:
          {
            return Column(
              mainAxisSize: widget.mainAxisSize,
              crossAxisAlignment: widget.crossAxisAlignment,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: [
                iconWidget!,
                SizedBox(height: widget.drawPadding),
                Expanded(child: Text(
                    widget.title,
                    maxLines: widget.maxLines,
                    semanticsLabel: widget.semanticsLabel,
                    strutStyle: widget.strutStyle,
                    textAlign: widget.textAlign,
                    textDirection: widget.textDirection,
                    locale: widget.locale,
                    softWrap: widget.softWrap,
                    overflow:widget.overflow,
                    textScaleFactor: widget.textScaleFactor,
                    style: style))
              ],
            );
          }
        case PositionEnum.drawableBottom:
          {
            return Column(
              mainAxisSize: widget.mainAxisSize,
              crossAxisAlignment: widget.crossAxisAlignment,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: [
                Expanded(child: Text(
                    widget.title,
                    maxLines: widget.maxLines,
                    semanticsLabel: widget.semanticsLabel,
                    strutStyle: widget.strutStyle,
                    textAlign: widget.textAlign,
                    textDirection: widget.textDirection,
                    locale: widget.locale,
                    softWrap: widget.softWrap,
                    overflow:widget.overflow,
                    textScaleFactor: widget.textScaleFactor,
                    style: style)),
                SizedBox(height: widget.drawPadding),
                iconWidget!
              ],
            );
          }
      }
    }
    return  Text(
        widget.title,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow:widget.overflow,
        textScaleFactor: widget.textScaleFactor,
        style: style);
  }
}
