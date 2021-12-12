import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-12-11
/// create_time: 17:59
/// describe: 路由
///
class PopRoute extends PopupRoute {

  final Widget _child;

  PopRoute({
    required Widget child,
  }):
        _child = child;


  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
  
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _child;
  }

  @override
  Widget buildTransitions (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

}
