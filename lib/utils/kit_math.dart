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

  ///将字符串解析成集合
  /// 使用 parseStrPlus 代替
  @deprecated
  static List<String> parseStr(String? string) {
    if (StringUtils.isEmpty(string)) {
      return [];
    }
    List<String> contents = [];

    ///记录移动的指针
    int lastPosition = 0;
    var length = string!.length;
    int point = 0;
    for (point; point < length; point++) {
      if (lastPosition > point) {
        point = lastPosition;
      } else {
        lastPosition = point;
      }
      var char = string.substring(point, point + 1);

      if (StringUtils.isChinese(char)) {
        lastPosition++;
        contents.add(char);
      } else if (StringUtils.isAz(char)) {
        ///如果是字母 则假的后面都为字母，把当前单词提取出来。
        var tempString = string.substring(point);
        StringBuffer buffer = StringBuffer(char);
        for (int j = 1; j < tempString.length; j++) {
          var tempChar = tempString.substring(j, j + 1);
          lastPosition++;
          if (StringUtils.isAz(tempChar)) {
            buffer.write(tempChar);
          } else {
            point = lastPosition - 1;
            break;
          }
        }
        contents.add(buffer.toString());
      } else if (StringUtils.isNum(char)) {
        ///思路同英文单词一样
        var tempString = string.substring(point);
        StringBuffer buffer = StringBuffer(char.toString());
        for (int j = 1; j < tempString.length; j++) {
          var tempChar = tempString.substring(j, j + 1);
          lastPosition++;
          if (StringUtils.isNum(tempChar)) {
            buffer.write(tempChar.toString());
          } else {
            point = lastPosition - 1;
            break;
          }
        }
        contents.add(buffer.toString());
      } else {
        contents.add(char);
      }
    }

    return contents;
  }

  static List<String> parseStrPlus(String? string,{RegExp? reg}) {
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
