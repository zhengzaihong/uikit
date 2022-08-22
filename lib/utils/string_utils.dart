

///
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
    return RegExp(r"^[0-9_]+$").hasMatch(str);
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

  /// 检查字符串是否空
  static bool isEmpty(String? string) {
    if (null == string || string.isEmpty) {
      return true;
    }
    return false;
  }
}



extension StringExt on Object? {


  String toStr(Object? value){
    return null==value?"":value.toString();
  }

  bool isEmpty(){
    return (null==this || toString().isEmpty)?true:false;
  }
}
