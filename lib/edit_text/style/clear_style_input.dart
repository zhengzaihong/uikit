import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/edit_text/base/input_style_factory.dart';
import 'package:flutter_uikit_forzzh/edit_text/input_text.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/1/3
/// create_time: 9:48
/// describe: 带删除的输入框框样式
///
class ClearStyleInput extends InputStyleFactory {

  @override
  InputDecoration build(
      InputTextState state, {
        bool enableClear = true,
        Widget? clearIcon,
        InputBorder? allLineBorder,
        icon,
        Color? iconColor,
        label,
        String? labelText,
        TextStyle? labelStyle,
        TextStyle? floatingLabelStyle,
        String? helperText,
        TextStyle? helperStyle,
        int? helperMaxLines,
        String? hintText,
        TextStyle? hintStyle,
        TextDirection? hintTextDirection,
        int? hintMaxLines,
        String? errorText,
        TextStyle? errorStyle,
        int? errorMaxLines,
        FloatingLabelBehavior? floatingLabelBehavior,
        FloatingLabelAlignment? floatingLabelAlignment,
        EdgeInsetsGeometry? contentPadding,
        bool isCollapsed = true,
        prefixIcon,
        BoxConstraints? prefixIconConstraints,
        prefix,
        String? prefixText,
        TextStyle? prefixStyle,
        Color? prefixIconColor,
        suffixIcon,
        suffix,
        String? suffixText,
        TextStyle? suffixStyle,
        bool? isDense,
        Color? suffixIconColor,
        BoxConstraints? suffixIconConstraints,
        String? counterText,
        counter,
        TextStyle? counterStyle,
        bool? filled,
        Color? fillColor,
        Color? focusColor,
        Color? hoverColor,
        // Color? hoverColor = const Color(0xffF1F2F6),
        InputBorder? errorBorder,
        InputBorder? focusedBorder,
        InputBorder? focusedErrorBorder,
        InputBorder? disabledBorder,
        InputBorder? enabledBorder,
        InputBorder? border,
        String? semanticCounterText,
        bool? alignLabelWithHint,
        BoxConstraints? constraints,
      }) {
    return InputDecoration(
      isCollapsed: isCollapsed,
      contentPadding: contentPadding,
      filled: filled,
      hintText: hintText,
      fillColor: fillColor,
      enabledBorder:  enabledBorder??allLineBorder,
      border: border??allLineBorder,
      disabledBorder: disabledBorder??allLineBorder,
      focusedErrorBorder: focusedErrorBorder??allLineBorder,
      errorBorder:  errorBorder??allLineBorder,
      focusedBorder: focusedBorder??allLineBorder,
      icon: icon,
      iconColor: iconColor,
      label: label,
      labelText: labelText,
      labelStyle: labelStyle,
      floatingLabelStyle: floatingLabelStyle,
      helperText: helperText,
      helperStyle: helperStyle,
      helperMaxLines: helperMaxLines,
      hintStyle: hintStyle,
      hintTextDirection: hintTextDirection,
      hintMaxLines: hintMaxLines,
      errorText: errorText,
      errorStyle: errorStyle,
      errorMaxLines: errorMaxLines,
      floatingLabelBehavior: floatingLabelBehavior,
      floatingLabelAlignment: floatingLabelAlignment,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      prefix: prefix,
      prefixText: prefixText,
      prefixStyle: prefixStyle,
      prefixIconColor: prefixIconColor,
      suffix: suffix,
      suffixText: suffixText,
      suffixStyle: suffixStyle,
      suffixIconColor: suffixIconColor,
      suffixIconConstraints: suffixIconConstraints,
      counter: counter,
      counterText: counterText,
      counterStyle: counterStyle,
      focusColor: focusColor,
      hoverColor: hoverColor,
      semanticCounterText: semanticCounterText,
      alignLabelWithHint: alignLabelWithHint,
      constraints: constraints,
      suffixIcon: (state.getHasContent() && enableClear && state.getIsEnable())
          ? GestureDetector(
            onTap: (() {
              state.clearContent();
            }),
            child: clearIcon,
          )
          : const Text(""),
    );
  }
}
