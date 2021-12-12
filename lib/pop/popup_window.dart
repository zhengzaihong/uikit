import 'package:flutter/material.dart';
import 'pop_route.dart';
import 'popup_gravity.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-12-11
/// create_time: 18:08
/// describe: 类似 android 的popwindow 控件
///
PopupWindow showPopupWindow<T>(
  BuildContext context, {
  Widget Function(PopupWindow popup)? childFun,
  Size? childSize,
  PopupGravity? gravity,
  Curve? curve,
  bool? customAnimation,
  bool? customPop,
  bool? customPage,
  Color? bgColor,
  RenderBox? targetRenderBox,
  bool? underStatusBar,
  bool? underAppBar,
  bool? clickOutDismiss,
  bool? clickBackDismiss,
  double? offsetX,
  double? offsetY,
  Duration? duration,
  bool? needSafeDisplay,
  Function(PopupWindow popup)? onShowStart,
  Function(PopupWindow popup)? onShowFinish,
  Function(PopupWindow popup)? onDismissStart,
  Function(PopupWindow popup)? onDismissFinish,
  Function(PopupWindow popup)? onClickOut,
  Function(PopupWindow popup)? onClickBack,
}) {
  var popup = PopupWindow(
    gravity: gravity,
    curve: curve,
    customAnimation: customAnimation,
    customPop: customPop,
    customPage: customPage,
    bgColor: bgColor,
    childFun: childFun,
    childSize: childSize,
    targetRenderBox: targetRenderBox,
    underStatusBar: underStatusBar,
    underAppBar: underAppBar,
    clickOutDismiss: clickOutDismiss,
    clickBackDismiss: clickBackDismiss,
    offsetX: offsetX,
    offsetY: offsetY,
    duration: duration,
    needSafeDisplay: needSafeDisplay,
    onShowStart: onShowStart,
    onShowFinish: onShowFinish,
    onDismissStart: onDismissStart,
    onDismissFinish: onDismissFinish,
    onClickOut: onClickOut,
    onClickBack: onClickBack,
  );
  popup.show(context);
  return popup;
}

PopupWindow createPopupWindow<T>(
  BuildContext context, {
  Widget Function(PopupWindow popup)? childFun,
  Size? childSize,
  PopupGravity? gravity,
  bool? customAnimation,
  bool? customPop,
  bool? customPage,
  Color? bgColor,
  RenderBox? targetRenderBox,
  bool? underStatusBar,
  bool? underAppBar,
  bool? clickOutDismiss,
  bool? clickBackDismiss,
  double? offsetX,
  double? offsetY,
  Duration? duration,
  bool? needSafeDisplay,
  Function(PopupWindow popup)? onShowStart,
  Function(PopupWindow popup)? onShowFinish,
  Function(PopupWindow popup)? onDismissStart,
  Function(PopupWindow popup)? onDismissFinish,
  Function(PopupWindow popup)? onClickOut,
  Function(PopupWindow popup)? onClickBack,
}) {
  return PopupWindow(
    gravity: gravity,
    customAnimation: customAnimation,
    customPop: customPop,
    customPage: customPage,
    bgColor: bgColor,
    childFun: childFun,
    childSize: childSize,
    targetRenderBox: targetRenderBox,
    underStatusBar: underStatusBar,
    underAppBar: underAppBar,
    clickOutDismiss: clickOutDismiss,
    clickBackDismiss: clickBackDismiss,
    offsetX: offsetX,
    offsetY: offsetY,
    duration: duration,
    needSafeDisplay: needSafeDisplay,
    onShowStart: onShowStart,
    onShowFinish: onShowFinish,
    onDismissStart: onDismissStart,
    onDismissFinish: onDismissFinish,
    onClickOut: onClickOut,
    onClickBack: onClickBack,
  );
}

// ignore: must_be_immutable
class PopupWindow extends StatefulWidget {
  /// 自定义弹出框内容的方法，返回的widget将作为弹出框内容，然后赋值给[_child]
  /// 如果[_childSize] == null，那么当绘制完成以后，会将[_child]的尺寸赋值给[_childSize]
  final Widget Function(PopupWindow popup)? _childFun;

  /// 弹出框的相对位置
  /// 默认为 [PopupGravity.center]
  /// 如果[_targetRenderBox] == null，那么此时弹出框的位置相对于屏幕，
  /// 如果[_targetRenderBox] != null，那么此时弹出框的位置相对于目标widget
  final PopupGravity _gravity;

