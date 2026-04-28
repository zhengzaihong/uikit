import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2024/4/12
/// time: 15:58
/// describe: 可拖动组件 / Draggable Box Component
///
/// 在父组件范围内可自由拖动的组件
/// Component that can be freely dragged within parent bounds
///
/// ## 功能特性 / Features
/// - 🖱️ 支持鼠标/触摸拖动 / Mouse/touch drag support
/// - 📦 自动限制在父组件范围内 / Auto-constrained within parent
/// - 📍 支持设置初始位置 / Custom start position
/// - 🎯 拖动过程平滑流畅 / Smooth dragging experience
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单拖动框
/// DragBox(
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///     child: Center(child: Text('拖我')),
///   ),
/// )
///
/// // 设置初始位置
/// DragBox(
///   startOffset: Offset(50, 50),
///   child: FloatingActionButton(
///     onPressed: () {},
///     child: Icon(Icons.add),
///   ),
/// )
///
/// // 悬浮按钮示例
/// Stack(
///   children: [
///     YourMainContent(),
///     DragBox(
///       startOffset: Offset(300, 500),
///       child: Container(
///         width: 60,
///         height: 60,
///         decoration: BoxDecoration(
///           color: Colors.blue,
///           shape: BoxShape.circle,
///         ),
///         child: Icon(Icons.chat, color: Colors.white),
///       ),
///     ),
///   ],
/// )
///
/// // 可拖动的工具栏
/// DragBox(
///   child: Card(
///     child: Padding(
///       padding: EdgeInsets.all(8),
///       child: Row(
///         mainAxisSize: MainAxisSize.min,
///         children: [
///           IconButton(icon: Icon(Icons.edit), onPressed: () {}),
///           IconButton(icon: Icon(Icons.delete), onPressed: () {}),
///         ],
///       ),
///     ),
///   ),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - 拖动范围自动限制在父组件内 / Auto-constrained within parent
/// - 需要在有明确大小的父组件中使用 / Use within parent with defined size
/// - 建议在 Stack 中使用以实现悬浮效果 / Recommend using in Stack for floating effect
///
class DragBox extends StatefulWidget {

  /// 需要拖动的子组件 / Child widget to drag
  /// 
  /// 必填参数 / Required
  final Widget child;

  /// 初始位置偏移 / Initial position offset
  /// 
  /// 相对于父组件左上角的偏移量
  /// Offset from parent's top-left corner
  /// 
  /// 默认值: Offset.zero / Default: Offset.zero
  final Offset startOffset;
  const DragBox({
    required this.child,
    this.startOffset = Offset.zero,
    Key? key,
  }) : super(key: key);
  @override
  State<DragBox> createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  final GlobalKey _myKey = GlobalKey();
  //当前位移(有活动区域限制时，鼠标超过边界后当前位移不等于总位移，此时总位移可以确保回到边final 界内鼠标与控件的相对位置不变)
  late ValueNotifier<Offset> _offset;
  //总位移
  late Offset _totalOffset;

  @override
  void initState() {
    super.initState();
    _offset = ValueNotifier<Offset>(widget.startOffset);
    _totalOffset = widget.startOffset;
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: _offset,
      //采用transform变换实现拖动
      builder: (context, offset, widget){
        return Transform.translate(
          key: _myKey,
          offset: offset,
          child: GestureDetector(
            child: this.widget.child,
            onPanUpdate: (detail) {
              var off = _totalOffset = _totalOffset + detail.delta;
              //拖动区域为父控件，去掉则不受限制，但拖出父控件会被遮挡无法点击。
              //获取父控件大小
              RenderBox? parentRenderBox = _myKey.currentContext
                  ?.findAncestorRenderObjectOfType<RenderObject>() as RenderBox?;
              final screenSize = parentRenderBox?.size;
              //获取控件大小
              final mySize = _myKey.currentContext?.size;
              final renderBox =
              _myKey.currentContext?.findRenderObject() as RenderBox?;
              //获取控件当前位置
              var originOffset = renderBox?.localToGlobal(Offset.zero);
              if (originOffset != null) {
                originOffset = parentRenderBox?.globalToLocal(originOffset);
              }
              if (screenSize == null || mySize == null || originOffset == null) {
                return;
              }
              //计算不超出父控件区域
              if (off.dx < -originOffset.dx) {
                off = Offset(-originOffset.dx, off.dy);
              } else if (off.dx >
                  screenSize.width - mySize.width - originOffset.dx) {
                off = Offset(
                  screenSize.width - mySize.width - originOffset.dx,
                  off.dy,
                );
              }
              if (off.dy < -originOffset.dy) {
                off = Offset(off.dx, -originOffset.dy);
              } else if (off.dy >
                  screenSize.height - mySize.height - originOffset.dy) {
                off = Offset(
                  off.dx,
                  screenSize.height - mySize.height - originOffset.dy,
                );
              }
              //现在活动区域为父控件 --end
              _offset.value = off;
            },
          ),
        );
      },
    );
  }
}
