
import 'package:flutter/material.dart';

import 'function_container.dart';


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
  List<int>? defaultCheckeds;

  ///单选
  int defaultCheck;

  ///是否允许多选
  bool allowMultipleChoice;

  ///状态管理
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