  /// 动画插值器
  /// 默认为[Curves.decelerate]
  /// 如果不自定义动画，那么可以使用此属性来改变动画曲线
  final Curve _curve;

  /// 自定义popupWindow的动画
  /// 默认为false。
  /// 如果为true，那么此时默认动画无效，需要为[_childFun]返回的widget自定义动画
  final bool _customAnimation;

  ///自定义popupWindow的位置与动画
  /// 默认为false。
  /// 如果为true，那么此时[_gravity]和默认动画均无效，需要为[_childFun]返回的widget自定义位置与动画
  final bool _customPop;

  /// 自定义整个页面，包括[Scaffold]
  /// 默认为false。
  /// 如果为true，需要为[_childFun]返回的widget自定义整个页面
  final bool _customPage;

  ///遮罩层的颜色
  ///默认为[Colors.black].withOpacity(0.5)
  final Color _bgColor;

  ///目标widget的[RenderBox]
  ///默认为null
  ///通过该属性获取目标widget的位置与尺寸
  ///具体看[_gravity]的说明
  final RenderBox? _targetRenderBox;

  ///顶部弹出时，是否在statusBar下方
  ///默认为false
  final bool _underStatusBar;

  ///顶部弹出时，是否在AppBar下方
  ///默认为false
  final bool _underAppBar;

  ///点击弹出框以外的区域是否收起
  ///默认为true
  final bool _clickOutDismiss;

  ///点击物理返回按钮是否收起
  ///默认为true
  final bool _clickBackDismiss;

  ///横轴贴边处相对偏移量
  ///默认为0.0
  /// 如果 [_targetRenderBox] 为null，那么该值表示相对于屏幕边缘的横向偏移量，不能小于0.0
  /// 如果 [_targetRenderBox] 不为null，那么该值表示相对于目标widget边缘的横向偏移量，小于0表示向左偏移，大于0表示向右偏移
  final double _relativeOffsetX;

  ///纵轴贴边处相对偏移量
  ///默认为0.0
  /// 如果 [_targetRenderBox] 为null，那么该值表示相对于屏幕边缘的纵向偏移量，不能小于0.0
  /// 如果 [_targetRenderBox] 不为null，那么该值表示相对于目标widget边缘的纵向偏移量，小于0表示向上偏移，大于0表示向下偏移
  final double _relativeOffsetY;

  ///动画的时长
  ///默认为 200ms
  final Duration _duration;

  /// 是否需要安全显示弹出框
  /// 如果为true，并且[_targetRenderBox]不为null时，当弹出框超出边界时，会自动贴边
  final bool _needSafeDisplay;

  /// 当前弹框是否已经显示
  bool? _isShow;

  bool? get isShow => _isShow;

  ///弹出动画开始的监听
  final Function(PopupWindow popup)? _onShowStart;

  ///弹出动画结束的监听
  final Function(PopupWindow popup)? _onShowEnd;

  ///收起动画开始的监听
  final Function(PopupWindow popup)? _onDismissStart;

  ///收起动画结束的监听
  final Function(PopupWindow popup)? _onDismissEnd;

  ///点击弹框以外的监听
  ///只有当[_clickOutDismiss] == false 才有效
  final Function(PopupWindow popup)? _onClickOut;

  ///点击物理返回按钮的监听
  ///只有当[_clickBackDismiss] == false 才有效
  final Function(PopupWindow popup)? _onClickBack;

  ///弹出框的尺寸
  ///如果为null，那么将在绘制完成之后计算并赋值
  Size? _childSize;

  Size? get childSize => _childSize;

  ///弹出框的widget
  ///[_childFun]返回的widget
  Widget? _child;

  Widget? get child => _child;

  ///动画控制器
  AnimationController? _controller;

  AnimationController? get controller => _controller;

