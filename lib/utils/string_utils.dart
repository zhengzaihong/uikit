/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/4
/// create_time: 17:34
/// describe: 文本处理工具
///
class StringUtils {
  StringUtils._();

  /// 【全为英文】返回true  否则false
  static bool isAz(String str) {
    return RegExp(r"^[ZA-ZZa-z_]+$").hasMatch(str);
  }

  ///【全为数字】返回true
  static bool isNum(String str) {
    return RegExp(r'^-?[0-9]+(\.[0-9]+)?$').hasMatch(str);
  }

  ///【除英文和数字外无其他字符(只有英文数字的字符串)】返回true 否则false
  static bool isAzNum(String str) {
    return RegExp("[a-zA-Z0-9]+").hasMatch(str);
  }

  ///【含有英文】true
  static bool hasAz(String str) {
    return RegExp(".*[a-zA-z].*").hasMatch(str);
  }

  ///【含有数字】true
  static bool hasNum(String str) {
    return RegExp(".*[0-9].*").hasMatch(str);
  }

  ///判断是否为纯中文，不是返回false
  static bool isChinese(String str) {
    return RegExp("[\\u4e00-\\u9fa5]+").hasMatch(str);
  }

  static String nilToDef(String? value,String def,{String? suffix,bool defSuffix = false}) {
    final buffer = StringBuffer();
    if(isEmpty(value)){
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

  /// 检查字符串是否空
  static bool isEmpty(String? string) {
    return (null == string || string.isEmpty);
  }

  static bool isNotEmpty(String? string) {
    return !isEmpty(string);
  }

  static bool isEmptyObj(Object? obj) {
    return obj == null || obj.toString().isEmpty;
  }

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


  //如果第一项为空则返回第二项
  static String fts(String? a, String? b) {
    if(isEmpty(a)){
      return b??'';
    }
    return a??'';
  }

  static bool isEmptyInList(List<String?> list){
    return list.where((element) => isEmpty(element)).isNotEmpty;
  }
}

extension StringExtension on Object? {

  String _toStr(Object? value) {
    return null == value ? "" : value.toString();
  }

  String str()=>_toStr(this);

  List<String> toList() {
    String str = _toStr(this);
    return List.generate(str.length, (index) => str.substring(index, index + 1));
  }

  num toNum({num def = -1}){
    try{
      return num.parse(str());
    }catch(e){
      return def;
    }
  }
}
