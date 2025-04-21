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

  // 默认和焦点时字体样式
  final TextStyle? style;
  final TextStyle? onHoverStyle;
  // 文本
  final String? text;
  // 能否响应鼠标事件
  final bool canOnHover;
  // 是否是可复制文本
  final bool isSelectable;
  // 默认和焦点时分别的前置和后置图标
  final Widget? prefix;
  final Widget? onHoverPrefix;
  final Widget? suffix;
  final Widget? onHoverSuffix;

  //最长文本长度
  final int? maxLength;
  // 组件宽高
  final double? width;
  final double? height;
  // 自定义子组件
  final BuilderChild? builder;
  // 自定义内部子组件对齐方式
  final CustomChildLayout? customChildLayout;

  // 是否开启动画
  final bool animation;
  // 动画时间
  final Duration animationTime;
  // 动画偏移量
  final Offset startOffset;
  final Offset endOffset;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  //alignment: Alignment.center 需要  mainAxisSize: MainAxisSize.min,
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
  final WidgetStateProperty<Color?>? overlayColor;
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
    this.canOnHover = true,
    this.style,
    this.onHoverStyle,
    this.isSelectable = false,
    this.suffix,
    this.prefix,
    this.onHoverSuffix,
    this.onHoverPrefix,
    this.maxLength,
    this.width,
    this.height,
    this.builder,
    this.customChildLayout,
    this.animation = false,
    this.animationTime = const Duration(milliseconds: 150),
    this.startOffset = const Offset(0, 0),
    this.endOffset = const Offset(0, -10),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,

    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textAlign,

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

class _TextExtendState extends State<TextExtend>  with SingleTickerProviderStateMixin{
  bool _onHover = false;

   AnimationController? controller;
   Animation<Offset>? _positionAnimation;

  @override
  void initState() {
    super.initState();

    if(widget.animation){
      controller = AnimationController(
        duration: widget.animationTime,
        vsync: this,
      );
      _positionAnimation =
          Tween<Offset>(begin:widget.startOffset, end: widget.endOffset)
              .animate(controller!);
    }
  }

  @override
  void dispose() {
    if(widget.animation){
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.text??'';
    if(widget.maxLength!=null&& text.length>widget.maxLength!){
      text = text.substring(0,widget.maxLength!);
    }
    final child = widget.isSelectable
        ? SelectableText(
      text,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      // locale: widget.locale,
      // softWrap: widget.softWrap,
      // overflow: widget.overflow,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      maxLines: widget.maxLines,
      style: _onHover
          ? widget.onHoverStyle ?? widget.style
          : widget.style,
    )
        : Text(
      text,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      maxLines: widget.maxLines,
      style: _onHover
          ? widget.onHoverStyle ?? widget.style
          : widget.style,
    );
    final textView =  Container(
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
          ) : widget.customChildLayout!(
              context,
              (_onHover ? widget.onHoverPrefix : widget.prefix) ??
                  const SizedBox(),
              child,
              (_onHover?widget.onHoverSuffix:widget.suffix) ??
                  const SizedBox())),
    );
    return InkWell(
      onHover: (onHover) {
        widget.onHover?.call(onHover);
        if (widget.canOnHover) {
          setState(() {
            _onHover = onHover;
             if(widget.animation){
               onHover?controller?.forward():controller?.reverse();
             }
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
      child:widget.animation?AnimatedBuilder(
        animation: _positionAnimation!,
        builder: (context, child) {
          return Transform.translate(
            offset: _positionAnimation!.value,
            child: child,
          );
        },
        child:textView,
      ):textView,);
  }
}
