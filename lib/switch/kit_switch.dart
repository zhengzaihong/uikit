import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'switch_lib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/11/17
/// create_time: 17:44
/// describe: 开关按钮组件 / Switch Component
///
/// 支持 iOS 和 Android 两种风格的开关按钮
/// Supports both iOS and Android style switches
///
/// 需要更多自定义样式请使用 [ImageSwitch] 组件
/// For more customization, use [ImageSwitch] component
///
/// ## 功能特性 / Features
/// - 🍎 支持 iOS 风格 (CupertinoSwitch) / iOS style support
/// - 🤖 支持 Android 风格 (Switch) / Android style support
/// - 🎨 支持自定义颜色 / Custom colors
/// - 📍 支持标签左右位置 / Label position (left/right)
/// - 📏 支持缩放 / Scale support
/// - 🎯 支持初始化回调 / Initial callback support
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // iOS 风格开关
/// KitSwitch(
///   isOpen: true,
///   isInnerStyle: true,
///   label: Text("开启通知"),
///   activeColor: Colors.green,
///   onChange: (value) {
///     print('开关状态: $value');
///   },
/// )
///
/// // Android 风格开关
/// KitSwitch(
///   isOpen: false,
///   isInnerStyle: false,
///   label: Text("自动更新"),
///   activeColor: Colors.blue,
///   activeTrackColor: Colors.blue.shade200,
///   onChange: (value) => print(value),
/// )
///
/// // 标签在右侧
/// KitSwitch(
///   isOpen: true,
///   labelRight: true,
///   label: Text("飞行模式"),
///   onChange: (value) => print(value),
/// )
///
/// // 自定义缩放和间距
/// KitSwitch(
///   isOpen: false,
///   scale: 0.8,
///   margin: 10,
///   label: Text("省电模式"),
///   activeColor: Colors.orange,
///   onChange: (value) => print(value),
/// )
///
/// // 自定义颜色
/// KitSwitch(
///   isOpen: true,
///   activeColor: Colors.purple,
///   activeTrackColor: Colors.purple.shade200,
///   inactiveThumbColor: Colors.grey,
///   inactiveTrackColor: Colors.grey.shade300,
///   label: Text("深色模式"),
///   onChange: (value) => print(value),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - isInnerStyle 为 true 时使用 iOS 风格 / iOS style when true
/// - isInnerStyle 为 false 时使用 Android 风格 / Android style when false
/// - enableFirstCallBack 为 true 时会在初始化时触发回调 / Triggers callback on init when true
///

class KitSwitch extends StatefulWidget {

  /// 是否打开 / Is open
  /// 默认值: true / Default: true
  final bool isOpen;

  /// 状态改变回调 / Change callback
  final ValueChanged<bool>? onChange;

  /// 标签是否在右侧 / Label on right side
  /// 默认值: false (左侧) / Default: false (left side)
  final bool labelRight;

  /// 标签组件 / Label widget
  /// 默认值: SizedBox() / Default: SizedBox()
  final Widget label;

  /// 标签与开关的间距 / Margin between label and switch
  /// 默认值: 0 / Default: 0
  final double? margin;

  /// 缩放比例 / Scale
  /// 默认值: 1.0 / Default: 1.0
  final double scale;

  /// 激活状态颜色 / Active color
  final Color? activeColor;

  /// 激活状态轨道颜色 / Active track color
  final Color? activeTrackColor;

  /// 未激活状态滑块颜色 / Inactive thumb color
  final Color? inactiveThumbColor;

  /// 未激活状态轨道颜色 / Inactive track color
  final Color? inactiveTrackColor;

  /// 开关样式 / Switch style
  /// true: iOS 风格 (内嵌样式) / iOS style (inner style)
  /// false: Android 风格 (外突样式) / Android style (outer style)
  /// 默认值: false / Default: false
  final bool? isInnerStyle;

  /// 是否在初始化时触发回调 / Enable first callback
  /// 默认值: false / Default: false
  final bool? enableFirstCallBack;
  const KitSwitch({
    this.isOpen=true,
    this.onChange,
    this.labelRight=false,
    this.isInnerStyle = false,
    this.label = const SizedBox(),
    this.enableFirstCallBack = false,
    this.margin = 0,
    this.scale=1,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    Key? key}) : super(key: key);

  @override
  State<KitSwitch> createState() => _KitSwitchState();
}

class _KitSwitchState extends State<KitSwitch> {

  late bool isOpen;
  @override
  void initState() {
    super.initState();
    isOpen = widget.isOpen;
    if(widget.enableFirstCallBack!){
      widget.onChange?.call(isOpen);
    }
  }
  @override
  Widget build(BuildContext context) {
    return widget.labelRight?
      Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildStyleSwitch(),
        SizedBox(width: widget.margin),
        widget.label
    ]):Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.label,
          SizedBox(width: widget.margin),
          buildStyleSwitch(),
        ]);
  }

  Widget buildStyleSwitch(){
    if(widget.isInnerStyle!){
      return  Transform.scale(
        scale: widget.scale,
        child: CupertinoSwitch(
          value: isOpen,
          onChanged: (v){
            widget.onChange?.call(v);
            setState(() {
              isOpen = !isOpen;
            });
          },
          activeTrackColor: widget.activeColor,
          inactiveTrackColor: widget.inactiveTrackColor,
          thumbColor: widget.inactiveThumbColor,
          // activeTrackColor: widget.activeTrackColor,
        ),
      );
    }
    return Transform.scale(
      scale: widget.scale,
      child: Switch(
        value:isOpen,
        onChanged: (v){
          widget.onChange?.call(v);
          setState(() {
            isOpen = !isOpen;
          });
        },
        activeColor: widget.activeColor,
        inactiveTrackColor: widget.inactiveTrackColor,
        inactiveThumbColor: widget.inactiveThumbColor,
        activeTrackColor: widget.activeTrackColor,
      ),
    );
  }
}
