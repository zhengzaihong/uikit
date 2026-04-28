
import 'package:flutter/foundation.dart';
import '../../utils/str_utils.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2023/2/1
/// time: 17:52
/// describe: 输入框基础校验器,内置校验不满足时可继承该类或仿写校验规则
///
/// ## 功能特性 / Features
/// - ✅ 必填校验 / Required validation
/// - 📏 长度范围校验 / Length range validation
/// - 🔤 正则表达式校验 / RegExp validation
/// - 📧 内置常用格式校验 / Built-in format validation (email, phone, url, etc.)
/// - 🔗 多规则组合校验 / Multiple rules validation
/// - 🌐 自定义错误消息 / Custom error messages
/// - 🎯 条件校验 / Conditional validation
///
/// ## 基础示例 / Basic Example
/// ```dart
/// InputText(
///   enableForm: true,
///   controller: TextEditingController(),
///   validator: const InputValidation(
///     mustFill: true,
///     minLength: 6,
///     maxLength: 12,
///     errorMsg: "密码长度为6-12位",
///   ).validate,
/// )
/// ```
///
/// ## 正则表达式示例 / RegExp Example
/// ```dart
/// InputText(
///   enableForm: true,
///   controller: TextEditingController(),
///   validator: InputValidation.email(
///     errorMsg: "请输入正确的邮箱地址",
///   ).validate,
/// )
/// ```
///
/// ## 多规则组合 / Multiple Rules
/// ```dart
/// InputText(
///   enableForm: true,
///   controller: TextEditingController(),
///   validator: InputValidation.combine([
///     const InputValidation(mustFill: true, emptyTip: "不能为空"),
///     InputValidation.minLength(6, errorMsg: "至少6个字符"),
///     InputValidation.maxLength(20, errorMsg: "最多20个字符"),
///   ]),
/// )
/// ```
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
  
  /// 自定义校验函数 / Custom validation function
  final String? Function(String?)? customValidator;
  
  /// 条件校验：只有当此函数返回 true 时才执行校验 / Conditional validation
  final bool Function()? condition;

  const InputValidation({ 
    this.mustFill = true,
    this.minLength,
    this.maxLength,
    this.regExp,
    this.errorMsg,
    this.format,
    this.emptyTip = "输入不能为空",
    this.formatValues = const [],
    this.customValidator,
    this.condition,
  });

  // ==================== 工厂构造函数 / Factory Constructors ====================
  
  /// 邮箱校验 / Email validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.email(errorMsg: "请输入正确的邮箱").validate
  /// ```
  factory InputValidation.email({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'),
      errorMsg: errorMsg ?? "请输入正确的邮箱地址",
      emptyTip: emptyTip ?? "邮箱不能为空",
    );
  }

  /// 手机号校验（中国大陆）/ Chinese phone number validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.phone(errorMsg: "请输入正确的手机号").validate
  /// ```
  factory InputValidation.phone({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^1[3-9]\d{9}$'),
      errorMsg: errorMsg ?? "请输入正确的手机号",
      emptyTip: emptyTip ?? "手机号不能为空",
    );
  }

  /// URL 校验 / URL validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.url(errorMsg: "请输入正确的网址").validate
  /// ```
  factory InputValidation.url({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'),
      errorMsg: errorMsg ?? "请输入正确的网址",
      emptyTip: emptyTip ?? "网址不能为空",
    );
  }

  /// 身份证号校验（中国大陆）/ Chinese ID card validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.idCard(errorMsg: "请输入正确的身份证号").validate
  /// ```
  factory InputValidation.idCard({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$'),
      errorMsg: errorMsg ?? "请输入正确的身份证号",
      emptyTip: emptyTip ?? "身份证号不能为空",
    );
  }

  /// 数字校验 / Number validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.number(errorMsg: "请输入数字").validate
  /// ```
  factory InputValidation.number({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
    bool allowDecimal = true,
    bool allowNegative = true,
  }) {
    String pattern;
    if (allowDecimal && allowNegative) {
      pattern = r'^-?\d*\.?\d+$';
    } else if (allowDecimal && !allowNegative) {
      pattern = r'^\d*\.?\d+$';
    } else if (!allowDecimal && allowNegative) {
      pattern = r'^-?\d+$';
    } else {
      pattern = r'^\d+$';
    }
    
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(pattern),
      errorMsg: errorMsg ?? "请输入${allowNegative ? '' : '正'}${allowDecimal ? '数字' : '整数'}",
      emptyTip: emptyTip ?? "数字不能为空",
    );
  }

  /// 数字范围校验 / Number range validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.numberRange(min: 1, max: 100, errorMsg: "请输入1-100之间的数字").validate
  /// ```
  factory InputValidation.numberRange({
    required num min,
    required num max,
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
  }) {
    return InputValidation(
      mustFill: mustFill,
      emptyTip: emptyTip ?? "数字不能为空",
      customValidator: (value) {
        if (value == null || value.isEmpty) return null;
        final number = num.tryParse(value);
        if (number == null) {
          return errorMsg ?? "请输入有效的数字";
        }
        if (number < min || number > max) {
          return errorMsg ?? "请输入$min-$max之间的数字";
        }
        return null;
      },
    );
  }

  /// 最小长度校验 / Minimum length validation
  factory InputValidation.minLength(int length, {String? errorMsg, bool mustFill = false}) {
    return InputValidation(
      mustFill: mustFill,
      minLength: length,
      errorMsg: errorMsg ?? "至少需要$length个字符",
    );
  }

  /// 最大长度校验 / Maximum length validation
  factory InputValidation.maxLength(int length, {String? errorMsg, bool mustFill = false}) {
    return InputValidation(
      mustFill: mustFill,
      maxLength: length,
      errorMsg: errorMsg ?? "最多$length个字符",
    );
  }

  /// 密码强度校验 / Password strength validation
  /// 
  /// 要求：至少8位，包含大小写字母、数字和特殊字符
  /// Requirements: At least 8 characters, including uppercase, lowercase, numbers and special characters
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.strongPassword(errorMsg: "密码强度不够").validate
  /// ```
  factory InputValidation.strongPassword({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
    int minLength = 8,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{' + minLength.toString() + r',}$'),
      errorMsg: errorMsg ?? "密码至少${minLength}位，需包含大小写字母、数字和特殊字符",
      emptyTip: emptyTip ?? "密码不能为空",
    );
  }

  /// 用户名校验 / Username validation
  /// 
  /// 要求：4-20位，只能包含字母、数字、下划线
  /// Requirements: 4-20 characters, only letters, numbers and underscores
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.username(errorMsg: "用户名格式不正确").validate
  /// ```
  factory InputValidation.username({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
    int minLength = 4,
    int maxLength = 20,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^[a-zA-Z0-9_]{' + minLength.toString() + ',' + maxLength.toString() + r'}$'),
      errorMsg: errorMsg ?? "用户名为$minLength-$maxLength位字母、数字或下划线",
      emptyTip: emptyTip ?? "用户名不能为空",
    );
  }

  /// 中文校验 / Chinese characters validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.chinese(errorMsg: "请输入中文").validate
  /// ```
  factory InputValidation.chinese({
    String? errorMsg,
    String? emptyTip,
    bool mustFill = true,
  }) {
    return InputValidation(
      mustFill: mustFill,
      regExp: RegExp(r'^[\u4e00-\u9fa5]+$'),
      errorMsg: errorMsg ?? "请输入中文",
      emptyTip: emptyTip ?? "内容不能为空",
    );
  }

  /// 自定义校验 / Custom validation
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.custom(
  ///   validator: (value) {
  ///     if (value == "admin") return "用户名不能为admin";
  ///     return null;
  ///   },
  /// ).validate
  /// ```
  factory InputValidation.custom({
    required String? Function(String?) validator,
    bool mustFill = false,
    String? emptyTip,
  }) {
    return InputValidation(
      mustFill: mustFill,
      emptyTip: emptyTip,
      customValidator: validator,
    );
  }

  /// 条件校验 / Conditional validation
  /// 
  /// 只有当 condition 返回 true 时才执行校验
  /// Only validate when condition returns true
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.conditional(
  ///   condition: () => isRequired,
  ///   validation: const InputValidation(mustFill: true, emptyTip: "此项必填"),
  /// ).validate
  /// ```
  factory InputValidation.conditional({
    required bool Function() condition,
    required InputValidation validation,
  }) {
    return InputValidation(
      mustFill: validation.mustFill,
      minLength: validation.minLength,
      maxLength: validation.maxLength,
      regExp: validation.regExp,
      errorMsg: validation.errorMsg,
      format: validation.format,
      emptyTip: validation.emptyTip,
      formatValues: validation.formatValues,
      customValidator: validation.customValidator,
      condition: condition,
    );
  }

  // ==================== 静态方法 / Static Methods ====================

  /// 组合多个校验规则 / Combine multiple validation rules
  /// 
  /// 按顺序执行所有校验，返回第一个错误
  /// Execute all validations in order, return the first error
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.combine([
  ///   const InputValidation(mustFill: true, emptyTip: "不能为空"),
  ///   InputValidation.minLength(6, errorMsg: "至少6个字符"),
  ///   InputValidation.email(errorMsg: "邮箱格式不正确"),
  /// ])
  /// ```
  static String? Function(String?) combine(List<InputValidation> validations) {
    return (String? value) {
      for (var validation in validations) {
        final error = validation.validate(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// 任一规则通过即可 / Pass if any rule passes
  /// 
  /// 只要有一个校验通过就返回 null，全部失败才返回错误
  /// Return null if any validation passes, return error only if all fail
  /// 
  /// Example:
  /// ```dart
  /// validator: InputValidation.any([
  ///   InputValidation.email(),
  ///   InputValidation.phone(),
  /// ], errorMsg: "请输入邮箱或手机号")
  /// ```
  static String? Function(String?) any(List<InputValidation> validations, {String? errorMsg}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return validations.first.emptyTip;
      }
      
      for (var validation in validations) {
        final error = validation.validate(value);
        if (error == null) {
          return null;
        }
      }
      return errorMsg ?? "输入格式不正确";
    };
  }

  // ==================== 实例方法 / Instance Methods ====================

  String? validate(String? value) {
    // 条件校验：如果不满足条件，跳过校验
    if (condition != null && !condition!()) {
      return null;
    }

    // 自定义校验优先
    if (customValidator != null) {
      // 先检查必填
      if ((mustFill != null && mustFill != false) &&
          (value == null || value.isEmpty)) {
        return emptyTip;
      }
      return customValidator!(value);
    }

    // 必填校验
    if ((mustFill != null && mustFill != false) &&
        (value == null || value.isEmpty)) {
      return emptyTip;
    }

    // 如果不是必填且为空，则通过校验
    if ((mustFill == null || mustFill == false) && 
        (value == null || value.isEmpty)) {
      return null;
    }

    // 正则表达式校验
    if (regExp != null) {
      if (StrUtils.isEmpty(value) && mustFill!) {
        return emptyTip;
      }
      if(StrUtils.isNotEmpty(value) && !mustFill! && !regExp!.hasMatch(value!)) {
        return errorMsg;
      }

      if (mustFill! && !regExp!.hasMatch(value!)) {
        return errorMsg;
      }
      return null;
    }

    // 长度校验
    if (format == null && errorMsg != null) {
      if (minLength != null && value!.length < minLength!) {
        return errorMsg;
      }
      if (maxLength != null && value!.length > maxLength!) {
        return errorMsg;
      }
    }
    
    // 格式化错误消息
    if (format != null) {
      if (minLength != null && value!.length < minLength!) {
        return _strFormat();
      }
      if (maxLength != null && value!.length > maxLength!) {
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
