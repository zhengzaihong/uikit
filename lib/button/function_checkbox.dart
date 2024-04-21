import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/button/function_container.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/1/4
/// create_time: 15:42
/// describe: 支持单选和多选的复选框功能组件 顶层需要FunctionContainer包装
///
class FunctionCheckbox extends StatefulWidget {
  final Text checkedText;
  final Text unCheckedText;
  final Widget checkIcon;
  final Widget uncheckedIcon;
  final bool iconLeft;
  final int index;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final MainAxisSize mainAxisSize;

  const FunctionCheckbox(
      {required this.checkedText,
      required this.unCheckedText,
      required this.uncheckedIcon,
      required this.checkIcon,
      this.iconLeft = true,
      this.index = 0,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.min,
      Key? key})
      : super(key: key);

  @override
  _FunctionCheckBoxState createState() => _FunctionCheckBoxState();
}

class _FunctionCheckBoxState extends State<FunctionCheckbox> {
  late Text checkedText;
  late Text unCheckedText;
  late Widget checkIcon;
  late Widget uncheckedIcon;
  late bool iconLeft;
  late bool checked;

  @override
  void initState() {
    super.initState();
    checkedText = widget.checkedText;
    unCheckedText = widget.unCheckedText;
    checkIcon = widget.checkIcon;
    uncheckedIcon = widget.uncheckedIcon;
    iconLeft = widget.iconLeft;
  }

  @override
  Widget build(BuildContext context) {
    final containerManger = FunctionContainer.of(context);
    final checks= containerManger?.defaultChecks;
    final allow = containerManger?.allowMultipleChoice;
    final check = containerManger?.defaultCheck;
    if (allow!) {
      checked = checks!.contains(widget.index);
    } else {
      checked = (check == widget.index);
    }

    return GestureDetector(
        onTap: () {
          containerManger?.mangerState?.updateChange(widget.index);
        },
        child: iconLeft
            ? Row(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                    checked ? checkIcon : uncheckedIcon,
                    checked ? checkedText : unCheckedText,
                  ])
            : Row(
                mainAxisSize: widget.mainAxisSize,
                crossAxisAlignment: widget.crossAxisAlignment,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                    checked ? checkedText : unCheckedText,
                    checked ? checkIcon : uncheckedIcon,
                  ]));
  }
}
