
import 'dart:async';

import 'package:flutter/material.dart';

import 'city_picker.dart';
import 'city_result.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/18
/// create_time: 21:51
/// describe: 城市选择器
///
class PickerHelper{

  /// @parm datas 自定义的json数据
  /// @parm topMenueStyle 自定义顶部按钮样式等
  static Future<CityResult> showPicker(BuildContext context, {
    List? datas,
    TopMenueStyle? topMenueStyle}) {
    Completer<CityResult> completer = Completer();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return CityPickerView(
          key: const Key('pickerkey'),
          params: datas,
          topMenueStyle: topMenueStyle,
          onResult: (res) {
            completer.complete(res);
          },
        );
      },
    );
    return completer.future;
  }
}