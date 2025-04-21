import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_uikit_forzzh/select/select_fun.dart';
import 'drop_position.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-02-01
/// create_time: 14:58
/// describe: 极简系统下拉框，可高度自定义，且规避系统组件的使用麻烦，SelectionMenu不关心数据。
/// eg:
//     SelectionMenu(
//         popWidth: 200,
//         buttonBuilder: (show){
//           return Container(
//             height: 40,
//             width: 200,
//             alignment: Alignment.center,
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Text("请选择"),
//           );
//         },
//         selectorBuilder: (context) {
//           return Container(
//             height: 200,
//             margin: const EdgeInsets.only(top: 3),
//             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//             decoration:  BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(5),
//             ),
//             child: ListView.separated(
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: (){
//                     ///todo update ui ...
//                   },
//                   child: Text("item $index",style: TextStyle(fontSize: 16,color: Colors.black),),
//                 );
//               }, separatorBuilder: (BuildContext context, int index) {
//               return const Divider();
//             },),
//           );
//         }
//     )




class SelectionMenu extends StatefulWidget {

  final SelectionMenuController? controller;

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

  /// 是否开启点击
  final bool enableClick;

  ///当设置的宽度小于 父组件宽度时， 是否匹配父组件宽度，默认true
  final bool matchParentWidth;

  /// 下拉框样式构件 弹出部分
  final WidgetBuilder selectorBuilder;
  /// 自定义下拉框位置
  final LayoutSelectPop? layoutSelectPop;

  /// Material 背景样式
  final BorderRadiusGeometry? materialBorderRadius;
  final Color? color;
  final ShapeBorder? shape;
  /// 阴影
  final double elevation;
  /// 下拉框宽度 弹窗部分
  final double popWidth;
  ///窗口高度
  final double popHeight;
  ///垂直 边距
  final double vMargin;
  ///水平边距
  final double hMargin;


  /// 阴影颜色
  final Color? shadowColor;
  final String? barrierLabel;
  final Color? barrierColor;

  /// 是否允许点击其他区域消失
  final bool barrierDismissible;

  /// 动画时间
  final Duration transitionDuration;

  ///对齐方式
  final AlignType alignType;

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
  final WidgetStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;

  const SelectionMenu(
      {required this.selectorBuilder,
      required this.buttonBuilder,
      this.controller,
      this.layoutSelectPop,
      this.onCreated,
      this.onShow,
      this.onDismiss,
      this.enableOnHover = false,
      this.enableClick = true,
      this.matchParentWidth = true,
      this.popWidth = 0,
      this.hMargin = 0,
      this.vMargin = 0,
      this.popHeight = 200,
      this.materialBorderRadius,
      this.color = Colors.transparent,
      this.shape,
      this.elevation = 0.0,
      this.shadowColor,
      this.barrierLabel,
      this.barrierColor,
      this.barrierDismissible = true,
      this.transitionDuration = const Duration(milliseconds: 200),
      this.alignType = AlignType.left,
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
  State<SelectionMenu> createState() => SelectionMenuState();
}

class SelectionMenuState extends State<SelectionMenu>{

  bool _popShowIng = false;
  final GlobalKey _rootKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller?.bind(this);
  }

  void didPushNext() {
    _popShowIng = true;
    refresh();
    widget.onShow?.call(_popShowIng);
  }

  void didPopNext() {
    _popShowIng = false;
    refresh();
    widget.onDismiss?.call(_popShowIng);
  }

  void refresh(){
    if(mounted){
      setState(() {
      });
    }
  }
  void closePop(){
    if(mounted){
      Navigator.pop(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return InkWell(
      key:_rootKey,
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
        if(!widget.enableClick){
          return;
        }
        if (_popShowIng) {
          return;
        }
        _showSelection(context);
      },
      child: widget.buttonBuilder?.call(_popShowIng),
    );
  }

  void _showSelection(BuildContext context) {

    RenderBox overlay = _rootKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox button = context.findRenderObject()! as RenderBox;
    Size screenSize = MediaQuery.of(context).size;

    var buttonWidth = button.size.width;
    double customWidth = widget.popWidth;
    if(widget.matchParentWidth &&  customWidth < buttonWidth){
      customWidth = buttonWidth;
    }


    //判断是否超出屏幕高度
    bool isOutHeight = false;
    Offset offsetWH = button.localToGlobal(Offset.zero);
    if (offsetWH.dy + widget.popHeight+widget.vMargin >= screenSize.height) {
      isOutHeight = true;
    }
    Offset? offset;
    if(isOutHeight){
      offset = Offset(offsetWH.dx, offsetWH.dy - widget.popHeight  -widget.vMargin);
    }else{
      overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
      offset = Offset(0, button.size.height);
    }

    //判断是否超出屏幕宽度
    bool isOutWidth = false;
    if (offsetWH.dx + customWidth + widget.hMargin >= screenSize.width) {
      isOutWidth = true;
    }
    if(isOutWidth){
      offset = Offset(offset.dx -widget.hMargin - customWidth + buttonWidth  , offset.dy);
    }

    double centerX = 0;
    if (widget.alignType == AlignType.center) {
      centerX = customWidth / 2 - buttonWidth / 2;
      if(centerX < 0) centerX==0;
   }


    RelativeRect position = widget.layoutSelectPop==null? RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal( offset, ancestor: overlay),
        // button.localToGlobal(button.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
      ),
      widget.alignType == AlignType.right?Rect.fromPoints(
         isOutWidth?const Offset(0, 0):Offset(-buttonWidth+widget.popWidth , 0),
         isOutWidth? Offset(customWidth, 0):Offset(-buttonWidth+customWidth, 0),
        // Offset(widget.popWidth, 0),
      ): widget.alignType == AlignType.center?Rect.fromPoints(
        Offset(centerX, 0),
        Offset(customWidth, 0),
      ): Rect.fromPoints(
        const Offset(0, 0),
        const Offset(0, 0),
      ),
    ):widget.layoutSelectPop!.call(button,overlay);

    // RelativeRect position = widget.layoutSelectPop==null? RelativeRect.fromRect(
    //   Rect.fromPoints(
    //     button.localToGlobal(offset, ancestor: overlay),
    //     button.localToGlobal( offset, ancestor: overlay),
    //     // button.localToGlobal(button.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
    //   ),
    //   widget.alignType == AlignType.right?Rect.fromPoints(
    //     Offset(-(button.size.width-widget.popWidth), 0),
    //     Offset(widget.popWidth, 0),
    //   ): widget.alignType == AlignType.center?Rect.fromPoints(
    //     Offset(centerX, 0),
    //     Offset(widget.popWidth, 0),
    //   ): Rect.fromPoints(
    //     const Offset(0, 0),
    //     Offset(widget.popWidth, 0),
    //   ),
    // ):widget.layoutSelectPop!.call(button,overlay);

    Navigator.of(context).push(_CustomPopupRoute(
        position: position,
        menuState: this,
        popWidth:customWidth,
        popHeight: widget.popHeight,
        builder: widget.selectorBuilder,
        elevation: widget.elevation,
        color: widget.color,
        shape: widget.shape,
        materialBorderRadius: widget.materialBorderRadius,
        shadowColor: widget.shadowColor,
        barrierColor: widget.barrierColor,
        barrierDismissible: widget.barrierDismissible,
        transitionDuration: widget.transitionDuration,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel));
  }


  @override
  void didUpdateWidget(covariant SelectionMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?.bind(this);
    }
  }
}

