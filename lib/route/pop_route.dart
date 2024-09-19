import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-12-11
/// create_time: 17:59
/// describe: 路由
///
class PopRoute extends PopupRoute {

  final Duration _duration = const Duration(milliseconds: 200);

  Widget child;

  Color? bgColor;

  PopRoute({required this.child, this.bgColor});

  @override
  Color? get barrierColor => bgColor??const Color(0x77000000);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

  static showPop({required BuildContext context, required Widget child,double? left, double? top}) {
    Navigator.push(
      context,
      PopRoute(
        child: Popup(
          left: left,
          top: top,
          child: child,
        ),
      ),
    );
  }
}

class Popup extends StatelessWidget {
  final Widget child;
  final double? left; //距离左边位置
  final double? top; //距离上面位置

  const Popup({Key? key,
    required this.child,
    this.left,
    this.top,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              left: left,
              top: top,
              child: GestureDetector(
                  child: child,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

