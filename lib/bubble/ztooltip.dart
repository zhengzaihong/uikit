import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/bubble/bubble_arrow_direction.dart';
import 'bubble.dart';

class ZTooltip extends StatefulWidget {

  final Widget? tip;
  final Widget child;
  final bool enabledOnHover;

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

  const ZTooltip({
    required this.child,
    this.tip,
    this.enabledOnHover = true,
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
    Key? key}):super(key: key);

  @override
  State<ZTooltip> createState() => _ZTooltipState();
}

class _ZTooltipState extends State<ZTooltip> {

  bool _onHover = false;
  OverlayEntry? _overlayEntry;
  Offset? _target;

  void _showTooltip({Offset? target}) {
    if(_overlayEntry!=null){
      return;
    }
    _target = target;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: _target!.dx+60,
        top: _target!.dy,
        child: SizedBox(
          width: 100,
          height: 40,
          child: Bubble(
            width: 200,
            height: 40,
            length: 30,
            color:Colors.tealAccent.withOpacity(0.7),
            position:BubbleArrowDirection.top,
            child: widget.tip,
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (onHover) {
        widget.onHover?.call(onHover);
        if (widget.enabledOnHover) {
          setState(() {
            _onHover = onHover;
            if(_onHover){
              ///获取当前控件在屏幕上的坐标
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              Offset _target = renderBox.localToGlobal(Offset.zero);
              _showTooltip(target: _target);
              return;
            }
            _hideTooltip();
          });
        }
      },
      onTap: widget.onTap??() {},
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