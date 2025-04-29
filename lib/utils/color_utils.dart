import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/5/12
/// create_time: 9:35
/// describe: 颜色工具
///

///#FFE6E6E6(argb) 格式转 dart 颜色
Color parseColorStr(String? colorStr) {
  if (null == colorStr || colorStr.isEmpty) {
    return Colors.transparent;
  }
  return Color(int.parse(colorStr.replaceFirst('#', ''), radix: 16));
}

///Colors.red/0xFFF44336 转 #FFF44336
@Deprecated("Removed from flutter sdk 3.29.0 ,use toHexARGB instead")
String colorToStr(Color color) {
  return '#${color.value.toRadixString(16).substring(2)}';
}


extension ColorExtension on Color {
  ///设置透明度 0.0-1.0 之间
  @Deprecated("use setAlpha instead")
  Color setOpacity(double opacity) {
    return withOpacity(opacity);
  }

  Color setAlpha(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((opacity * 255).round());
  }

  String toHexARGB({bool includeAlpha = true}) {
    if (includeAlpha) {
      // 返回 #AARRGGBB 格式
      return '#${(a * 255).toInt().toRadixString(16).padLeft(2, '0')}'
              '${(r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
              '${(g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
              '${(b * 255).toInt().toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();
    } else {
      // 返回 #RRGGBB 格式
      return '#${(r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
              '${(g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
              '${(b * 255).toInt().toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();
    }
  }
}
