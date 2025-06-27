/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/4
/// create_time: 17:34
/// describe: 文本处理工具
/// text processing tools
///
class StrUtils {

  StrUtils._();

  /// 【全为字母】返回true  否则false
  /// [All letters] Returns true otherwise false
  static bool isAz(String str) {
    return RegExp(r"^[ZA-ZZa-z_]+$").hasMatch(str);
  }

  ///【全为数字】返回true
  ///[All numbers] Returns true
  static bool isNum(String str) {
    return RegExp(r'^-?[0-9]+(\.[0-9]+)?$').hasMatch(str);
  }

  ///【除字母和数字外无其他字符(只有字母数字的字符串)】返回true 否则false
  ///[No characters except letters and numbers (only alphanumeric strings)] Returns true Otherwise false
  static bool isAzNum(String str) {
    return RegExp("[a-zA-Z0-9]+").hasMatch(str);
  }

  ///【含有英文】true
  ///[Contains letters] true
  static bool hasAz(String str) {
    return RegExp(".*[a-zA-z].*").hasMatch(str);
  }

  ///【含有数字】true
  ///[Contains numbers] true
  static bool hasNum(String str) {
    return RegExp(".*[0-9].*").hasMatch(str);
  }

  ///判断是否为纯中文，不是返回false
  ///Determine whether it is pure Chinese, not return false
  static bool isChinese(String str) {
    return RegExp("[\\u4e00-\\u9fa5]+").hasMatch(str);
  }

  /// 如果为空返回默认值def, defSuffix为true时拼接上后缀 suffix
  /// if it is empty, return the default value def, and if defSuffix is true, append the suffix suffix
  String nullToDef(String? value,String def,{String? suffix,bool defSuffix = false}) {
    final buffer = StringBuffer();
    if(StrUtils.isEmpty(value)){
      buffer.write(def);
      if(defSuffix){
        buffer.write(suffix??'');
      }
      return buffer.toString();
    }
    buffer.write(value);
    buffer.write(suffix??'');
    return buffer.toString();
  }

  /// 检查字符串是否为空
  /// Check whether the string is empty
  static bool isEmpty(String? string) => null == string || string.isEmpty;

  static bool isNotEmpty(String? string) => !isEmpty(string);

  /// 检查两个字符串是否相等
  /// Check whether two strings are equal
  static bool equals(String? a, String? b) {
    if (a == b) return true;
    if (a != null && b != null && (a.length == b.length)) {
      for (int i = 0; i < a.length; i++) {
        if (a.codeUnitAt(i) != b.codeUnitAt(i)) return false;
      }
      return true;
    }
    return false;
  }

  /// 如果第一项为空则返回第二项, def可选返回默认值
  /// Returns the second item if the first item is empty, def optionally returns the default value
  static String firstNullToSecond(String? first, String? second,{String def = ''}) => isEmpty(first)? second??def: first!;

}

extension StringExtension on Object? {

  String str()=> null == this ? "" : toString();

  bool isEmptyObj() => this == null;

  List<String> toList() {
    var str = this.str();
    return List.generate(str.length, (index) => str.substring(index, index + 1));
  }


  // 数字转化,def 默认值 -1
  // Digital conversion,def default-1
  num toNum({num def = -1}){
    return num.tryParse(str())??def;
  }

  // caseSensitive 默认不区分大小写，def 默认值 false
  // caseSensitive by default is case-insensitive, def default value is false
  bool toBool({bool caseSensitive = false,bool def = false}){
    return bool.tryParse(str(),caseSensitive: caseSensitive)??def;
  }

  // radix:默认十进制解析 def 默认值 -1
  // radix: Default decimal parsing def Default value-1
  int toInt({int radix = 10,int def = -1}){
    return int.tryParse(str(),radix: 10)??def;
  }

  //def 默认值 -1
  //def Default-1
  double toDouble({double def = -1}){
    return double.tryParse(str())??def;
  }

}
