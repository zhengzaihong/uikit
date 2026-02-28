import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-04-30
/// create_time: 14:37
/// describe: 自定义Tooltip提示组件 - 支持任意响应式提示内容
/// Enterprise-level custom Tooltip component - Supports any responsive tooltip content
///
/// ✨ 功能特性 / Features:
/// • 🎨 完全自定义 - 提示内容完全由开发者控制
/// • 🎈 气泡样式 - 内置气泡效果,支持箭头方向配置
/// • 📍 灵活定位 - 支持自定义显示位置
/// • 🖱️ 多种触发 - 支持悬停、点击等交互方式
/// • ⏱️ 延迟控制 - 可配置显示和隐藏延迟
/// • 🔒 固定模式 - 支持固定显示不自动隐藏
/// • 🎯 精确控制 - 提供Controller进行外部控制
/// • 🎪 丰富样式 - 支持自定义装饰、圆角、阴影等
///
/// 📖 使用示例 / Usage Examples:
///
/// ```dart
/// // 示例1: 基础Tooltip提示
/// // Example 1: Basic tooltip
/// ZTooltip(
///   buildTip: () => Container(
///     padding: EdgeInsets.all(8),
///     decoration: BoxDecoration(
///       color: Colors.black87,
///       borderRadius: BorderRadius.circular(4),
///     ),
///     child: Text(
///       '这是提示内容',
///       style: TextStyle(color: Colors.white),
///     ),
///   ),
///   child: Text('悬停查看提示'),
/// )
///
/// // 示例2: 自定义操作菜单
/// // Example 2: Custom action menu
/// final controller = ZToolTipController();
/// 
/// ZTooltip(
///   color: Colors.black54,
///   width: 220,
///   height: 60,
///   fixedTip: true,
///   controller: controller,
///   duration: const Duration(milliseconds: 500),
///   buildTip: () => Padding(
///     padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
///     child: Row(
///       children: [
///         ...['翻译', '查询', '下载', '取消'].map((e) => GestureDetector(
///           onTap: () {
///             print('点击了$e');
///             controller.close();
///           },
///           child: Row(
///             children: [
///               Text(e, style: TextStyle(color: Colors.white, fontSize: 16)),
///               if (e != '取消')
///                 Container(
///                   margin: EdgeInsets.only(left: 10, top: 4, right: 10),
///                   color: Colors.white,
///                   height: 15,
///                   width: 1,
///                 ),
///             ],
///           ),
///         )).toList(),
///       ],
///     ),
///   ),
///   child: const Text('自定义Tooltip组件'),
/// )
///
/// // 示例3: 自定义位置布局
/// // Example 3: Custom position layout
/// ZTooltip(
///   buildTip: () => Container(
///     padding: EdgeInsets.all(10),
///     color: Colors.blue,
///     child: Text('自定义位置'),
///   ),
///   layout: (offset, child, size) {
///     return Positioned(
///       left: offset.dx,
///       top: offset.dy + size.height + 10,
///       child: child,
///     );
///   },
///   child: Icon(Icons.info),
/// )
///
/// // 示例4: 不带气泡的纯内容提示
/// // Example 4: Pure content tooltip without bubble
/// ZTooltip(
///   enableBubble: false,
///   buildTip: () => Card(
///     child: Padding(
///       padding: EdgeInsets.all(12),
///       child: Text('纯内容提示'),
///     ),
///   ),
///   child: Text('悬停显示'),
/// )
///
/// // 示例5: 固定显示的Tooltip
/// // Example 5: Fixed tooltip (won't auto hide)
/// ZTooltip(
///   fixedTip: true,
///   canOnHover: false,
///   buildTip: () => Container(
///     padding: EdgeInsets.all(8),
///     color: Colors.orange,
///     child: Text('点击显示,不会自动隐藏'),
///   ),
///   onTap: () {
///     // 手动控制显示/隐藏
///   },
///   child: ElevatedButton(
///     onPressed: () {},
///     child: Text('点击显示'),
///   ),
/// )
///
/// // 示例6: 使用Controller外部控制
/// // Example 6: External control with controller
/// final controller = ZToolTipController();
/// 
/// Column(
///   children: [
///     ZTooltip(
///       controller: controller,
///       buildTip: () => Text('提示内容'),
///       child: Text('目标组件'),
///     ),
///     ElevatedButton(
///       onPressed: () => controller.toggle(),
///       child: Text('切换显示'),
///     ),
///   ],
/// )
/// ```
///
/// ⚠️ 注意事项 / Notes:
/// • 提示内容通过buildTip回调自定义,完全由开发者控制
/// • fixedTip为true时,提示不会自动隐藏,需手动关闭
/// • 使用Controller可以实现外部控制显示/隐藏
/// • layout参数可以完全自定义提示的显示位置
/// • enableBubble控制是否使用气泡样式
/// • 气泡箭头方向通过direction参数配置
/// • 建议合理设置duration避免提示闪烁
///

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
