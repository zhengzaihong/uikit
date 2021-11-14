
import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-13
/// create_time: 18:02
/// describe: 用于生成表单背景的样式
///
///
enum UiType {

  ///自定义背景
  custom,
  ///本库提供的背景
  kit,
}


class BuildFormKit extends StatelessWidget {

   final UiType uiType;


   const BuildFormKit({
     this.uiType =UiType.kit ,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}








