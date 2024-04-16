import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-02-01
/// create_time: 14:58
/// describe: 极简系统下拉框，可高度自定义，且规避系统组件的使用麻烦，SelectionMenu不关心数据。
///
final RouteObserver<ModalRoute<void>> dropDownButtonRouteObserver =
    RouteObserver<ModalRoute<void>>();

typedef DropDownButtonBuilder<T> = Widget Function(bool show);
typedef DropDownPopCreated = void Function();
typedef DropDownPopShow = void Function();
typedef DropDownPopDismiss = void Function();

class SelectionMenu extends StatefulWidget {
  /// 下拉框构建器
  final DropDownButtonBuilder? buttonBuilder;

  /// 下拉框创建
  final DropDownPopCreated? onCreated;

  /// 下拉框显示
  final DropDownPopShow? onShow;

  /// 下拉框消失
  final DropDownPopDismiss? onDismiss;

  /// 是否开启鼠标悬浮
  final bool enableOnHover;

  ///是否是居中模式 默认左对齐
  final bool popCenter;

  /// 下拉框宽度 弹窗部分
  final double? popWidth;

  /// 下拉框样式构件 弹出部分
  final WidgetBuilder selectorBuilder;

  /// 阴影
  final double? elevation;

  /// 阴影颜色
  final Color? shadowColor;
  final String? barrierLabel;
  final Color? barrierColor;

  /// 是否允许点击其他区域消失
  final bool barrierDismissible;

  /// 动画时间
  final Duration transitionDuration;

  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final ValueChanged<bool>? onHover;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final bool? enableFeedback;
  final bool excludeFromSemantics;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;

  const SelectionMenu(
      {required this.selectorBuilder,
      required this.buttonBuilder,
      this.onCreated,
      this.onShow,
      this.onDismiss,
      this.enableOnHover = false,
      this.popWidth,
      this.popCenter = false,
      this.elevation,
      this.shadowColor,
      this.barrierLabel,
      this.barrierColor,
      this.barrierDismissible = true,
      this.transitionDuration = const Duration(milliseconds: 200),
      this.onDoubleTap,
      this.onLongPress,
      this.onTapDown,
      this.onTapUp,
      this.onTapCancel,
      this.onHighlightChanged,
      this.onHover,
      this.mouseCursor,
      this.focusColor,
      this.hoverColor,
      this.highlightColor,
      this.overlayColor,
      this.splashColor,
      this.splashFactory,
      this.radius,
      this.borderRadius,
      this.customBorder,
      this.enableFeedback = true,
      this.excludeFromSemantics = false,
      this.focusNode,
      this.canRequestFocus = true,
      this.onFocusChange,
      this.autofocus = false,
      Key? key})
      : super(key: key);

  @override
  State<SelectionMenu> createState() => _SelectionMenuState();
}

class _SelectionMenuState extends State<SelectionMenu> with RouteAware {
  bool _popShowIng = false;
  StateSetter? _innerStateSetter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dropDownButtonRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    dropDownButtonRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    widget.onCreated?.call();
  }

  @override
  void didPushNext() {
    widget.onShow?.call();
    _popShowIng = true;
    _innerStateSetter?.call(() {});
  }

  @override
  void didPopNext() {
    widget.onDismiss?.call();
    _popShowIng = false;
    _innerStateSetter?.call(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, onState) {
      _innerStateSetter = onState;
      return InkWell(
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        onTapDown: widget.onTapDown,
        onTapUp: widget.onTapUp,
        onTapCancel: widget.onTapCancel,
        onHighlightChanged: widget.onHighlightChanged,
        mouseCursor: widget.mouseCursor,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        highlightColor: widget.highlightColor,
        overlayColor: widget.overlayColor,
        splashColor: widget.splashColor,
        splashFactory: widget.splashFactory,
        radius: widget.radius,
        borderRadius: widget.borderRadius,
        customBorder: widget.customBorder,
        enableFeedback: widget.enableFeedback,
        excludeFromSemantics: widget.excludeFromSemantics,
        focusNode: widget.focusNode,
        canRequestFocus: widget.canRequestFocus,
        onFocusChange: widget.onFocusChange,
        autofocus: widget.autofocus,
        onHover: (hover) {
          if (hover && widget.enableOnHover) {
            _showSelection(context);
            return;
          }
        },
        onTap: () {
          if (_popShowIng) {
            return;
          }
          _showSelection(context);
        },
        child: widget.buttonBuilder?.call(_popShowIng),
      );
    });
  }

  void _showSelection(BuildContext context) {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    Offset offset = Offset(0.0, button.size.height);
    double centerX = 0;
    if (widget.popWidth != null && widget.popCenter) {
      centerX = widget.popWidth! / 2 - button.size.width / 2;
      if(centerX < 0) centerX==0;
   }

    RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Rect.fromPoints(
        Offset(widget.popCenter?centerX:0, 0),
        Offset(widget.popWidth!, 0),
      ),
    );

    Navigator.of(context).push(_CustomPopupRoute(
        position: position,
        popWidth: widget.popWidth,
        builder: widget.selectorBuilder,
        elevation: widget.elevation,
        shadowColor: widget.shadowColor,
        barrierColor: widget.barrierColor,
        barrierDismissible: widget.barrierDismissible,
        transitionDuration: widget.transitionDuration,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel));
  }
}

