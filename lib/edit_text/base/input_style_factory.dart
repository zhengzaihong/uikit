import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/edit_text/input_text.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/1/3
/// create_time: 9:43
/// describe: 构建各种样式的工厂基准
///
abstract class InputStyleFactory {
  InputDecoration build(
    InputTextState state, {
    bool enableClear = true,
    Widget? clearIcon,
    InputBorder? allLineBorder,
    Widget? icon,
    Color? iconColor,
    Widget? label,
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
    bool isCollapsed,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? prefix,
    String? prefixText,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    bool? isDense,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    String? counterText,
    Widget? counter,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? border,
    String? semanticCounterText,
    bool? alignLabelWithHint,
    BoxConstraints? constraints,
  });
}
