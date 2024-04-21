import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/button/function_container.dart';
import 'package:flutter_uikit_forzzh/button/function_inheritedwidget.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/1
/// create_time: 9:40
/// describe: 封装一个功能按钮组件 背景切换 功能组件 顶层需要FunctionContainer包装
/// 支持 上下左右 添加其他元素的组件
///

typedef BuilderBox = Widget Function(BuildContext context,FunButtonBoxState state,bool isCheck);

class FunButtonBox extends StatefulWidget {
  final int index;
  final Color highlightColor;
  final Color hoverColor;
  final Color? focusColor;
  final Color? splashColor;
  final double? radius;
  ///是否可点击
  final bool enableClick;
  final BuilderBox builderBox;

  const FunButtonBox({
    required this.index,
    required this.builderBox,
    this.highlightColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.focusColor,
    this.splashColor,
    this.radius,
    this.enableClick = true,
    Key? key,
  }) : super(key: key);

  @override
  FunButtonBoxState createState() => FunButtonBoxState();
}

class FunButtonBoxState extends State<FunButtonBox> {
  Decoration? decoration;
  TextStyle? style;
  Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    final containerManger = FunctionContainer.of(context);
    final checks = containerManger?.defaultChecks;
    final allow = containerManger?.allowMultipleChoice;
    final check = containerManger?.defaultCheck;

    bool isCheck = false;
    if (allow!) {
      isCheck = checks!.contains(widget.index);
    } else {
      isCheck = check == widget.index;
    }
    return InkWell(
        highlightColor: widget.highlightColor,
        hoverColor: widget.hoverColor,
        focusColor: widget.focusColor,
        splashColor: widget.splashColor,
        radius: widget.radius,
        onTap: () {
          _updateChange(containerManger);
        },
        child:widget.builderBox.call(context,this,isCheck));
  }

  void updateChange() {
    if (widget.enableClick) {
      final containerManger = FunctionContainer.of(context);
      containerManger?.mangerState?.updateChange(widget.index);
    }
  }

  void _updateChange(FunctionInheritedWidget? containerManger) {
    if (widget.enableClick) {
      containerManger?.mangerState?.updateChange(widget.index);
    }
  }
}
