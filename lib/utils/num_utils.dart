import 'dart:convert';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/4/12
/// create_time: 9:59
/// describe: 数字转化工具
///
class NumUtils {
  /// fractionDigits == [0-20]
  static num? getNumByValueStr(String valueStr, {int? fractionDigits}) {
    double? value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : getNumByValueDouble(value, fractionDigits);
  }

  /// fractionDigits == [0-20]
  static num? getNumByValueDouble(double? value, int fractionDigits) {
    if (value == null) return null;
    String valueStr = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0
        ? int.tryParse(valueStr)
        : double.tryParse(valueStr);
  }

  static num nilToDef(num? value, num def) {
    return value ?? def;
  }
}

extension NumExt on Object? {

  T toValue<T extends num>({T? def}) {
    try {
      final value = num.parse(toString());
      if (T is int) {
        return value.toInt() as T;
      }
      if (T is double) {
        return value.toDouble() as T;
      }
      return value as T;
    } catch (e) {
      // 类型转化异常
      return def as T;
    }
  }

  //还原base64 数字
  num base64toNum() {
    final bytes = base64.decode(toString());
    return String.fromCharCodes(bytes).toValue<num>();
  }
}
