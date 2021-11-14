import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-13
/// create_time: 19:07
/// describe: 一行输入框中可能存在多个 widget,则是分割标识
///
abstract class SplitWidget extends StatelessWidget {
  Widget createSplit();
  @override
  Widget build(BuildContext context) {
    return createSplit();
  }
}