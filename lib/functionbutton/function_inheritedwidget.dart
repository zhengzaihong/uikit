
import 'package:flutter/material.dart';
import 'package:uikit/functionbutton/function_container.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/5/22
/// create_time: 17:21
/// describe:  组件共享数据的容器
///
///
class FunctionInheritedWidget extends InheritedWidget {

  ///多选选中id
  List<int> defaultCheckeds;

  ///单选
  int defaultCheck;

  bool allowMultipleChoice;


  FunctionContainerState? mangerState;

  FunctionInheritedWidget({
    Key? key,
    required Widget child,
     this.defaultCheckeds=const [],
     this.defaultCheck=0,
     this.allowMultipleChoice= false ,
     this.mangerState
  }) : super(key: key, child: child);


  @override
  bool updateShouldNotify(FunctionInheritedWidget oldWidget) {
    return allowMultipleChoice?
    defaultCheckeds != oldWidget.defaultCheckeds:
    defaultCheck != oldWidget.defaultCheck;
  }
}