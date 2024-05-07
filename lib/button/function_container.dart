import 'package:flutter/material.dart';
import 'function_inheritedwidget.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:10
/// describe: 容器组件，子组件为 FunButtonBox 下组件
/// ps:0.18开始 FunctionButton ,FunctionCheckbox,FunctionRadioButton 由  FunButtonBox取代
///
class FunctionContainer extends StatefulWidget {

  /// FunctionContainer 所包裹的子控件
  Widget child;

  ///默认选中的按钮--多选 allowMultipleChoice 启用
  List<int>? defaultChecks;
  ///默认选中的第一项按钮 --单选
  int defaultCheck;

  ///是否允许多选
  bool allowMultipleChoice;

  ///单选的回调
  Function(int checkedId)? singleCheckedChange;

  ///多选的回调
  Function(List checkeds)? multipleCheckedChange;

  ///是否开启首次选中即回调
  bool enableFirstDefaultCheck;

  ///如果利用 FunctionContainer做tab 可用于是否启用切换
  bool enable;
  Function()? enableCallBack;

  ///互斥的index 通常用于有全选 和其他选项的的互斥效果
  int mutualExclusionIndex;

  FunctionContainer({
    Key? key,
    this.defaultChecks,
    this.defaultCheck=0,
    required this.child,
    this.mutualExclusionIndex =-1,
    this.singleCheckedChange,
    this.allowMultipleChoice=false,
    this.multipleCheckedChange,
    this.enableFirstDefaultCheck = false,
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

    if(widget.enableFirstDefaultCheck){
      Future.delayed(const Duration(milliseconds: 100),(){
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

    if(widget.enable){
      setState(() {
        if(widget.allowMultipleChoice && null!=widget.defaultChecks){

           List<int> temp=[];
           if(widget.mutualExclusionIndex>=0){
             if(value == widget.mutualExclusionIndex){
               widget.defaultChecks?.clear();
               widget.defaultChecks?.add(value);
             }else{
               widget.defaultChecks?.remove(widget.mutualExclusionIndex);

               widget.defaultChecks!.contains(value)?
               widget.defaultChecks!.remove(value):
               widget.defaultChecks!.add(value);
             }

             for (var element in widget.defaultChecks!) {
               temp.add(element);
             }

           }else{
             widget.defaultChecks!.contains(value)?
             widget.defaultChecks!.remove(value):
             widget.defaultChecks!.add(value);
             for (var element in widget.defaultChecks!) {
               temp.add(element);
             }
           }
           widget.defaultChecks = temp;
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
