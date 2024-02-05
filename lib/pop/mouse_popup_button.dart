
import 'dart:io' if (dart.library.html) 'dart:html'as html;

import 'package:flutter/material.dart';
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/2/5
/// create_time: 16:53
/// describe: 鼠标右键弹出窗
///
/// 防止此组件在移动端误用
///
///
class MousePopupButton<T> extends StatefulWidget {
  final Widget? child;
  final PopupMenuItemBuilder<T>? itemBuilder;
  final PopupMenuItemSelected<T>? onSelected;
  final PopupMenuCanceled? onCanceled;

  const MousePopupButton({
    this.child,
    this.itemBuilder,
    this.onCanceled,
    this.onSelected,
    Key? key}) : super(key: key);

  @override
  State<MousePopupButton<T>> createState() => _MousePopupButtonState<T>();
}

class _MousePopupButtonState<T> extends State<MousePopupButton<T>> {

  late Offset position;
  RenderBox? overlay;

  @override
  void initState() {
    super.initState();
    html.document.body!
        .addEventListener('contextmenu', (event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    var result = GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        position = details.globalPosition;
      },
      onLongPress: () {
        overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox?;
        showPopupMenu();
      },
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          if (event.buttons == 2) {
            position = event.position;
            overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox?;
            showPopupMenu();
          }
        },
        child: widget.child,
      ),
    );
    return result;
  }

 void showPopupMenu() {
    List<PopupMenuEntry<T>> items = widget.itemBuilder!(context);
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & Size.zero,
        Offset.zero & overlay!.size,
      ),
      items: items,
    ).then<void>((T? newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (widget.onCanceled != null) widget.onCanceled!();
        return null;
      }
      if (widget.onSelected != null) widget.onSelected!(newValue);
    });
  }
}
