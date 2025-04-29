import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'switch_lib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/11/17
/// create_time: 17:44
/// describe: 开关按钮组件, 支持ios风格和android风格
/// 需自定义各种样式和效果请使用提供的 [ImageSwitch] 组件
/// eg:
//   CustomSwitch(
//     isOpen: false,
//     labelRight: true,
//     isInnerStyle: true,
//     label: const Text("测试"),
//     activeColor: Colors.red,
//     scale: 0.7,
//     activeTrackColor: Colors.orange,
//     inactiveThumbColor: Colors.blueAccent,
//     inactiveTrackColor: Colors.purple,
//     onChange:(v){
//       print("----->$v");
//     }),


class CustomSwitch extends StatefulWidget {

  final bool isOpen;
  final ValueChanged<bool>? onChange;
  final bool labelRight;
  final Widget label;
  final double? margin;
  final double scale;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  ///开关的样式 true内含样式ios 风格， false滑动模块外突android风格
  final bool? isInnerStyle;
  final bool? enableFirstCallBack;
  const CustomSwitch({
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
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {

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