  PopupWindow({Key? key,
    required Widget Function(PopupWindow popup)? childFun,
    Size? childSize,
    PopupGravity? gravity,
    Curve? curve,
    bool? customAnimation,
    bool? customPop,
    bool? customPage,
    Color? bgColor,
    RenderBox? targetRenderBox,
    bool? underStatusBar,
    bool? underAppBar,
    bool? clickOutDismiss,
    bool? clickBackDismiss,
    double? offsetX,
    double? offsetY,
    Duration? duration,
    bool? needSafeDisplay,
    Function(PopupWindow popup)? onShowStart,
    Function(PopupWindow popup)? onShowFinish,
    Function(PopupWindow popup)? onDismissStart,
    Function(PopupWindow popup)? onDismissFinish,
    Function(PopupWindow popup)? onClickOut,
    Function(PopupWindow popup)? onClickBack,
  })  : _childFun = childFun,
        _childSize = childSize,
        _gravity = gravity ?? PopupGravity.center,
        _curve = curve ?? Curves.decelerate,
        _customAnimation = customAnimation ?? false,
        _customPop = customPop ?? false,
        _customPage = customPage ?? false,
        _bgColor = bgColor ?? Colors.black.withOpacity(0.5),
        _targetRenderBox = targetRenderBox,
        _underStatusBar = underStatusBar ?? false,
        _underAppBar = underAppBar ?? false,
        _clickOutDismiss = clickOutDismiss ?? true,
        _clickBackDismiss = clickBackDismiss ?? true,
        _relativeOffsetX = offsetX ?? 0,
        _relativeOffsetY = offsetY ?? 0,
        _duration = duration ?? const Duration(milliseconds: 300),
        _needSafeDisplay = needSafeDisplay ?? false,
        _onShowStart = onShowStart,
        _onShowEnd = onShowFinish,
        _onDismissStart = onDismissStart,
        _onDismissEnd = onDismissFinish,
        _onClickOut = onClickOut,
        _onClickBack = onClickBack, super(key: key);

  @override
  _PopupWindowState createState() => _PopupWindowState();

  ///收起弹框
  ///popup window dismiss
  Future dismiss(BuildContext context, {bool? notStartAnimation, Function(PopupWindow pop)? onFinish}) async {
    if (_isShow == false) {
      return;
    }
    _isShow = false;
    if (notStartAnimation == true) {
      Navigator.pop(context);
      if (onFinish != null) {
        onFinish(this);
      }
      return;
    }
    await _controller!.reverse();
    Navigator.pop(context);
    if (onFinish != null) {
      onFinish(this);
    }
  }

  ///弹出弹框
  Future show(BuildContext context) async {
    Navigator.push(
      context,
      PopRoute(
        child: this,
      ),
    );
    _isShow = true;
  }
}

class _PopupWindowState extends State<PopupWindow> with SingleTickerProviderStateMixin {
  Animation<Offset>? animation;

