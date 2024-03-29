import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/utils/keyboard.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/23
/// create_time: 10:37
/// describe: 路由工具
///
class RouteUtils {
  RouteUtils._();

  /// 跳转页面
  static Future<dynamic> push(BuildContext context, Widget page,
      {String? name,
      Object? arguments,
      bool noAnimation = true,
      bool hide = true}) {
    hideKeyboard(context, hide: hide);
    return Navigator.push(
        context,
        noAnimation
            ? NoAnimRouter(page, name: name, arguments: arguments)
            : MaterialPageRoute(
                settings: RouteSettings(name: name, arguments: arguments),
                builder: (_) => page));
  }

  static void pop<T extends Object?>(BuildContext context,
      [T? result, bool hide = true]) {
    hideKeyboard(context, hide: hide);
    Navigator.of(context).pop<T>(result);
  }

  static Future<dynamic> pushReplaceTagPage(BuildContext context, Widget page,
      {String? name,
      Object? arguments,
      bool noAnimation = true,
      bool hide = true}) {
    hideKeyboard(context, hide: hide);
    return Navigator.of(context).pushReplacement(noAnimation
        ? NoAnimRouter(page, name: name, arguments: arguments)
        : MaterialPageRoute(
            settings: RouteSettings(name: name, arguments: arguments),
            builder: (_) => page));
  }

  ///跳转到起始页并关闭所有页面
  static Future<dynamic> pushClearTop(BuildContext context, Widget page,
      {String? name,
      Object? arguments,
      bool noAnimation = true,
      bool hide = true}) {
    hideKeyboard(context, hide: hide);
    return Navigator.pushAndRemoveUntil(
      context,
      noAnimation
          ? NoAnimRouter(page, name: name, arguments: arguments)
          : MaterialPageRoute(
              settings: RouteSettings(name: name, arguments: arguments),
              builder: (_) => page),
      (Route<dynamic> route) => false,
    );
  }

  /// 跳转页面
  static Future<dynamic> pushNamed(BuildContext context, String routeName,
      {Object? arguments, bool hide = true}) {
    hideKeyboard(context, hide: hide);
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void hideKeyboard(BuildContext context, {bool hide = true}) {
    if (hide) {
      KeyBoard.hideKeyboard(context);
    }
  }
}

//无动画
class NoAnimRouter<T> extends PageRouteBuilder<T> {
  final Widget page;

  NoAnimRouter(this.page, {String? name, Object? arguments})
      : super(
            opaque: false,
            settings: RouteSettings(name: name, arguments: arguments),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}
