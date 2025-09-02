import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uikit/select/select_fun.dart';

import 'drop_position.dart';
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-02-01
/// create_time: 14:58
/// describe: 极简系统下拉框，可高度自定义，且规避系统组件的使用麻烦，SelectionMenuForm不关心数据。
/// eg: 此组件可配合 Form 表单进行校验工作，如不需要此功能，可使用 [SelectionMenu]
//  如需实时校验请配合：controller.validator();
//  ValueNotifier<FormTips> formTips = ValueNotifier(FormTips.none);
// 	  SelectionMenuForm(
// 		  popWidth: 30,
// 		  alignType: AlignType.center,
// 		  controller: selectionMenuFormController,
// 		  valueNotifier: formTips,
// 		  warningTips: const Text('这是一条警告信息',style: TextStyle(color: Colors.yellow)),
// 		  errorTips: const Text('这是错误信息',style: TextStyle(color: Colors.red),),
// 		  validator: (value) {
// 			if (_checkedIndex  == null) {
// 			  return(formTips.value = FormTips.warning).toString();
// 			}
// 			if (_checkedIndex  == 1) {
// 			  return (formTips.value = FormTips.error).toString();
// 			}
// 			formTips.value = FormTips.none;
// 			return null;
// 		  },
// 		  buttonBuilder: (show){
// 			return Container(
// 			  height: 40,
// 			  width: 200,
// 			  padding: const EdgeInsets.only(left: 10, right: 10),
// 			  decoration: BoxDecoration(
// 				color: Colors.grey.setAlpha(0.2),
// 				borderRadius: BorderRadius.circular(5),
// 			  ),
// 			  child: Row(
// 				mainAxisSize: MainAxisSize.min,
// 				children: [
// 				  Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
// 				  Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
// 				],
// 			  ),
// 			);
// 		  },
// 		  selectorBuilder: (context) {
// 			return Container(
// 			  height: 200,
// 			  margin: const EdgeInsets.only(top: 10),
// 			  decoration: const BoxDecoration(
// 				  color: Colors.yellow
// 			  ),
// 			  child: ListView.separated(
// 				itemCount: 20,
// 				itemBuilder: (context, index) {
// 				  return GestureDetector(
// 					onTap: (){
// 					  if(index == 0){
// 						_checkedIndex = null;
// 					  }else{
// 						_checkedIndex = index;
// 					  }
// 					  selectionMenuFormController.validator();
// 					  Navigator.pop(context);
// 					},
// 					child: 'item $_checkedIndex' == 'item $index' ? Row(
// 					  mainAxisAlignment: MainAxisAlignment.spaceBetween,
// 					  children: [
// 						Text("item $index",style: const TextStyle(color: Colors.red),),
// 						const Icon(Icons.check,color: Colors.red,)
// 					  ],
// 					) : Text("item $index"),
// 				  );
// 				}, separatorBuilder: (BuildContext context, int index) {
// 				return const Divider();
// 			  },),
// 			);
// 		  }
// 	  ),

enum FormTips {
  none, //没有提示
  warning, // 警告提示
  error, // 错误提示
}

class SelectionMenuForm<T> extends FormField<T> {

  final SelectionMenuFormController? controller;

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

  SelectionMenuForm(
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
      AutovalidateMode? autovalidateMode,
      ScrollController? scrollController,
      String? restorationId,
      FormFieldSetter? onSaved,
      FormFieldValidator? validator,
      bool? enabled,
      required ValueNotifier<FormTips> valueNotifier,
      Widget? noneTips,
      Widget? warningTips,
      Widget? errorTips,
      InputDecoration decoration = const InputDecoration(),
      Key? key})
      : super(
          key: key,
          restorationId: restorationId,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState field) {
            final SelectionMenuFormState state =
                field as SelectionMenuFormState;
            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      key: state._rootKey,
                      onDoubleTap: onDoubleTap,
                      onLongPress: onLongPress,
                      onTapDown: onTapDown,
                      onTapUp: onTapUp,
                      onTapCancel: onTapCancel,
                      onHighlightChanged: onHighlightChanged,
                      mouseCursor: mouseCursor,
                      focusColor: focusColor,
                      hoverColor: hoverColor,
                      highlightColor: highlightColor,
                      overlayColor: overlayColor,
                      splashColor: splashColor,
                      splashFactory: splashFactory,
                      radius: radius,
                      borderRadius: borderRadius,
                      customBorder: customBorder,
                      enableFeedback: enableFeedback,
                      excludeFromSemantics: excludeFromSemantics,
                      focusNode: focusNode,
                      canRequestFocus: canRequestFocus,
                      onFocusChange: onFocusChange,
                      autofocus: autofocus,
                      onHover: (hover) {
                        if (hover && enableOnHover) {
                          state._showSelection(context);
                          return;
                        }
                      },
                      onTap: () {
                        if(enabled == false) {
                          return;
                        }
                        if (!enableClick) {
                          return;
                        }
                        if (state._popShowIng) {
                          return;
                        }
                        state._showSelection(context);
                      },
                      child: buttonBuilder?.call(state._popShowIng),
                    ),
                    ValueListenableBuilder<FormTips>(
                        valueListenable: valueNotifier,
                        builder: (context, value, child) {
                          if (value == FormTips.warning) {
                            return warningTips ?? const SizedBox();
                          }
                          if (value == FormTips.error) {
                            return errorTips ?? const SizedBox();
                          }
                          return const SizedBox();
                        })
                  ],
                );
              }),
            );
          },
        );

  @override
  FormFieldState<T> createState() => SelectionMenuFormState();
}

