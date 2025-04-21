import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/2/5
/// create_time: 16:53
/// describe: 鼠标右键弹出窗
/// 防止移动端误入使用鼠标右键弹出窗，这里外部推荐方 1方式处理
///
///  web端处理的方式
/// 规避浏览器鼠标右键的方式：
/// 方式1.在 web/index.html 中加入 script代码。屏蔽右键
//    <script>
//     document.body.addEventListener('contextmenu', (event) => {
//       event.preventDefault();
//     });
//    </script>

/// 方式2.import 'dart:html' as html 导入后使用 window对象 屏蔽
///   html.document.body!.addEventListener('contextmenu', (event) => event.preventDefault());
///
class MousePopupButton<T> extends StatefulWidget {
  final Widget? child;
  final PopupMenuItemBuilder<T>? itemBuilder;
  final PopupMenuItemSelected<T>? onSelected;
  final PopupMenuCanceled? onCanceled;

  final T? initialValue;
  final double? elevation;
  final String? semanticLabel;
  final ShapeBorder? shape;
  final Color? color;
  final bool useRootNavigator;
  final BoxConstraints? constraints;

  const MousePopupButton(
      {this.child,
      this.itemBuilder,
      this.onCanceled,
      this.onSelected,
      this.initialValue,
      this.elevation,
      this.semanticLabel,
      this.shape,
      this.color,
      this.useRootNavigator = false,
      this.constraints,
      Key? key})
      : super(key: key);

  @override
  State<MousePopupButton<T>> createState() => _MousePopupButtonState<T>();
}

class _MousePopupButtonState<T> extends State<MousePopupButton<T>> {
  late Offset position;
  RenderBox? overlay;

  @override
  Widget build(BuildContext context) {
    var result = GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        position = details.globalPosition;
      },
      onLongPress: () {
        overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
        showPopupMenu();
      },
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          if (event.buttons == 2) {
            position = event.position;
            overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox?;
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
      initialValue: widget.initialValue,
      elevation: widget.elevation,
      semanticLabel: widget.semanticLabel,
      shape: widget.shape,
      color: widget.color,
      useRootNavigator: widget.useRootNavigator,
      constraints: widget.constraints,
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
