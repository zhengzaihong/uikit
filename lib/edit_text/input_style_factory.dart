
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/12/30
/// create_time: 17:42
/// describe: 构建各种样式的工厂
///
abstract class InputStyleFactory{

  InputDecoration build();

}

class NormalInput extends InputStyleFactory{

  //边框样式
  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    gapPadding: 0,

    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: Colors.red,
      width: 0.5
    ),
  );

  @override
  InputDecoration build() {
    return InputDecoration(
      fillColor: Colors.grey[50],
      filled: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
      border: _outlineInputBorder,
      focusedBorder: _outlineInputBorder,
      enabledBorder: _outlineInputBorder,
      disabledBorder: _outlineInputBorder,
      focusedErrorBorder: _outlineInputBorder,
      errorBorder: _outlineInputBorder,
    );
  }

}