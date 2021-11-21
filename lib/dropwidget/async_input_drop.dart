import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-21
/// create_time: 12:31
/// describe: 支持异步加载的选择下拉框
///

typedef GestureTapCallback = void Function();

typedef ItemWidget<T> = List<DropdownMenuItem> Function(List<T> list);

typedef AsyncLoad<T> = Future<T> Function(Completer completer);

class AsyncInputDrop<T> extends StatelessWidget {
  final TextEditingController controller;

  //下拉框数组
  final List? contentList;

  // 输入框是否只读 默认 false
  final bool? readOnly;

  //文字显示的位置
  final TextAlign? textAlign;

  //输入框键盘样式
  final TextInputType? keyboardType;

  //输入框右边显示的widget
  final Widget? suffixIcon;

  // 下拉框点击事件
  final ValueChanged<Object?>? onChanged;

  // 输入框输入的类型限制，只能输入数字、汉字等
  final List<TextInputFormatter>? inputFormatters;

  final ItemWidget? itemWidget;
  final AsyncLoad<T>? asyncLoad;

  final BoxDecoration decoration;

  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  final EdgeInsetsGeometry margin;

  final InputDecoration inputdecoration;

  const AsyncInputDrop(
      {this.decoration = const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      required this.controller,
        required this.itemWidget,
        required  this.asyncLoad,
      this.contentList,
      this.readOnly = false,
      this.textAlign,
      this.keyboardType,
      this.suffixIcon,
      this.onChanged,
      this.inputFormatters,

      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0),
      this.alignment = Alignment.center,
      this.inputdecoration = const InputDecoration(
        border: InputBorder.none,
        hintText: "请输入",
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: FutureBuilder<T>(
        future: asyncLoad!(Completer()),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const Text('加载出错');
          }
          return DropdownButtonFormField<dynamic>(
              decoration: inputdecoration,
              icon: suffixIcon,
              // value: controller.text == '' ? null : controller.text,
              items: itemWidget!(contentList!),
              onChanged: (title) {
                print("----------选择打印${title.toString()}-->");
                controller.text = title.toString();
                if (onChanged != null) {
                  onChanged!(title);
                }
              });
        },
      ),
    );
  }
}
