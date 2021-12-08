import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/8
/// create_time: 11:09
/// describe: 用于下拉框返回多个值的包裹内容
///

 class DropWapper{
  ///下拉列表
  List<DropdownMenuItem> drops;
  ///初始值
  dynamic initValue;

  DropWapper({required this.drops,required this.initValue});
}