import 'package:flutter_uikit_forzzh/utils/string_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/5
/// create_time: 14:17
/// describe: 本库的一些计算工具类
///
class KitMath {
  KitMath._();

  static List<String> parseStr(String? string,{RegExp? reg}) {
    if (StringUtils.isEmpty(string)) {
      return [];
    }
    RegExp regExp = reg?? RegExp(
            r'[\u4e00-\u9fa5]'
            r'|[a-zA-Z]+'
            r'|\d+'
            r'|[，。,.]'
        );
    // 使用allMatches
    Iterable<RegExpMatch> matches = regExp.allMatches(string!);
    List<String> result = [];
    for (var m in matches) {
      String matchStr = m.group(0)!;
      // 对连续英文单词再拆词或处理空格（因为英文短语中间有空格）
      if (RegExp(r'^[a-zA-Z]+$').hasMatch(matchStr)) {
        // 直接作为一个完整英文单词加入
        result.add(matchStr);
      } else {
        result.add(matchStr);
      }
    }
    return result;
  }
}