class SelectionMenuFormState<T> extends FormFieldState<T> {
  bool _popShowIng = false;
  final GlobalKey _rootKey = GlobalKey();

  SelectionMenuForm get self => super.widget as SelectionMenuForm;

  @override
  void initState() {
    super.initState();
    self.controller?.bind(this);
  }

  void didPushNext() {
    _popShowIng = true;
    refresh();
    self.onShow?.call(_popShowIng);
  }

  void didPopNext() {
    _popShowIng = false;
    refresh();
    self.onDismiss?.call(_popShowIng);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void closePop() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _showSelection(BuildContext context) {
    RenderBox overlay =
        _rootKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox button = context.findRenderObject()! as RenderBox;
    Size screenSize = MediaQuery.of(context).size;

    var buttonWidth = button.size.width;
    double customWidth = self.popWidth;
    if (self.matchParentWidth && customWidth < buttonWidth) {
      customWidth = buttonWidth;
    }

    //判断是否超出屏幕高度
    bool isOutHeight = false;
    Offset offsetWH = button.localToGlobal(Offset.zero);
    if (offsetWH.dy + self.popHeight + self.vMargin >= screenSize.height) {
      isOutHeight = true;
    }
    Offset? offset;
    if (isOutHeight) {
      offset = Offset(offsetWH.dx, offsetWH.dy - self.popHeight - self.vMargin);
    } else {
      overlay = Navigator.of(context).overlay!.context.findRenderObject()!
          as RenderBox;
      offset = Offset(0, button.size.height);
    }

    //判断是否超出屏幕宽度
    bool isOutWidth = false;
    if (offsetWH.dx + customWidth + self.hMargin >= screenSize.width) {
      isOutWidth = true;
    }
    if (isOutWidth) {
      offset = Offset(
          offset.dx - self.hMargin - customWidth + buttonWidth, offset.dy);
    }

    double centerX = 0;
    if (self.alignType == AlignType.center) {
      centerX = customWidth / 2 - buttonWidth / 2;
      if (centerX < 0) centerX == 0;
    }

    RelativeRect position = self.layoutSelectPop == null
        ? RelativeRect.fromRect(
            Rect.fromPoints(
              button.localToGlobal(offset, ancestor: overlay),
              button.localToGlobal(offset, ancestor: overlay),
              // button.localToGlobal(button.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
            ),
            self.alignType == AlignType.right
                ? Rect.fromPoints(
                    isOutWidth
                        ? const Offset(0, 0)
                        : Offset(-buttonWidth + self.popWidth, 0),
                    isOutWidth
                        ? Offset(customWidth, 0)
                        : Offset(-buttonWidth + customWidth, 0),
                    // Offset(self.popWidth, 0),
                  )
                : self.alignType == AlignType.center
                    ? Rect.fromPoints(
                        Offset(centerX, 0),
                        Offset(customWidth, 0),
                      )
                    : Rect.fromPoints(
                        const Offset(0, 0),
                        const Offset(0, 0),
                      ),
          )
        : self.layoutSelectPop!.call(button, overlay);

    // RelativeRect position = self.layoutSelectPop==null? RelativeRect.fromRect(
    //   Rect.fromPoints(
    //     button.localToGlobal(offset, ancestor: overlay),
    //     button.localToGlobal( offset, ancestor: overlay),
    //     // button.localToGlobal(button.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
    //   ),
    //   self.alignType == AlignType.right?Rect.fromPoints(
    //     Offset(-(button.size.width-self.popWidth), 0),
    //     Offset(self.popWidth, 0),
    //   ): self.alignType == AlignType.center?Rect.fromPoints(
    //     Offset(centerX, 0),
    //     Offset(self.popWidth, 0),
    //   ): Rect.fromPoints(
    //     const Offset(0, 0),
    //     Offset(self.popWidth, 0),
    //   ),
    // ):self.layoutSelectPop!.call(button,overlay);

    Navigator.of(context).push(_CustomPopupRoute(
        position: position,
        menuState: this,
        popWidth: customWidth,
        popHeight: self.popHeight,
        builder: self.selectorBuilder,
        elevation: self.elevation,
        color: self.color,
        shape: self.shape,
        materialBorderRadius: self.materialBorderRadius,
        shadowColor: self.shadowColor,
        barrierColor: self.barrierColor,
        barrierDismissible: self.barrierDismissible,
        transitionDuration: self.transitionDuration,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel));
  }

  @override
  void didUpdateWidget(SelectionMenuForm<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (self.controller != null && oldWidget.controller != self.controller) {
      self.controller?.bind(this);
    }
  }
}

class _CustomPopupRoute<T> extends PopupRoute<T> {
  final SelectionMenuFormState menuState;
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
            height: popHeight,
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

class SelectionMenuFormController {
  SelectionMenuFormController();

  SelectionMenuFormState? _state;

  void bind(SelectionMenuFormState state) {
    _state = state;
  }

  SelectionMenuFormState? getState() {
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

  void validator() {
    _state?.validate();
  }
}
