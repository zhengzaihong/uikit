
import 'package:flutter/foundation.dart';
import '../../utils/str_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/2/1
/// create_time: 17:52
/// describe: 输入框基础校验器,内置校验不满足时可继承该类或仿写校验规则
///
class InputValidation {

  final bool? mustFill;
  final int? minLength;
  final int? maxLength;
  final String? errorMsg;
  final String? format;
  final String? emptyTip;
  final List? formatValues;
  final RegExp? regExp;

  const InputValidation({ this.mustFill = true,
    this.minLength,
    this.maxLength,
    this.regExp,
    this.errorMsg,
    this.format,
    this.emptyTip = "输入不能为空",
    this.formatValues = const [],
  });

  String? validate(value) {
    if ((mustFill != null && mustFill != false) &&
        (value == null || value.isEmpty)) {
      return emptyTip;
    }
    if (regExp != null) {
      if (StrUtils.isEmpty(value) && mustFill!) {
        return emptyTip;
      }
      if(StrUtils.isNotEmpty(value) && !mustFill! && !regExp!.hasMatch(value)) {
        return errorMsg;
      }

      if (mustFill! && !regExp!.hasMatch(value)) {
        return errorMsg;
      }
      return null;
    }

    if (format == null && errorMsg != null) {
      if (minLength != null && value.length < minLength) {
        return errorMsg;
      }
      if (maxLength != null && value.length > maxLength) {
        return errorMsg;
      }
    }
    if (format != null) {
      if (minLength != null && value.length < minLength) {
        return _strFormat();
      }
      if (maxLength != null && value.length > maxLength) {
        return _strFormat();
      }
    }
    return null;
  }

  String _strFormat() {
    if (StrUtils.isEmpty(format)) {
      return "";
    }
    if (format!.contains("%s")) {
      var list = format!.split("%s");
      if (list.length - 1 != formatValues!.length) {
        debugPrint("InputValidation: 校验中占位符和填充内容长度不匹配~");
        debugPrint("InputValidation: The length of the placeholder and padding content in the check do not match~");
        return errorMsg ?? "";
      }
      StringBuffer buffer = StringBuffer();
      int index = 0;
      for (var item in list) {
        if (index != 0) {
          buffer.write(formatValues![index - 1]);
        }
        buffer.write(item);
        index++;
      }
      return buffer.toString();
    }
    return format!;
  }
}