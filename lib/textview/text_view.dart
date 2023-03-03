import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/src/position_enum.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/12
/// create_time: 17:23
/// describe: 上下左右支持 icon的Widget
///
class TextView extends StatefulWidget {
  final TextStyle checkedTextStyle;
  final TextStyle unCheckTextStyle;
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
  final Color highlightColor;
  final Color hoverColor;

  final double drawPadding;

  ///通常设置的图标 （选中和未选中支持）
  final Widget? drawableWidget;
  final Widget? drawablePressWidget;

  ///图标显示位置
  final PositionEnum drawablePosition;

  ///是否可点击
  final bool enableClick;

  final bool isChecked;

  final Function(bool checked)? callBack;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const TextView({
    required this.title,
    this.checkedTextStyle = const TextStyle(color: Colors.white, fontSize: 20),
    this.unCheckTextStyle =
        const TextStyle(color: Colors.black38, fontSize: 20),
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.drawPadding = 5.0,
    this.drawablePosition = PositionEnum.drawableRight,
    this.drawableWidget,
    this.drawablePressWidget,
    this.enableClick = true,
    this.isChecked = true,
    this.callBack,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    Key? key,
  }) : super(key: key);

  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {

  TextStyle? style;
  Widget? iconWidget;
  bool? isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    if (isChecked!) {
      style = widget.checkedTextStyle;
      iconWidget = widget.drawablePressWidget;
    } else {
      style = widget.unCheckTextStyle;
      iconWidget = widget.drawableWidget;
    }

    return widget.enableClick
        ? InkWell(
            highlightColor: widget.highlightColor,
            hoverColor: widget.hoverColor,
            onTap: () {
              setState(() {
                isChecked = !isChecked!;
                widget.callBack?.call(isChecked!);
              });
            },
            child: createButtonStyle())
        : createButtonStyle();
  }

  Widget createButtonStyle() {
    if (iconWidget != null) {
      switch (widget.drawablePosition) {
        case PositionEnum.drawableLeft:
          {
            return Row(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  iconWidget!,
                  SizedBox(width: widget.drawPadding),
                  Text(widget.title,
                      maxLines: widget.maxLines,
                      semanticsLabel: widget.semanticsLabel,
                      strutStyle: widget.strutStyle,
                      textAlign: widget.textAlign,
                      textDirection: widget.textDirection,
                      locale: widget.locale,
                      softWrap: widget.softWrap,
                      overflow:widget.overflow,
                      textScaleFactor: widget.textScaleFactor,
                      style: style)
                ]);
          }
        case PositionEnum.drawableRight:
          {
            return Row(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  Text(widget.title,
                      maxLines: widget.maxLines,
                      semanticsLabel: widget.semanticsLabel,
                      strutStyle: widget.strutStyle,
                      textAlign: widget.textAlign,
                      textDirection: widget.textDirection,
                      locale: widget.locale,
                      softWrap: widget.softWrap,
                      overflow:widget.overflow,
                      textScaleFactor: widget.textScaleFactor,
                      style: style),
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
                Text(widget.title,
                    maxLines: widget.maxLines,
                    semanticsLabel: widget.semanticsLabel,
                    strutStyle: widget.strutStyle,
                    textAlign: widget.textAlign,
                    textDirection: widget.textDirection,
                    locale: widget.locale,
                    softWrap: widget.softWrap,
                    overflow:widget.overflow,
                    textScaleFactor: widget.textScaleFactor,
                    style: style)
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
                Text(widget.title,
                    maxLines: widget.maxLines,
                    semanticsLabel: widget.semanticsLabel,
                    strutStyle: widget.strutStyle,
                    textAlign: widget.textAlign,
                    textDirection: widget.textDirection,
                    locale: widget.locale,
                    softWrap: widget.softWrap,
                    overflow:widget.overflow,
                    textScaleFactor: widget.textScaleFactor,
                    style: style),
                SizedBox(height: widget.drawPadding),
                iconWidget!
              ],
            );
          }
      }
    }
    return Text(widget.title, style: style);
  }
}
