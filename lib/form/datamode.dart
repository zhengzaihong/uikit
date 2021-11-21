import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-21
/// create_time: 21:39
/// describe:
///
class DataMode {

  dynamic tag;
  dynamic subTag;

  String? value;

  TextEditingController? controller;

  DataMode({this.tag, this.subTag, this.value, this.controller}) {
    if (null != controller) {
      controller!.addListener(() {
        value = controller!.value.text;
      });
    }
  }

  void clear() {
    controller?.clear();
  }

  @override
  String toString() {
    return 'DataMode{tag: $tag, subTag: $subTag, value: $value, controller: $controller}';
  }
}
