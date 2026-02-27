
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/11/18
/// create_time: 10:29
/// describe: 复选框组件 / Checkbox Component
///
/// 支持系统默认样式和完全自定义样式的复选框
/// Supports both system default style and fully customizable style
///
/// ## 功能特性 / Features
/// - ✅ 支持系统默认样式 / System default style
/// - 🎨 支持完全自定义图标 / Fully custom icons
/// - 📍 支持图标左右位置 / Icon position (left/right)
/// - 📝 支持选中/未选中不同文本 / Different text for checked/unchecked
/// - 🎯 支持初始化回调 / Initial callback support
/// - 📏 支持缩放 / Scale support
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 系统默认样式
/// KitCheckBox(
///   text: Text("同意协议"),
///   isChecked: false,
///   onChange: (checked) {
///     print('选中状态: $checked');
///   },
/// )
///
/// // 自定义样式
/// KitCheckBox(
///   useDefaultStyle: false,
///   text: Text("记住密码"),
///   checkIcon: Icon(Icons.check_box, color: Colors.blue),
///   uncheckedIcon: Icon(Icons.check_box_outline_blank, color: Colors.grey),
///   isChecked: true,
///   onChange: (checked) => print(checked),
/// )
///
/// // 图标在左侧
/// KitCheckBox(
///   iconLeft: true,
///   text: Text("接收通知"),
///   activeColor: Colors.green,
///   onChange: (checked) => print(checked),
/// )
///
/// // 不同的选中/未选中文本
/// KitCheckBox(
///   text: Text("未选中"),
///   checkedText: Text("已选中", style: TextStyle(color: Colors.blue)),
///   onChange: (checked) => print(checked),
/// )
///
/// // 自定义缩放
/// KitCheckBox(
///   scale: 1.5,
///   text: Text("大号复选框"),
///   activeColor: Colors.purple,
///   onChange: (checked) => print(checked),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - useDefaultStyle 为 true 时使用系统样式 / Use system style when true
/// - useDefaultStyle 为 false 时必须提供 checkIcon 和 uncheckedIcon / Must provide icons when false
/// - enableFirstCallBack 为 true 时会在初始化时触发回调 / Triggers callback on init when true
///

class KitCheckBox extends StatefulWidget {

  /// 未选中时的文本 / Text when unchecked
  final Widget? text;

  /// 选中时的文本 / Text when checked
  /// 如果为 null 则使用 text / Uses text if null
  final Widget? checkedText;

  /// 选中时的图标 / Icon when checked
  /// useDefaultStyle 为 false 时必填 / Required when useDefaultStyle is false
  final Widget? checkIcon;

  /// 未选中时的图标 / Icon when unchecked
  /// useDefaultStyle 为 false 时必填 / Required when useDefaultStyle is false
  final Widget? uncheckedIcon;

  /// 图标是否在左侧 / Icon on left side
  /// 默认值: false (右侧) / Default: false (right side)
  final bool? iconLeft;

  /// 是否选中 / Is checked
  /// 默认值: false / Default: false
  final bool? isChecked;

  /// 状态改变回调 / Change callback
  final Function(bool value)? onChange;

  /// 是否在初始化时触发回调 / Enable first callback
  /// 默认值: false / Default: false
  final bool enableFirstCallBack;

  /// 主轴对齐方式 / Main axis alignment
  /// 默认值: MainAxisAlignment.start / Default: MainAxisAlignment.start
  final MainAxisAlignment mainAxisAlignment;

  /// 主轴大小 / Main axis size
  /// 默认值: MainAxisSize.min / Default: MainAxisSize.min
  final MainAxisSize mainAxisSize;

  /// 交叉轴对齐方式 / Cross axis alignment
  /// 默认值: CrossAxisAlignment.center / Default: CrossAxisAlignment.center
  final CrossAxisAlignment crossAxisAlignment;

  /// 是否使用系统默认样式 / Use default system style
  /// true: 系统样式 / System style
  /// false: 自定义样式 / Custom style
  /// 默认值: true / Default: true
  final bool? useDefaultStyle;

