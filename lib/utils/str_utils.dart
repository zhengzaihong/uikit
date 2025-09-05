/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/4
/// create_time: 17:34
/// describe: 文本处理工具
/// text processing tools
// 格式验证：增加了邮箱、手机号、URL、身份证等常见格式验证
// 字符串脱敏：隐藏手机号、邮箱等敏感信息
// 命名转换：驼峰命名与下划线命名互转
// 大小写处理：首字母大写、每个单词首字母大写
// 空格处理：去除所有空格、去除多余空格
// 字符串截断：添加省略号
// 长度计算：支持中文算两个字符的长度计算
// 内容提取：提取数字、字母、汉字等
// 分隔符插入：定期插入分隔符
// HTML标签移除：清理HTML标签
// 扩展方法增强：为扩展类添加了更多便捷方法


class StrUtils {
  StrUtils._();

  /// 【全为字母】返回true  否则false
  /// [All letters] Returns true otherwise false
  static bool isAz(String str) {
    return RegExp(r"^[A-Za-z_]+$").hasMatch(str);
  }

  ///【全为数字】返回true
  ///[All numbers] Returns true
  static bool isNum(String str) {
    return RegExp(r'^-?[0-9]+(\.[0-9]+)?$').hasMatch(str);
  }

  ///【除字母和数字外无其他字符(只有字母数字的字符串)】返回true 否则false
  ///[No characters except letters and numbers (only alphanumeric strings)] Returns true Otherwise false
  static bool isAzNum(String str) {
    return RegExp(r"^[a-zA-Z0-9]+$").hasMatch(str);
  }

  ///【含有英文】true
  ///[Contains letters] true
  static bool hasAz(String str) {
    return RegExp(r".*[a-zA-Z].*").hasMatch(str);
  }

  ///【含有数字】true
  ///[Contains numbers] true
  static bool hasNum(String str) {
    return RegExp(r".*[0-9].*").hasMatch(str);
  }

  ///判断是否为纯中文，不是返回false
  ///Determine whether it is pure Chinese, not return false
  static bool isChinese(String str) {
    return RegExp(r"^[\u4e00-\u9fa5]+$").hasMatch(str);
  }

