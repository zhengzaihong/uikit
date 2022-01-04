import 'package:flutter/material.dart';

import 'function_inheritedwidget.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:10
/// describe: FunctionButton 的容器组件，子组件可以为 FunctionButton或者为其他容器包含FunctionButton
///
class FunctionContainer extends StatefulWidget {

  /// FunctionContainer 所包裹的子控件
  Widget child;

  ///默认选中的按钮--多选 allowMultipleChoice 启用
  List<int>? defaultCheckeds;
  ///默认选中的第一项按钮 --单选
  int defaultCheck;

  ///是否允许多选
  bool allowMultipleChoice;

  ///单选的回调
  Function(int checkedId)? singleCheckedChange;

  ///多选的回调
  Function(List checkeds)? multipleCheckedChange;

  ///是否开启首次选中即回调
  bool enableFirstdefaultCheck;

  ///如果是多个tab 可用于是否启用切换
  bool enable;
  Function()? enableCallBack;


  FunctionContainer({
    Key? key,
    this.defaultCheckeds,
    this.defaultCheck=0,
    required this.child,
    this.singleCheckedChange,
    this.allowMultipleChoice=false,
    this.multipleCheckedChange,
    this.enableFirstdefaultCheck = false,
    this.enable = true,
    this.enableCallBack,
  }) : super(key: key);


  static FunctionInheritedWidget? of(BuildContext context, {bool rebuild = true}) {
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

    if(widget.enableFirstdefaultCheck){
      Future.delayed(const Duration(milliseconds: 100),(){
        updateChange(widget.defaultCheck);
      });
    }

    ///将最新的数据往下传递
    return FunctionInheritedWidget(
      defaultCheckeds: widget.defaultCheckeds,
      child: widget.child,
      defaultCheck: widget.defaultCheck,
      allowMultipleChoice: widget.allowMultipleChoice,
      mangerState: this,
    );
  }

  ///提供一个方法修改数据，并通知子组件 刷新
  void updateChange(int value) {

    if(widget.enable){
      setState(() {
        if(widget.allowMultipleChoice && null!=widget.defaultCheckeds){

          List<int> temp=[];
          widget.defaultCheckeds!.contains(value)?
          widget.defaultCheckeds!.remove(value):
          widget.defaultCheckeds!.add(value);

          for (var element in widget.defaultCheckeds!) {
            temp.add(element);
          }
          widget.defaultCheckeds = temp;
          widget.multipleCheckedChange!(temp);
        }else{
          widget.defaultCheck = value;
          if(null!= widget.singleCheckedChange){
            widget.singleCheckedChange!(value);
          }
        }
      });
    }else{
      widget.enableCallBack?.call();
    }
  }
}
