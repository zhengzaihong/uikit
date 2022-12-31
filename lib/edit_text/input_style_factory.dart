
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/12/30
/// create_time: 17:42
/// describe: 构建各种样式的工厂
///
abstract class InputStyleFactory{

  InputDecoration build(InputTextState state,{String? hintText});

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
  InputDecoration build(InputTextState state,{String? hintText}) {
    return InputDecoration(
      hintText: "搜索用户姓名、手机号",
      filled: true,
      fillColor:  const Color(0xFFF3F5F7),
      isCollapsed: true,
      contentPadding: const EdgeInsets.fromLTRB(
          20.0, 15.0, 20.0, 15.0),
      enabledBorder: _outlineInputBorder,
      border: _outlineInputBorder,
      disabledBorder: _outlineInputBorder,
      focusedErrorBorder: _outlineInputBorder,
      errorBorder: _outlineInputBorder,
    );
  }

}

class ClearInput extends InputStyleFactory{

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
  InputDecoration build(InputTextState state,{String? hintText}) {
    return InputDecoration(
      isCollapsed: true,
      contentPadding: const EdgeInsets.fromLTRB(
          20.0, 15.0, 20.0, 15.0),
      filled: true,
      hintText: hintText,
      fillColor: Colors.white,
      enabledBorder: _outlineInputBorder,
      border: _outlineInputBorder,
      disabledBorder: _outlineInputBorder,
      focusedErrorBorder: _outlineInputBorder,
      errorBorder: _outlineInputBorder,
      suffixIcon:
      (state.hasContent)
          ? Container(
          padding: const EdgeInsetsDirectional.only(
            start: 2.0,
            end: 0,
          ),
          child: InkWell(
            onTap: (() {
              state.clearContent();
            }),
            child: const Icon(
              Icons.cancel,
              size: 18.0,
              color: Colors.grey,
            ),
          ))
          : const SizedBox(),
    );
  }

}