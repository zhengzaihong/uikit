import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/4/12
/// create_time: 15:58
/// describe: 可在父组件中可拖动的组件
///
class DragBox extends StatefulWidget {

  ///需要拖到的组件
  final Widget child;
  final Offset startOffset;
  const DragBox({
    required this.child,
    this.startOffset = Offset.zero,
    Key? key,
  }):super(key: key);
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
