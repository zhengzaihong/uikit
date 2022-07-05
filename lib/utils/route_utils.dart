import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/23
/// create_time: 10:37
/// describe: 路由工具
///
class RouteUtils {

  /// 跳转页面
  static push(BuildContext context, Widget page,{bool noAnimation=false}) async {
    final result = await Navigator.push(context, noAnimation?NoAnimRouter(page):
    MaterialPageRoute(builder: (context) {
      return page;
    }));
    return result;
  }

  static pushReplaceTagPage(BuildContext context, Widget page,{bool noAnimation=false}) {
    Navigator.of(context).pushReplacement(noAnimation?NoAnimRouter(page):MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  ///跳转到起始页并关闭所有页面
  static pushClearTop(BuildContext context, Widget page,{bool noAnimation=false}) {
    Navigator.pushAndRemoveUntil(
      context,
      noAnimation?NoAnimRouter(page): MaterialPageRoute(builder: (context) {
        return page;
      }),
     (Route<dynamic> route) => false,
    );
  }

  /// 跳转页面
  static pushNamed(
      BuildContext context,
      String routeName, {
        Object? arguments,
      }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}

//无动画
class NoAnimRouter<T> extends PageRouteBuilder<T> {
  final Widget page;
  NoAnimRouter(this.page)
      : super(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 0),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) => child);
}