  @override
  void initState() {
    super.initState();
    widget._controller = AnimationController(duration: widget._duration, vsync: this);
    widget._controller!.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          if (widget._onShowStart != null) {
            widget._onShowStart!(widget);
          }
          break;
        case AnimationStatus.dismissed:
          if (widget._onDismissEnd != null) {
            widget._onDismissEnd!(widget);
          }
          break;
        case AnimationStatus.reverse:
          if (widget._onDismissStart != null) {
            widget._onDismissStart!(widget);
          }
          break;
        case AnimationStatus.completed:
          if (widget._onShowEnd != null) {
            widget._onShowEnd!(widget);
          }
          break;
      }
    });

    ///将弹出框保存起来，保证其唯一性
    ///Save the popup window to ensure its uniqueness
    widget._child = widget._childFun!(widget);

    ///如果已经设置过弹出框的尺寸，那么可以直接开始动画
    ///If you have set the size of the popup window, you can start the animation directly
    if (widget._childSize != null) {
      widget._controller!.forward();
    }

    ///绘制完成的监听
    ///Draw completed listener
    WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      if (widget._customPage) {
        widget._controller!.forward();
        return;
      }
      if (widget._customPop) {
        widget._controller!.forward();
        return;
      }

      ///如果未设置弹出框的尺寸

      if (widget._childSize == null) {
        ///那么此时可以直接获取弹出框绘制完成之后的尺寸
        widget._childSize = (widget._child!.key as GlobalKey).currentContext!.size;

        ///并且开始动画，必须放在setState里面
        setState(() {
          widget._controller!.forward();
        });
      }
    });
  }

  @override
  dispose() {
    widget._controller!.dispose();
    super.dispose();
  }

  ///获取statusBar的高度
  double _getStatusBar(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top;
  }

  ///获取statusBar和appBar的总高度
  double _getStatusBarAndAppBarHeight(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  ///判断是否需要将弹出框显示在statusBar或者appBar下方，并返回偏移量
  double _getTopPadding(BuildContext context) {
    return widget._underAppBar == true ? _getStatusBarAndAppBarHeight(context) : (widget._underStatusBar == true ? _getStatusBar(context) : 0);
  }


  Widget getLayout(BuildContext context) {
    ///如果想要自定义整个页面
    if (widget._customPage) {
      return WillPopScope(
          child: widget._child!,
          onWillPop: () {
            if (widget._clickBackDismiss) {
              widget.dismiss(context);
            }
            return Future.value(false);
          });
    }

    ///如果想要自定义popup window的位置和动画
    if (widget._customPop) {
      return WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Align(
                  child: GestureDetector(
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: Container(
                        alignment: Alignment.center,
                        color: widget._bgColor,
                      ),
                    ),
                    onTap: () {
                      if (widget._clickOutDismiss) {
                        widget.dismiss(context);
                        return;
                      }
                      if (widget._onClickOut != null) {
                        widget._onClickOut!(widget);
                      }
                    },
                  ),
                ),
                if (widget._child != null) widget._child!,
              ],
            ),
          ),
          onWillPop: () {
            if (widget._clickBackDismiss) {
              widget.dismiss(context);
              return Future.value(false);
            }
            if (widget._onClickBack != null) {
              widget._onClickBack!(widget);
            }
            return Future.value(false);
          });
    }

    ///popup window的最终widget
   late Widget childView;

    ///目标widget的坐标
    late Offset targetOffset;

    ///目标widget的尺寸
    late Size targetSize;

    ///当popup window的位置相对于某个目标widget时，需要初始化目标widget的坐标与尺寸
    if (widget._targetRenderBox != null) {
      targetOffset = widget._targetRenderBox!.localToGlobal(Offset.zero);
      targetSize = widget._targetRenderBox!.size;
    }
    switch (widget._gravity) {
      case PopupGravity.leftTop:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕左上角弹出
          childView = Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: widget._relativeOffsetX,
                top: _getTopPadding(context) + widget._relativeOffsetY,
              ),
              child: widget._customAnimation
                  ? widget._child
                  : ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: SlideTransition(
                        position: Tween(begin: const Offset(-1, -1), end: const Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: FadeTransition(
                          opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                          child: widget._child,
                        ),
                      ),
                    ),
            ),
          );
        } else {
          var safeWidth = 0.0;
          var safeHeight = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeWidth = widget._childSize!.width - widget._relativeOffsetX - targetOffset.dx;
            safeHeight = widget._childSize!.height - widget._relativeOffsetY - targetOffset.dy;
          }

          ///如果位置相对于目标widget，从目标widget的左上角弹出
          ///弹出之前，弹出框左上角与目标widget的左上角对齐
          childView = Positioned(
            left: targetOffset.dx + widget._relativeOffsetX + (safeWidth > 0 ? safeWidth : 0),
            top: targetOffset.dy + widget._relativeOffsetY + (safeHeight > 0 ? safeHeight : 0),
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(-1, -1)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.centerTop:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕正上方弹出
          childView = Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: _getTopPadding(context) + widget._relativeOffsetY,
              ),
              child: widget._customAnimation
                  ? widget._child
                  : SlideTransition(
                      position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
            ),
          );
        } else {
          var safeHeight = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeHeight = widget._childSize!.height - widget._relativeOffsetY - targetOffset.dy;
          }

          ///如果位置相对于目标widget，从目标widget的正上方弹出
          ///弹出之前，弹出框的x轴中心点与目标widget的x轴中心点对齐，弹出框的上边与目标widget的上边对齐
          childView = Positioned(
            left: targetOffset.dx - (widget._childSize == null ? 0 : widget._childSize!.width - targetSize.width) / 2 + widget._relativeOffsetX,
            top: targetOffset.dy + widget._relativeOffsetY + (safeHeight > 0 ? safeHeight : 0),
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(0, -1)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.rightTop:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕右上角弹出
          childView = Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: widget._relativeOffsetX,
                top: _getTopPadding(context) + widget._relativeOffsetY,
              ),
              child: widget._customAnimation
                  ? widget._child
                  : ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: SlideTransition(
                        position: Tween(begin: Offset(1, -1), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: FadeTransition(
                          opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                          child: widget._child,
                        ),
                      ),
                    ),
            ),
          );
        } else {
          var safeWidth = 0.0;
          var safeHeight = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeWidth = widget._childSize!.width + widget._relativeOffsetX - (MediaQuery.of(context).size.width - targetOffset.dx - targetSize.width);
            safeHeight = widget._childSize!.height - widget._relativeOffsetY - targetOffset.dy;
          }

          ///如果位置相对于目标widget，从目标widget的右上方弹出
          ///弹出之前，弹出框的右上角与目标widget的右上角对齐
          childView = Positioned(
            left: targetOffset.dx -
                (widget._childSize == null ? 0 : widget._childSize!.width - targetSize.width) +
                widget._relativeOffsetX -
                (safeWidth > 0 ? safeWidth : 0),
            top: targetOffset.dy + widget._relativeOffsetY + (safeHeight > 0 ? safeHeight : 0),
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(1, -1)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.leftCenter:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕正左方弹出
          childView = Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: widget._relativeOffsetX,
                top: _getTopPadding(context),
              ),
              child: widget._customAnimation
                  ? widget._child
                  : SlideTransition(
                      position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
            ),
          );
        } else {
          var safeWidth = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeWidth = widget._childSize!.width + widget._relativeOffsetX - (MediaQuery.of(context).size.width - targetOffset.dx - targetSize.width);
          }

          ///如果位置相对于目标widget，从目标widget的正左方弹出
          ///弹出之前，弹出框的y轴中心点与目标widget的y轴中心点对齐，弹出框的左边与目标widget的左边对齐
          childView = Positioned(
            left: targetOffset.dx + widget._relativeOffsetX + (safeWidth > 0 ? safeWidth : 0),
            top: targetOffset.dy - (widget._childSize == null ? 0 : widget._childSize!.height - targetSize.height) / 2 + widget._relativeOffsetY,
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(-1, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.center:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕正中心弹出
          childView = Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: widget._relativeOffsetX, top: widget._relativeOffsetY + _getTopPadding(context)),
              child: widget._customAnimation
                  ? widget._child
                  : ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
            ),
          );
        } else {
          ///如果位置相对于目标widget，从目标widget的正中心弹出
          ///弹出之前，弹出框的中心点与目标widget的中心点对齐
          childView = Positioned(
            left: targetOffset.dx - (widget._childSize == null ? 0 : widget._childSize!.width - targetSize.width) / 2 + widget._relativeOffsetX,
            top: targetOffset.dy - (widget._childSize == null ? 0 : widget._childSize!.height - targetSize.height) / 2 + widget._relativeOffsetY,
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: FadeTransition(
                      opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: widget._child,
                    )),
          );
        }
        break;
      case PopupGravity.rightCenter:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕正右方弹出
          childView = Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: widget._relativeOffsetX,
                top: _getTopPadding(context),
              ),
              child: widget._customAnimation
                  ? widget._child
                  : SlideTransition(
                      position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
            ),
          );
        } else {
          var safeWidth = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeWidth = widget._childSize!.width + widget._relativeOffsetX - (MediaQuery.of(context).size.width - targetOffset.dx - targetSize.width);
          }

          ///如果位置相对于目标widget，从目标widget的正右方弹出
          ///弹出之前，弹出框的y轴中心点与目标widget的y轴中心点对齐，弹出框的右边与目标widget的右边对齐
          childView = Positioned(
            left: targetOffset.dx -
                (widget._childSize == null ? 0 : widget._childSize!.width - targetSize.width) +
                widget._relativeOffsetX -
                (safeWidth > 0 ? safeWidth : 0),
            top: targetOffset.dy - (widget._childSize == null ? 0 : widget._childSize!.height - targetSize.height) / 2 + widget._relativeOffsetY,
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(1, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.leftBottom:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕左下方弹出
          childView = Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: widget._relativeOffsetX,
                bottom: widget._relativeOffsetY,
              ),
              child: widget._customAnimation
                  ? widget._child
                  : ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: SlideTransition(
                        position: Tween(begin: Offset(-1, 1), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: FadeTransition(
                          opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                          child: widget._child,
                        ),
                      ),
                    ),
            ),
          );
        } else {
          var safeWidth = 0.0;
          var safeHeight = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeWidth = widget._childSize!.width - widget._relativeOffsetX - targetOffset.dx;
            safeHeight = widget._childSize!.height + widget._relativeOffsetY - (MediaQuery.of(context).size.height - targetOffset.dy - targetSize.height);
          }

          ///如果位置相对于目标widget，从目标widget的左下方弹出
          ///弹出之前，弹出框的左下角与目标widget的左下角对齐
          childView = Positioned(
            left: targetOffset.dx + widget._relativeOffsetX + (safeWidth > 0 ? safeWidth : 0),
            top: targetOffset.dy -
                (widget._childSize == null ? 0 : widget._childSize!.height - targetSize.height) +
                widget._relativeOffsetY -
                (safeHeight > 0 ? safeHeight : 0),
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(-1, 1)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.centerBottom:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕正下方弹出
          childView = Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget._relativeOffsetY,
              ),
              child: widget._customAnimation
                  ? widget._child
                  : SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
            ),
          );
        } else {
          var safeHeight = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeHeight = widget._childSize!.height + widget._relativeOffsetY - (MediaQuery.of(context).size.height - targetOffset.dy - targetSize.height);
          }

          ///如果位置相对于目标widget，从目标widget的正下方弹出
          ///弹出之前，弹出框的x轴中心点与目标widget的x轴中心点对齐，弹出框的右边与目标widget的下边对齐
          childView = Positioned(
            left: targetOffset.dx - (widget._childSize == null ? 0 : widget._childSize!.width - targetSize.width) / 2 + widget._relativeOffsetX,
            top: targetOffset.dy -
                (widget._childSize == null ? 0 : widget._childSize!.height - targetSize.height) +
                widget._relativeOffsetY -
                (safeHeight > 0 ? safeHeight : 0),
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(0, 1)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      case PopupGravity.rightBottom:
        if (widget._targetRenderBox == null) {
          ///如果位置相对于屏幕，从屏幕右下方弹出
          childView = Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: widget._relativeOffsetX,
                bottom: widget._relativeOffsetY,
              ),
              child: widget._customAnimation
                  ? widget._child
                  : ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: SlideTransition(
                        position: Tween(begin: Offset(1, 1), end: Offset(0, 0)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: FadeTransition(
                          opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                          child: widget._child,
                        ),
                      ),
                    ),
            ),
          );
        } else {
          var safeWidth = 0.0;
          var safeHeight = 0.0;
          if (widget._childSize != null && widget._needSafeDisplay) {
            safeWidth = widget._childSize!.width + widget._relativeOffsetX - (MediaQuery.of(context).size.width - targetOffset.dx - targetSize.width);
            safeHeight = widget._childSize!.height + widget._relativeOffsetY - (MediaQuery.of(context).size.height - targetOffset.dy - targetSize.height);
          }

          ///如果位置相对于目标widget，从目标widget的右下方弹出
          ///弹出之前，弹出框的右下角与目标widget的右下角对齐
          childView = Positioned(
            left: targetOffset.dx -
                (widget._childSize == null ? 0 : widget._childSize!.width - targetSize.width) +
                widget._relativeOffsetX -
                (safeWidth > 0 ? safeWidth : 0),
            top: targetOffset.dy -
                (widget._childSize == null ? 0 : widget._childSize!.height - targetSize.height) +
                widget._relativeOffsetY -
                (safeHeight > 0 ? safeHeight : 0),
            child: widget._customAnimation
                ? widget._child!
                : ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 0), end: Offset(1, 1)).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                      child: FadeTransition(
                        opacity: Tween(begin: -1.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                        child: widget._child,
                      ),
                    ),
                  ),
          );
        }
        break;
      default:
        break;
    }
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                child: GestureDetector(
                  child: FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: widget._curve)).animate(widget._controller!),
                    child: Container(
                      alignment: Alignment.center,
                      color: widget._bgColor,
                    ),
                  ),
                  onTap: () {
                    if (widget._clickOutDismiss) {
                      widget.dismiss(context);
                      return;
                    }
                    if (widget._onClickOut != null) {
                      widget._onClickOut!(widget);
                    }
                  },
                ),
              ),
              childView,
            ],
          ),
        ),
        onWillPop: () {
          if (widget._clickBackDismiss) {
            widget.dismiss(context);
            return Future.value(false);
          }
          if (widget._onClickBack != null) {
            widget._onClickBack!(widget);
          }
          return Future.value(false);
        });
  }

  @override
  Widget build(BuildContext context) {
    return getLayout(context);
  }
}