  /// 判断是否为邮箱格式
  /// Check if it is email format
  static bool isEmail(String str) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(str);
  }

  /// 判断是否为手机号格式
  /// Check if it is phone number format
  static bool isPhone(String str) {
    return RegExp(r"^1[3-9]\d{9}$").hasMatch(str);
  }

  /// 判断是否为URL格式
  /// Check if it is URL format
  static bool isUrl(String str) {
    return RegExp(r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$").hasMatch(str);
  }

  /// 判断是否为身份证格式
  /// Check if it is ID card format
  static bool isIdCard(String str) {
    return RegExp(r"^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$").hasMatch(str);
  }

  /// 如果为空返回默认值def, defSuffix为true时拼接上后缀 suffix
  /// if it is empty, return the default value def, and if defSuffix is true, append the suffix suffix
  static String nullToDef(String? value, String def, {String? suffix, bool defSuffix = false}) {
    final buffer = StringBuffer();
    if (isEmpty(value)) {
      buffer.write(def);
      if (defSuffix) {
        buffer.write(suffix ?? '');
      }
      return buffer.toString();
    }
    buffer.write(value);
    buffer.write(suffix ?? '');
    return buffer.toString();
  }

  /// 检查字符串是否为空
  /// Check whether the string is empty
  static bool isEmpty(String? string) => string == null || string.isEmpty;

  static bool isNotEmpty(String? string) => !isEmpty(string);

  /// 检查两个字符串是否相等
  /// Check whether two strings are equal
  static bool equals(String? a, String? b) {
    if (a == b) return true;
    if (a != null && b != null && a.length == b.length) {
      return a == b;
    }
    return false;
  }

  /// 如果第一项为空则返回第二项, def可选返回默认值
  /// Returns the second item if the first item is empty, def optionally returns the default value
  static String firstNullToSecond(String? first, String? second, {String def = ''}) => isEmpty(first) ? (second ?? def) : first!;

  /// 字符串反转
  /// Reverse string
  static String reverse(String str) {
    return String.fromCharCodes(str.runes.toList().reversed);
  }

  /// 隐藏部分手机号
  /// Hide part of phone number
  static String hidePhone(String phone, {int start = 3, int end = 7, String replace = '*'}) {
    if (phone.length < 11) return phone;
    return phone.replaceRange(start, end, replace * (end - start));
  }

  /// 隐藏部分邮箱
  /// Hide part of email
  static String hideEmail(String email, {int start = 1, String replace = '*'}) {
    if (!email.contains('@')) return email;
    final parts = email.split('@');
    if (parts.first.length <= start) return email;
    return '${parts.first.substring(0, start)}${replace * (parts.first.length - start)}@${parts.last}';
  }

  /// 字符串脱敏处理
  /// Desensitize string
  static String desensitize(String str, {int start = 0, int? end, String replace = '*'}) {
    end ??= str.length;
    if (start < 0) start = 0;
    if (end > str.length) end = str.length;
    if (start >= end) return str;
    return str.replaceRange(start, end, replace * (end - start));
  }

  /// 驼峰命名转下划线命名
  /// Convert camel case to snake case
  static String camelToSnake(String str) {
    return str.replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}');
  }

  /// 下划线命名转驼峰命名
  /// Convert snake case to camel case
  static String snakeToCamel(String str) {
    return str.replaceAllMapped(RegExp(r'_([a-z])'), (match) => match.group(1)!.toUpperCase());
  }

  /// 首字母大写
  /// Capitalize first letter
  static String capitalize(String str) {
    if (isEmpty(str)) return str;
    return '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}';
  }

  /// 每个单词首字母大写
  /// Capitalize each word
  static String capitalizeAll(String str) {
    return str.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// 去除所有空格
  /// Remove all spaces
  static String removeAllSpace(String str) {
    return str.replaceAll(RegExp(r'\s+'), '');
  }

  /// 去除多余空格（保留一个）
  /// Remove extra spaces (keep one)
  static String removeExtraSpace(String str) {
    return str.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// 截断字符串，添加省略号
  /// Truncate string with ellipsis
  static String truncate(String str, int maxLength, {String ellipsis = '...'}) {
    if (str.length <= maxLength) return str;
    return '${str.substring(0, maxLength)}$ellipsis';
  }

  /// 计算字符串长度（中文算两个字符）
  /// Calculate string length (Chinese characters count as two)
  static int lengthWithChinese(String str) {
    int length = 0;
    for (final rune in str.runes) {
      length += rune > 255 ? 2 : 1;
    }
    return length;
  }

  /// 提取字符串中的数字
  /// Extract numbers from string
  static String extractNumbers(String str) {
    return str.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// 提取字符串中的字母
  /// Extract letters from string
  static String extractLetters(String str) {
    return str.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }

  /// 检查字符串是否以指定前缀开头（忽略大小写）
  /// Check if string starts with prefix (case insensitive)
  static bool startsWithIgnoreCase(String str, String prefix) {
    return str.toLowerCase().startsWith(prefix.toLowerCase());
  }

  /// 检查字符串是否以指定后缀结尾（忽略大小写）
  /// Check if string ends with suffix (case insensitive)
  static bool endsWithIgnoreCase(String str, String suffix) {
    return str.toLowerCase().endsWith(suffix.toLowerCase());
  }

  /// 计算字符串中某个字符的出现次数
  /// Count occurrences of a character in string
  static int countOccurrences(String str, String character) {
    return character.isEmpty ? 0 : str.split(character).length - 1;
  }

  /// 插入分隔符
  /// Insert separator
  static String insertSeparator(String str, {int interval = 4, String separator = ' '}) {
    final result = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && i % interval == 0) {
        result.write(separator);
      }
      result.write(str[i]);
    }
    return result.toString();
  }

  /// 验证字符串是否匹配正则表达式
  /// Validate string against regex pattern
  static bool matchesPattern(String str, String pattern) {
    return RegExp(pattern).hasMatch(str);
  }

  /// 移除字符串中的HTML标签
  /// Remove HTML tags from string
  static String removeHtmlTags(String str) {
    return str.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// 获取字符串中的第一个汉字
  /// Get first Chinese character from string
  static String? firstChineseCharacter(String str) {
    final match = RegExp(r'[\u4e00-\u9fa5]').firstMatch(str);
    return match?.group(0);
  }

  /// 获取字符串中的第一个字母
  /// Get first letter from string
  static String? firstLetter(String str) {
    final match = RegExp(r'[a-zA-Z]').firstMatch(str);
    return match?.group(0);
  }

  /// 获取字符串中的第一个数字
  /// Get first number from string
  static String? firstNumber(String str) {
    final match = RegExp(r'[0-9]').firstMatch(str);
    return match?.group(0);
  }
}

extension StringExtension on Object? {

  String str() => this == null ? "" : toString();

  bool isEmptyObj() => this == null;

  List<String> toList() {
    final str = this.str();
    return List.generate(str.length, (index) => str.substring(index, index + 1));
  }

  // 数字转化,def 默认值 -1
  // Digital conversion,def default-1
  num toNum({num def = -1}) {
    return num.tryParse(str()) ?? def;
  }

  // caseSensitive 默认不区分大小写，def 默认值 false
  // caseSensitive by default is case-insensitive, def default value is false
  bool toBool({bool caseSensitive = false, bool def = false}) {
    return bool.tryParse(str(), caseSensitive: caseSensitive) ?? def;
  }

  // radix:默认十进制解析 def 默认值 -1
  // radix: Default decimal parsing def Default value-1
  int toInt({int radix = 10, int def = -1}) {
    return int.tryParse(str(), radix: radix) ?? def;
  }

  //def 默认值 -1
  //def Default-1
  double toDouble({double def = -1}) {
    return double.tryParse(str()) ?? def;
  }

  // 扩展方法：字符串反转
  // Extension method: reverse string
  String get reversed => StrUtils.reverse(str());

  // 扩展方法：检查是否为空字符串
  // Extension method: check if empty string
  bool get isStrEmpty => StrUtils.isEmpty(str());

  // 扩展方法：检查是否为非空字符串
  // Extension method: check if not empty string
  bool get isStrNotEmpty => StrUtils.isNotEmpty(str());

  // 扩展方法：首字母大写
  // Extension method: capitalize first letter
  String get capitalized => StrUtils.capitalize(str());

  // 扩展方法：隐藏手机号
  // Extension method: hide phone number
  String hidePhone({int start = 3, int end = 7, String replace = '*'}) {
    return StrUtils.hidePhone(str(), start: start, end: end, replace: replace);
  }

  // 扩展方法：截断字符串
  // Extension method: truncate string
  String truncate(int maxLength, {String ellipsis = '...'}) {
    return StrUtils.truncate(str(), maxLength, ellipsis: ellipsis);
  }

  // 扩展方法：提取数字
  // Extension method: extract numbers
  String get numbers => StrUtils.extractNumbers(str());

  // 扩展方法：提取字母
  // Extension method: extract letters
  String get letters => StrUtils.extractLetters(str());
}