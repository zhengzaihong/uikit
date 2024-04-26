import 'dart:math';

import 'package:flutter/material.dart';

/// 开关默认width
const double _kDefaultWidth = 80;

/// 开关默认height
const double _kDefaultHeight = 30;

/// 开启状态下默认颜色
const Color _kDefaultActiveColor = Colors.blueAccent;

/// 关闭状态下默认颜色
const Color _kDefaultInactiveColor = Colors.white;


/// 默认过度动画时长
const Duration _kDefaultDuration = Duration(milliseconds: 800);

typedef BuilderSwitch = Widget Function(
    BuildContext context,
    AnimationController controller,
    Animation<Color?> colorTrackAnimation,
    Animation<Color?> colorThumbAnimation,
    Animation<Alignment> alignmentAnimation,
    );

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/4/19
/// create_time: 16:53
/// describe: 自定义开关组件
/// 简单示例 eg：
// ImageSwitch(
//   value: false,
//   width: 60,
//   rotate: true,
//   radius: 25,
//   height: 35,
//   activeTrackColor:const Color(0xff40D3A2),
//   inactiveTrackColor: Colors.grey,
//   // activeThumbColor: Colors.green,
//   // inactiveThumbColor: Colors.grey,
//   duration: const Duration(milliseconds: 500),
//   // activeBorderColor: Colors.red,
//   // inactiveBorderColor: Colors.purpleAccent,
//   inactiveImage: Image.asset(windowsImage('theme_light.png')),
//   activeImage: Image.asset(windowsImage('theme_dark.png')),
//   onChanged: (v){
//     print('-------v:$v');
//   },
// )

class ImageSwitch extends StatefulWidget {
  const ImageSwitch({
    Key? key,
    required this.value,
    this.builder,
    this.rotate = false,
    this.onChanged,
    this.width = _kDefaultWidth,
    this.height = _kDefaultHeight,
    this.radius = _kDefaultHeight / 2, // radius
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.activeTrackColor = _kDefaultActiveColor,
    this.inactiveTrackColor = _kDefaultInactiveColor,
    this.activeThumbColor = Colors.greenAccent,
    this.inactiveThumbColor = Colors.grey,
    this.activeImage,
    this.inactiveImage,
    this.duration = _kDefaultDuration,
    this.paddingHorizontal = 1.5,
    this.defaultStyleSize = _kDefaultHeight-4,
    this.defaultStyleRadius = 15,
  }): super(key: key);

  final BuilderSwitch? builder;

  /// 是否开启滚动
  final bool rotate;

  /// 开关是开还是关，不能设置为null
  final bool value;

  /// 开关发生变化时回调
  final ValueChanged<bool>? onChanged;

  /// 开关 width
  final double width;

  /// 开关 height
  final double height;

  ///轨道圆角度数
  final double radius;

  /// 开启状态下轨道的颜色
  final Color activeTrackColor;

  /// 关闭状态下轨道的颜色
  final Color inactiveTrackColor;

  /// 开启状态下边框颜色
  final Color? activeBorderColor;

  /// 关闭状态下边框颜色
  final Color? inactiveBorderColor;

  /// 开启状态下滑块的颜色
  final Color? activeThumbColor;
  /// 关闭状态下滑块的颜色
  final Color? inactiveThumbColor;

  /// 开启状态下滑块的组件 自定义视图 activeThumbColor失效
  final Widget? activeImage;

  /// 关闭状态下滑块的组件 自定义视图 inactiveThumbColor失效
  final Widget? inactiveImage;

  /// 过度动画时长
  final Duration duration;

  final double paddingHorizontal;

  ///默认样式的大小
  final double defaultStyleSize;

  ///默认样式的圆角度
  final double defaultStyleRadius;

  @override
  State<ImageSwitch> createState() => _ImageSwitchState();
}

class _ImageSwitchState extends State<ImageSwitch>
    with SingleTickerProviderStateMixin {

  Animation<Color?>? _borderColorAnimation;
  late Widget _activeImage;
  late Widget _inactiveImage;
  late AnimationController _controller;
  late bool _value;
  late Animation<Color?> _colorTrackAnimation;
  late Animation<Color?> _colorThumbAnimation;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {

    _value = widget.value;
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _colorTrackAnimation = ColorTween(
      begin: widget.value ? widget.activeTrackColor : widget.inactiveTrackColor,
      end: !widget.value ? widget.activeTrackColor : widget.inactiveTrackColor,
    ).animate(_controller);

    if(widget.activeBorderColor != null && widget.inactiveBorderColor != null){
      _borderColorAnimation = ColorTween(
        begin: widget.value ? widget.activeBorderColor : widget.inactiveBorderColor,
        end: !widget.value ? widget.activeBorderColor : widget.inactiveTrackColor,
      ).animate(_controller);
    }

    _colorThumbAnimation = ColorTween(
      begin: widget.value ? widget.activeThumbColor : widget.inactiveThumbColor,
      end: !widget.value ? widget.activeThumbColor : widget.inactiveThumbColor,
    ).animate(_controller);

    _alignmentAnimation = AlignmentTween(
      begin: !widget.value ? Alignment.centerLeft : Alignment.centerRight,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thumbSize = _computeThumbSize();

    return GestureDetector(
      onTap: () {
        if (_controller.isAnimating) {
          return;
        }
        if (_controller.isDismissed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        _value = !_value;
        widget.onChanged?.call(_value);
      },
      child: AnimatedBuilder(
        animation: _colorTrackAnimation,
        builder: (BuildContext context, Widget? child) {
          Widget thumb;
          _activeImage = widget.activeImage ??
              Container(
                width: widget.defaultStyleSize,
                height: widget.defaultStyleSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.defaultStyleRadius),
                  color:widget.activeThumbColor,
                ),
              );

          _inactiveImage = widget.inactiveImage ??
              Container(
                width: widget.defaultStyleSize,
                height: widget.defaultStyleSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.defaultStyleRadius),
                  color: widget.inactiveThumbColor,
                ),
              );

          if (_controller.isAnimating) {
            thumb = _controller.value > 0.5
                ? _activeImage
                : _inactiveImage;
          } else {
            thumb = _value ? _activeImage : _inactiveImage;
          }
          return Container(
            height: widget.height,
            width: widget.width,
            alignment: _alignmentAnimation.value,
            padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: _colorTrackAnimation.value,
              border: Border.all(color: (_borderColorAnimation==null?_colorTrackAnimation.value:_borderColorAnimation?.value )?? Colors.transparent,),),
            child: widget.rotate
                ? Transform(
              transform: Matrix4.rotationZ(widget.value
                  ? -1 * _controller.value * pi * 2
                  : _controller.value * pi * 2,),
              origin: Offset(thumbSize / 2, thumbSize / 2),
              child: SizedBox(
                height: thumbSize,
                width: thumbSize,
                child: Center(
                  child: widget.builder == null
                      ? thumb
                      : widget.builder?.call(
                    context,
                    _controller,
                    _colorTrackAnimation,
                    _colorThumbAnimation,
                    _alignmentAnimation,),
                ),
              ),
            )
                : SizedBox(
              height: thumbSize,
              width: thumbSize,
              child: Center(
                child: widget.builder == null
                    ? thumb
                    : widget.builder?.call(
                  context,
                  _controller,
                  _colorTrackAnimation,
                  _colorThumbAnimation,
                  _alignmentAnimation,),
              ),
            ),
          );
        },
      ),
    );
  }

  double _computeThumbSize() {
    return min(widget.height, widget.width) - widget.paddingHorizontal * 2;
  }
}
