
import 'package:flutter/material.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:21
/// describe:  组件共享数据的容器
///

@immutable
class FunctionInheritedWidget extends InheritedWidget {

  ///多选选中id
  final List<int>? defaultChecks;
  ///单选
  final int defaultCheck;

  ///是否允许多选
  final bool allowMultipleChoice;

  ///状态管理
  final FunctionContainerState? mangerState;

  const FunctionInheritedWidget({
    Key? key,
    required Widget child,
    this.defaultChecks=const [],
    this.defaultCheck=0,
    this.allowMultipleChoice= false ,
    this.mangerState
  }) : super(key: key, child: child);


  @override
  bool updateShouldNotify(FunctionInheritedWidget oldWidget) {
    return allowMultipleChoice?
    defaultChecks != oldWidget.defaultChecks:
    defaultCheck != oldWidget.defaultCheck;
  }
}


class FunctionContainer extends StatefulWidget {

  /// FunctionContainer 所包裹的子控件
  final Widget child;

  ///默认选中的按钮--多选 allowMultipleChoice 启用
  final List<int>? defaultChecks;

  ///默认选中的第一项按钮 --单选
  final int defaultCheck;

  ///是否允许多选
  final bool allowMultipleChoice;

  ///单选的回调
  final Function(int checkedId)? singleCheckedChange;

  ///多选的回调
  final Function(List checkeds)? multipleCheckedChange;

  ///是否开启首次选中即回调
  final bool enableFirstDefaultCheck;

  ///如果利用 FunctionContainer做tab 可用于是否启用切换
  final bool enable;
  final Function()? enableCallBack;

  ///互斥的index 通常用于有全选 和其他选项的的互斥效果
  final int mutualExclusionIndex;

  const FunctionContainer({
    Key? key,
    this.defaultChecks = const[],
    this.defaultCheck = 0,
    required this.child,
    this.mutualExclusionIndex = -1,
    this.singleCheckedChange,
    this.allowMultipleChoice = false,
    this.multipleCheckedChange,
    this.enableFirstDefaultCheck = false,
    this.enable = true,
    this.enableCallBack,
  }) : super(key: key);

  static FunctionInheritedWidget? of(BuildContext context,
      {bool rebuild = true}) {
    return rebuild
        ? context.dependOnInheritedWidgetOfExactType<FunctionInheritedWidget>()
        : ((context.findAncestorWidgetOfExactType<FunctionInheritedWidget>()));
  }

  @override
  FunctionContainerState createState() => FunctionContainerState();
}

class FunctionContainerState extends State<FunctionContainer> {
  @override
  Widget build(BuildContext context) {
    if (widget.enableFirstDefaultCheck) {
      Future.delayed(const Duration(milliseconds: 100), () {
        updateChange(widget.defaultCheck);
      });
    }

    ///将最新的数据往下传递
    return FunctionInheritedWidget(
      defaultChecks: widget.defaultChecks,
      child: widget.child,
      defaultCheck: widget.defaultCheck,
      allowMultipleChoice: widget.allowMultipleChoice,
      mangerState: this,
    );
  }

  ///提供一个方法修改数据，并通知子组件 刷新
  void updateChange(int value) {
    if (widget.enable) {
      setState(() {
        if (widget.allowMultipleChoice && null != widget.defaultChecks) {
          List<int> temp = [];
          if (widget.mutualExclusionIndex >= 0) {
            if (value == widget.mutualExclusionIndex) {
              widget.defaultChecks?.clear();
              widget.defaultChecks?.add(value);
            } else {
              widget.defaultChecks?.remove(widget.mutualExclusionIndex);

              widget.defaultChecks!.contains(value)
                  ? widget.defaultChecks!.remove(value)
                  : widget.defaultChecks!.add(value);
            }

            for (var element in widget.defaultChecks!) {
              temp.add(element);
            }
          } else {
            widget.defaultChecks!.contains(value)
                ? widget.defaultChecks!.remove(value)
                : widget.defaultChecks!.add(value);
            for (var element in widget.defaultChecks!) {
              temp.add(element);
            }
          }
          widget.defaultChecks?.clear();
          widget.defaultChecks?.addAll(temp);
          widget.multipleCheckedChange!(temp);
        } else {
          widget.singleCheckedChange?.call(value);
        }
      });
    } else {
      widget.enableCallBack?.call();
    }
  }
}
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
