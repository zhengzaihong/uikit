import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-13
/// create_time: 20:43
/// describe: 自定义的基础控件
///
abstract class BaseCustomWidget extends StatelessWidget {
  Widget buildChild(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return build(context);
  }
}
