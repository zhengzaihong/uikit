import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2023/5/31
/// time: 14:59
/// describe: 键盘相关
///
class KeyBoard{
  KeyBoard._();

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}