class _CustomPopupRoute<T> extends PopupRoute<T> {
  final WidgetBuilder builder;
  final RelativeRect position;
  final double? elevation;
  final Color? shadowColor;
  @override
  final String? barrierLabel;
  @override
  final Color? barrierColor;
  @override
  final bool barrierDismissible;
  @override
  final Duration transitionDuration;
  final double? popWidth;

  _CustomPopupRoute({
    required this.builder,
    required this.position,
    required this.barrierLabel,
    this.elevation,
    this.shadowColor,
    this.barrierColor,
    this.barrierDismissible = true,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.popWidth,
  });

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    final CurveTween heightFactorTween =
        CurveTween(curve: const Interval(0.0, 1.0));
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: CustomSingleChildLayout(
        delegate: _CustomPopupRouteLayout(position, padding),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Material(
                child: _HeightFactorBox(
              heightFactor: heightFactorTween.evaluate(animation),
              child: child,
            ));
          },
          child: SizedBox(
            width: popWidth,
            child: builder(context),
          ),
        ),
      ),
    );
  }
}

class _CustomPopupRouteLayout extends SingleChildLayoutDelegate {
  final RelativeRect position;
  EdgeInsets padding;
  double childHeightMax = 0;

  _CustomPopupRouteLayout(this.position, this.padding);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    Size buttonSize = position.toSize(constraints.biggest);

    double constraintsWidth = buttonSize.width;
    double constraintsHeight = max(
        position.top - buttonSize.height - padding.top - kToolbarHeight,
        constraints.biggest.height - position.top - padding.bottom);

    return BoxConstraints.loose(Size(constraintsWidth, constraintsHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = position.left;
    double y = position.top;
    final double buttonHeight = size.height - position.top - position.bottom;
    double constraintsHeight = max(
        position.top - buttonHeight - padding.top - kToolbarHeight,
        size.height - position.top - padding.bottom);
    if (position.top + constraintsHeight > size.height - padding.bottom) {
      y = position.top - childSize.height - buttonHeight;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(covariant _CustomPopupRouteLayout oldDelegate) {
    return position != oldDelegate.position || padding != oldDelegate.padding;
  }
}

class _RenderHeightFactorBox extends RenderShiftedBox {
  double _heightFactor;

  _RenderHeightFactorBox({
    RenderBox? child,
    double? heightFactor,
  })  : _heightFactor = heightFactor ?? 1.0,
        super(child);

  double get heightFactor => _heightFactor;

  set heightFactor(double value) {
    if (_heightFactor == value) {
      return;
    }
    _heightFactor = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    if (child == null) {
      size = constraints.constrain(Size.zero);
      return;
    }

    child!.layout(constraints, parentUsesSize: true);

    size = constraints.constrain(Size(
      child!.size.width,
      child!.size.height,
    ));

    child!.layout(
        constraints.copyWith(
            maxWidth: size.width, maxHeight: size.height * heightFactor),
        parentUsesSize: true);

    size = constraints.constrain(Size(
      child!.size.width,
      child!.size.height,
    ));
  }
}

class _HeightFactorBox extends SingleChildRenderObjectWidget {
  final double? heightFactor;

  const _HeightFactorBox({this.heightFactor, Widget? child, Key? key})
      : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderHeightFactorBox(heightFactor: heightFactor);

  @override
  void updateRenderObject(
      BuildContext context, _RenderHeightFactorBox renderObject) {
    renderObject.heightFactor = heightFactor ?? 1.0;
  }
}
