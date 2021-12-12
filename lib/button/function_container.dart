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

  Widget child;

  List<int> defaultCheckeds;
  int defaultCheck;

  bool allowMultipleChoice;

  ///单选的回调
  final void Function(int checkedId)? singleCheckedChange;
  ///多选的回调
  final void Function(List checkeds)? multipleCheckedChange;
  bool enableFirstdefaultCheck;

  FunctionContainer({
    Key? key,
    this.defaultCheckeds = const [],
    this.defaultCheck=0,
    required this.child,
    this.singleCheckedChange,
    this.allowMultipleChoice=false,
    this.multipleCheckedChange,
    this.enableFirstdefaultCheck = false,
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
      Future.delayed(Duration(milliseconds: 100),(){
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
    setState(() {
      if(widget.allowMultipleChoice){
        List<int> temp=[];
        widget.defaultCheckeds.contains(value)?
        widget.defaultCheckeds.remove(value):
        widget.defaultCheckeds.add(value);

        widget.defaultCheckeds.forEach((element) {
          temp.add(element);
        });
        widget.defaultCheckeds = temp;
        widget.multipleCheckedChange!(temp);
      }else{
        widget.defaultCheck = value;
        widget.singleCheckedChange!(value);
      }
    });
  }
}
