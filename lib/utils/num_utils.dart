import 'dart:convert';
import 'dart:math';
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/4/12
/// create_time: 9:59
/// describe: 数字转化工具
// num (int/double) → 基础运算、格式化、Base64
// BigInt → 超大整数运算、格式化、Base64

class NumUtils {

  /// 解析字符串为数字（支持保留小数位数）
  static num? parse(String valueStr, {int? fractionDigits}) {
    final value = double.tryParse(valueStr);
    return fractionDigits == null
        ? value
        : round(value, fractionDigits);
  }

  /// 按指定小数位数四舍五入
  static num? round(num? value, int fractionDigits) {
    if (value == null) return null;
    final str = value.toStringAsFixed(fractionDigits);
    return fractionDigits == 0 ? int.tryParse(str) : double.tryParse(str);
  }

  /// 是否为数字字符串
  static bool isNumeric(String? s) {
    if (s == null) return false;
    return double.tryParse(s) != null;
  }

  /// 安全除法（除数为0时返回默认值）
  static double safeDivide(num a, num b, {double def = 0.0}) {
    if (b == 0) return def;
    return a / b;
  }

  /// 限制数值范围
  static num clamp(num value, num min, num max) {
    return value < min ? min : (value > max ? max : value);
  }

  /// 生成随机数（支持范围和小数位数）
  static double random({double min = 0, double max = 1, int fractionDigits = 2}) {
    final r = Random().nextDouble() * (max - min) + min;
    return double.parse(r.toStringAsFixed(fractionDigits));
  }

  /// 格式化为千分位（默认保留2位小数）
  static String formatWithComma(num? value, {int fractionDigits = 2}) {
    if (value == null) return '';
    return value.toStringAsFixed(fractionDigits)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
  }

  /// 格式化为百分比
  static String formatPercent(num? value, {int fractionDigits = 2}) {
    if (value == null) return '';
    return '${(value * 100).toStringAsFixed(fractionDigits)}%';
  }

  /// 格式化为科学计数法
  static String formatScientific(num? value, {int fractionDigits = 2}) {
    if (value == null) return '';
    return value.toStringAsExponential(fractionDigits);
  }

  /// 格式化为货币（默认¥，可传入其他符号）
  static String formatCurrency(num? value, {String symbol = '¥', int fractionDigits = 2}) {
    if (value == null) return '';
    return '$symbol${formatWithComma(value, fractionDigits: fractionDigits)}';
  }

  /// 数字转Base64
  static String numToBase64(num value) {
    return base64.encode(utf8.encode(value.toString()));
  }

  /// Base64转数字
  static num? base64ToNum(String str) {
    try {
      final bytes = base64.decode(str);
      final s = utf8.decode(bytes);
      return double.tryParse(s) ?? int.tryParse(s);
    } catch (e) {
      return null;
    }
  }

  // ---------------- BigInt 支持 ---------------- //

  static BigInt? parseBigInt(String value) {
    try {
      return BigInt.parse(value);
    } catch (e) {
      return null;
    }
  }

  static String bigIntToString(BigInt? value, {bool withComma = false}) {
    if (value == null) return '';
    final str = value.toString();
    if (!withComma) return str;

    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) buffer.write(',');
    }
    return buffer.toString().split('').reversed.join('');
  }

  static String bigIntToBase64(BigInt value) {
    final bytes = utf8.encode(value.toString());
    return base64.encode(bytes);
  }

  static BigInt? base64ToBigInt(String str) {
    try {
      final bytes = base64.decode(str);
      final s = utf8.decode(bytes);
      return BigInt.tryParse(s);
    } catch (e) {
      return null;
    }
  }

  static BigInt safeAdd(BigInt? a, BigInt? b) => (a ?? BigInt.zero) + (b ?? BigInt.zero);
  static BigInt safeSubtract(BigInt? a, BigInt? b) => (a ?? BigInt.zero) - (b ?? BigInt.zero);
  static BigInt safeMultiply(BigInt? a, BigInt? b) => (a ?? BigInt.zero) * (b ?? BigInt.zero);

  static BigInt? safeDivideBigInt(BigInt? a, BigInt? b) {
    if (a == null || b == null || b == BigInt.zero) return null;
    return a ~/ b;
  }
}

// ---------------- 扩展方法 ---------------- //

extension NumParsingExt on Object? {
  T? toNum<T extends num>({T? def}) {
    try {
      if (this == null) return def;
      final value = num.parse(toString());
      if (T == int) return value.toInt() as T;
      if (T == double) return value.toDouble() as T;
      return value as T;
    } catch (e) {
      return def;
    }
  }

  BigInt? toBigInt({BigInt? def}) {
    try {
      if (this == null) return def;
      return BigInt.parse(toString());
    } catch (e) {
      return def;
    }
  }
}