class _CustomPopupRoute<T> extends PopupRoute<T> {

  final SelectionMenuState menuState;
  final WidgetBuilder builder;
  final RelativeRect position;
  final double elevation;
  final Color? shadowColor;
  /// Material 背景样式
  final BorderRadiusGeometry? materialBorderRadius;
  final Color? color;
  final ShapeBorder? shape;

  @override
  final String? barrierLabel;
  @override
  final Color? barrierColor;
  @override
  final bool barrierDismissible;
  @override
  final Duration transitionDuration;

  final double? popWidth;
  final double? popHeight;

  _CustomPopupRoute({
    required this.builder,
    required this.position,
    required this.barrierLabel,
    required this.menuState,
    this.elevation = 0.0,
    this.shadowColor,
    this.barrierColor,
    this.barrierDismissible = true,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.popWidth,
    this.popHeight,
    this.materialBorderRadius,
    this.color,
    this.shape,
  });

  @override
  bool didPop(T? result) {
    menuState.didPopNext();
    return super.didPop(result);
  }

  @override
  TickerFuture didPush() {
    menuState.didPushNext();
    return super.didPush();
  }



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
                color: color,
                elevation: elevation,
                shadowColor: shadowColor,
                shape: shape,
                borderRadius: materialBorderRadius,
                child: _HeightFactorBox(
                heightFactor: heightFactorTween.evaluate(animation),
                child: child,
            ));
          },
          child: SizedBox(
            width: popWidth,
            height:popHeight,
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


class SelectionMenuController{
  SelectionMenuController();

  SelectionMenuState? _state;


  void bind(SelectionMenuState state) {
    _state = state;
  }

  SelectionMenuState? getState() {
    return _state;
  }

  RenderBox? getRenderBox() {
    final obj = _state?.context.findRenderObject();
    if (obj != null) {
      return obj as RenderBox;
    }
    return null;
  }

  void dispose() {
    _state = null;
  }

  void refresh() {
    _state?.refresh();
  }

  void closePop() {
    _state?.closePop();
  }

}