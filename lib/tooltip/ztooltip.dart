import 'package:flutter/material.dart';
import 'package:uikit/uikit_lib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-04-30
/// create_time: 14:37
/// describe: 自定义任何可响应的提示组件
///eg:
//        ZTooltip(
//           color: Colors.black54,
//           width: 220,
//           height: 60,
//           fixedTip: true,
//           controller: controller,
//           duration: const Duration(
//               milliseconds: 500
//           ),
//           length: 100,
//           buildTip: () => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
//             child: Row(
//               children: [
//                 ...['翻译','查询','下载','取消']
//                     .map((e) =>GestureDetector(
//                   onTap: (){
//
//                     RenderBox renderBox = tip.context.findRenderObject() as RenderBox;
//                     final offset = renderBox.localToGlobal(Offset.zero);
//                     Toast.showCustomPoint(
//                     buildToastPoint: (context,style){
//                       return Positioned(
//                         child:style.call(context,'点击了$e'),
//                         left: offset.dx, top: offset.dy+60,);
//                     });
//
//                     controller.close();
//                   },
//                   child:  Row(
//                     children: [
//                       Text(e,style: TextStyle(color: Colors.white,fontSize: 16)),
//                       Visibility(
//                           visible: e != '取消',
//                           child: Container(
//                             margin: EdgeInsets.only(left: 10,top: 4,right: 10),
//                             color: Colors.white,
//                             height: 15,
//                             width: 1,
//                           ))
//                     ],
//                   ),
//                 )).toList(),
//               ],
//             ),
//           ),
//           //需要自定义位置可实现该方法。
//           layout: (offset,child,size){
//             return Positioned(
//                 left: offset.dx,
//                 top: offset.dy+size.height,
//                 child: child);
//           },
//         child: const Text('自定义Tooltip组件')
//       ),

typedef BuildTip = Widget Function();

// 自定义 tip的显示位置
// @param zTooltip   ZTooltip组件实例
// @param offset  组件相对于父组件的偏移
// @param child   tip组件
// @param parentSize 父组件大小
typedef TipViewLayout = Positioned Function(
    Offset offset, Widget child, Size parentSize);

class ZTooltip extends StatefulWidget {
  final ZToolTipController? controller;

  //提示窗组件外部自定义
  final BuildTip? buildTip;

  //是否启用气泡
  final bool enableBubble;

  //tip组件是否固定
  final bool fixedTip;

  //鼠标离开多少时间后消失tip
  final Duration duration;

  //可自定义显示位置
  final TipViewLayout? layout;

  //正常显示的组件
  final Widget child;

  //是否激活鼠标响应 tip
  final bool canOnHover;
  //圆角
  final double tipRadius;
  //箭头宽
  final double arrowWidth;
  //箭头高
  final double arrowHeight;
  //位置上的偏移（0-1）
  final double arrowPositionPercent;
  // 箭头方向
  final BubbleArrowDirection direction;
  // 箭头形状
  final BubbleArrowShape arrowShape;
  // 箭头大小是否自适应
  final bool arrowAdaptive;
  //气泡装饰器
  final BoxDecoration? decoration;
  //裁剪
  final Clip clipBehavior;
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

  const ZTooltip(
      {required this.child,
      this.controller,
      this.buildTip,
      this.enableBubble = true,
      this.fixedTip = false,
      this.duration = const Duration(seconds: 0),
      this.layout,
      this.canOnHover = true,
      this.tipRadius = 8,
      this.arrowWidth = 12,
      this.arrowHeight = 8,
      this.arrowPositionPercent = 0.5,
      this.direction = BubbleArrowDirection.top,
      this.arrowShape = BubbleArrowShape.triangle,
      this.arrowAdaptive = true,
      this.decoration,
      this.clipBehavior = Clip.none,
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
      this.onHover,
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
  State<ZTooltip> createState() => ZTooltipState();
}

class ZTooltipState extends State<ZTooltip> {
  bool _onHover = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.controller?.bind(this);
  }

  void _showTooltip({required RenderBox renderBox}) {
    if (_overlayEntry != null) {
      return;
    }
    final target = renderBox.localToGlobal(Offset.zero);
    final parentSize = renderBox.size;
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final child = widget.enableBubble
            ? Bubble(
                radius: widget.tipRadius,
                arrowWidth: widget.arrowWidth,
                arrowHeight: widget.arrowHeight,
                arrowPositionPercent: widget.arrowPositionPercent,
                direction: widget.direction,
                arrowShape: widget.arrowShape,
                arrowAdaptive: widget.arrowAdaptive,
                decoration: widget.decoration,
                clipBehavior: widget.clipBehavior,
                child: widget.buildTip?.call() ?? const SizedBox())
            : widget.buildTip?.call() ?? const SizedBox();

        final tipView = widget.layout?.call(target, child, parentSize) ??
            Positioned(
              left: target.dx,
              top: target.dy + parentSize.height,
              child: child,
            );
        return tipView;
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void didUpdateWidget(covariant ZTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?.bind(this);
    }
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void close() {
    Future.delayed(widget.duration, () {
      _hideTooltip();
    });
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }

  void toggle(bool onHover) {
    setState(() {
      _onHover = onHover;
      if (_onHover && _overlayEntry == null) {
        //获取当前控件在屏幕上的坐标
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        _showTooltip(renderBox: renderBox);
        return;
      }
      if (widget.fixedTip) {
        return;
      }
      close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (onHover) {
        widget.onHover?.call(onHover);
        if (widget.canOnHover) {
          toggle(onHover);
        }
      },
      onTap: widget.onTap ?? () {},
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
      child: widget.child,
    );
  }
}

class ZToolTipController {

  ZTooltipState? _state;

  ZTooltipState? get state => _state;

  bool onHover = false;

  void bind(ZTooltipState state) {
    _state = state;
  }

  void dispose() {
    _state = null;
  }

  void toggle(){
    onHover = !onHover;
    _state?.toggle(onHover);
  }

  RenderBox? getRenderBox() {
    final obj = _state?.context.findRenderObject();
    if (obj != null) {
      return obj as RenderBox;
    }
    return null;
  }

  void close() {
    if (_state != null) {
      _state?.close();
    }
  }
}