  /// 缩放比例 / Scale
  /// 仅在 useDefaultStyle 为 true 时生效 / Only works when useDefaultStyle is true
  /// 默认值: 1.0 / Default: 1.0
  final double? scale;

  /// 选中时的颜色 / Active color
  /// 仅在 useDefaultStyle 为 true 时生效 / Only works when useDefaultStyle is true
  final Color? activeColor;

  /// 勾选标记颜色 / Check mark color
  /// 仅在 useDefaultStyle 为 true 时生效 / Only works when useDefaultStyle is true
  final Color? checkColor;

  /// 填充颜色 / Fill color
  /// 仅在 useDefaultStyle 为 true 时生效 / Only works when useDefaultStyle is true
  final WidgetStateProperty<Color?>? fillColor;

  /// 边框样式 / Border side
  /// 仅在 useDefaultStyle 为 true 时生效 / Only works when useDefaultStyle is true
  final BorderSide? side;

  /// 水波纹半径 / Splash radius
  /// 仅在 useDefaultStyle 为 true 时生效 / Only works when useDefaultStyle is true
  final double? splashRadius;

  const KitCheckBox({
    this.text,
    this.checkedText,
    this.uncheckedIcon,
    this.checkIcon,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.useDefaultStyle = true,
    this.iconLeft = false,
    this.isChecked = false,
    this.onChange,
    this.enableFirstCallBack=false,
    this.activeColor,
    this.checkColor,
    this.scale=1,
    this.fillColor,
    this.side,
    this.splashRadius,
    Key? key}) : super(key: key);

  @override
  State<KitCheckBox> createState() => _KitCheckBoxState();

}

class _KitCheckBoxState extends State<KitCheckBox> {

  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked!;
    if(widget.enableFirstCallBack){
      callBack(false);
    }
  }

  void callBack(bool click) {
    if (widget.onChange!=null) {
      if (click) {
        isChecked = !isChecked;
      }
      widget.onChange?.call(isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildCheckBoxStyle();
  }

  Widget buildCheckBoxStyle(){
    if(widget.useDefaultStyle!){
      return GestureDetector(
        onTap: (){
          isChecked = !isChecked;
          widget.onChange?.call(isChecked);
          setState(() {});
        },
        child: widget.iconLeft! ?Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          children: [
            Transform.scale(
              scale: widget.scale,
              child: Checkbox(
                  activeColor: widget.activeColor,
                  checkColor: widget.checkColor,
                  value: isChecked,
                  side: widget.side,
                  fillColor: widget.fillColor,
                  splashRadius: widget.splashRadius,
                  onChanged: (val) {
                    isChecked = val??isChecked;
                    widget.onChange?.call(isChecked);
                    setState(() {});

                  }),
            ),
            _buildTitle()??const SizedBox(),
          ],
        ):
        Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          children: [
            _buildTitle()??const SizedBox(),
            Transform.scale(
              scale: widget.scale,
              child: Checkbox(
                  activeColor: widget.activeColor,
                  checkColor: widget.checkColor,
                  value: isChecked,
                  side: widget.side,
                  fillColor: widget.fillColor,
                  splashRadius: widget.splashRadius,
                  onChanged: (val) {
                    isChecked = val??isChecked;
                    widget.onChange?.call(isChecked);
                    setState(() {});

                  }),
            )
          ],
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              callBack(true);
            });
          }
        },
        child: widget.iconLeft! ?
        Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            children: [
              (isChecked ? widget.checkIcon : widget.uncheckedIcon)??const SizedBox(),
              _buildTitle()??const SizedBox(),
            ]) : Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            children: [
              _buildTitle()??const SizedBox(),
              (isChecked ? widget.checkIcon : widget.uncheckedIcon)??const SizedBox(),
            ]));
  }

  Widget? _buildTitle(){
    if(widget.checkedText==null){
      return widget.text;
    }
    if(isChecked){
      return widget.checkedText;
    }
    return widget.text;
  }
}
