import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/15
/// create_time: 17:51
/// describe: 用于弹出窗的 透明载体
///
class Popup extends StatelessWidget {
  final Widget child;
  final Function? onClick; //点击child事件
  final EdgeInsetsGeometry padding;

  const Popup({
    required this.child,
    this.onClick,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Padding(
              child: child,
              padding: padding,
            ),
          ],
        ),
        onTap: () {
          //点击空白处
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
