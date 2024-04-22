import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/2/2
/// create_time: 16:51
/// describe: 仿前端 js 鼠标事件可修改文字样式的文本组件
///
// 基础示例：
//     TextExtend(
//         text:"测试文本鼠标效果 item $index",
//         onTap: (){
//
//         },
//         isSelectable: false,
//         padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
//         onHoverPadding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
//         borderRadius: BorderRadius.circular(50),
//         splashColor: Colors.purple,
//         highlightColor: Colors.purple,
//         onHoverPrefix: const Icon(Icons.access_alarm),
//         onHoverSuffix:const Icon(Icons.account_circle,color: Colors.blue),
//         suffix: const Icon(Icons.account_circle),
//         decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(
//                 color: Colors.purple,
//                 width: 1
//             )
//         ),
//         onHoverDecoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(
//                 color: Colors.white,
//                 width: 1
//             )
//         ),
//         style: const TextStyle(
//             fontSize: 18,
//             color: Colors.black,
//             fontWeight: FontWeight.bold
//         ),
//         onHoverStyle: const TextStyle(
//             fontSize: 18,
//             color: Colors.blue,
//             fontWeight: FontWeight.bold
//         ),
//       )

///自定义内部子组件 子组件需要单独实现样式配置
typedef BuilderChild = Widget? Function(BuildContext context, Widget child, bool isHover);

///子组件内部对齐方式不满足时可重新改方法
typedef CustomChildLayout = Widget Function(BuildContext context, Widget prefix, Widget child, Widget suffix);


class TextExtend extends StatefulWidget {
  final TextStyle? style;
  final TextStyle? onHoverStyle;
  final String? text;
  final bool enabledOnHover;
  final bool isSelectable;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? onHoverPrefix;
  final Widget? onHoverSuffix;
  final double? width;
  final double? height;
  final BuilderChild? builder;
  final CustomChildLayout? customChildLayout;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  final AlignmentGeometry? onHoverAlignment;
  final EdgeInsetsGeometry? onHoverPadding;
  final Color? onHoverColor;
  final Decoration? onHoverDecoration;
  final Decoration? onHoverForegroundDecoration;
  final BoxConstraints? onHoverConstraints;
  final EdgeInsetsGeometry? onHoverMargin;
  final Matrix4? onHoverTransform;
  final AlignmentGeometry? onHoverTransformAlignment;

  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onTapCancel;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onSecondaryTap;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCallback? onSecondaryTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final ValueChanged<bool>? onHover;

  final MouseCursor? mouseCursor;
  final bool containedInkWell;
  final BoxShape highlightShape;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool canRequestFocus;


  const TextExtend({this.text,
    this.onHover,
    this.enabledOnHover = true,
    this.style,
    this.onHoverStyle,
    this.isSelectable = false,
    this.suffix,
    this.prefix,
    this.onHoverSuffix,
    this.onHoverPrefix,
    this.width,
    this.height,
    this.builder,
    this.customChildLayout,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.onHoverAlignment,
    this.onHoverPadding,
    this.onHoverColor,
    this.onHoverDecoration,
    this.onHoverForegroundDecoration,
    this.onHoverConstraints,
    this.onHoverMargin,
    this.onHoverTransform,
    this.onHoverTransformAlignment,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onHighlightChanged,
    this.mouseCursor,
    this.containedInkWell = false,
    this.highlightShape = BoxShape.circle,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.focusNode,
    this.canRequestFocus = true,
    this.onFocusChange,
    this.autofocus = false,
    Key? key})
      : super(key: key);

  @override
  State<TextExtend> createState() => _TextExtendState();
}

class _TextExtendState extends State<TextExtend> {
  bool _onHover = false;

  @override
  Widget build(BuildContext context) {
    final child = widget.isSelectable
        ? SelectableText(
      widget.text ?? '',
      style: _onHover
          ? widget.onHoverStyle ?? widget.style
          : widget.style,
    )
        : Text(
      widget.text ?? '',
      style: _onHover
          ? widget.onHoverStyle ?? widget.style
          : widget.style,
    );

    return InkWell(
      onHover: (onHover) {
        widget.onHover?.call(onHover);
        if (widget.enabledOnHover) {
          setState(() {
            _onHover = onHover;
          });
        }
      },
      onTap: widget.onTap,
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      onDoubleTap: widget.onDoubleTap,
      onLongPress: widget.onLongPress,
      mouseCursor: widget.mouseCursor,
      radius: widget.radius,
      borderRadius: widget.borderRadius,
      customBorder: widget.customBorder,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      highlightColor: widget.highlightColor,
      overlayColor: widget.overlayColor,
      splashColor: widget.splashColor,
      splashFactory: widget.splashFactory,
      enableFeedback: widget.enableFeedback,
      excludeFromSemantics: widget.excludeFromSemantics,
      focusNode: widget.focusNode,
      canRequestFocus: widget.canRequestFocus,
      onFocusChange: widget.onFocusChange,
      autofocus: widget.autofocus,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: _onHover
            ? widget.onHoverAlignment ?? widget.alignment
            : widget.alignment,
        padding: _onHover
            ? widget.onHoverPadding ?? widget.padding
            : widget.padding,
        color:
        _onHover ? widget.onHoverColor ?? widget.color : widget.color,
        decoration: _onHover
            ? widget.onHoverDecoration ?? widget.decoration
            : widget.decoration,
        foregroundDecoration: _onHover
            ? widget.onHoverForegroundDecoration ??
            widget.foregroundDecoration
            : widget.foregroundDecoration,
        constraints: _onHover
            ? widget.onHoverConstraints ?? widget.constraints
            : widget.constraints,
        margin: _onHover
            ? widget.onHoverMargin ?? widget.margin
            : widget.margin,
        transform: _onHover
            ? widget.onHoverTransform ?? widget.transform
            : widget.transform,
        transformAlignment: _onHover
            ? widget.onHoverTransformAlignment ?? widget.transformAlignment
            : widget.transformAlignment,
        child: widget.builder?.call(context, child,_onHover) ??
            (widget.customChildLayout == null ? Row(
              mainAxisAlignment: widget.mainAxisAlignment,
              mainAxisSize: widget.mainAxisSize,
              crossAxisAlignment: widget.crossAxisAlignment,
              verticalDirection: widget.verticalDirection,
              textDirection: widget.textDirection,
              textBaseline: widget.textBaseline,
              children: [
                (_onHover ? widget.onHoverPrefix : widget.prefix) ??
                    const SizedBox(),
                child ,
                (_onHover ? widget.onHoverSuffix : widget.suffix) ??
                    const SizedBox(),
              ],
            ) : widget.customChildLayout == null ? child : widget.customChildLayout!(
                context,
                (_onHover ? widget.onHoverPrefix : widget.prefix) ??
                    const SizedBox(),
                child,
                (_onHover?widget.onHoverSuffix:widget.suffix) ??
                    const SizedBox())),
      ),);
  }
}
