import 'dart:async';

import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/9/26
/// create_time: 15:20
/// describe: 跑马灯效果,支持垂直和横向(横向是将多条数据 展平为一条从右向左滚动)
///

enum MarqueeDirection { vertical, horizontal }
typedef BuildItem = Widget Function(BuildContext context, dynamic data);

class MarqueeView extends StatefulWidget {

  final Duration duration;
  final double stepOffset;
  final MarqueeDirection? direction;
  final List marqueeItems;
  final BuildItem buildItem;
  final double itemExtent;
  final int interval;
  final int animateSpeed;
  final Function(int)? onIndexChange;

  const MarqueeView({
    Key? key,
    this.stepOffset=1,
    this.duration = const Duration(microseconds: 500),
    this.direction = MarqueeDirection.vertical,
    required this.marqueeItems,
    required this.buildItem,
    ///以下垂直滚动属性
    this.itemExtent = 40,
    this.interval = 2,
    this.animateSpeed = 1,
    this.onIndexChange,
  }) : super(key: key);

  @override
  _MarqueeViewState createState() => _MarqueeViewState();
}

class _MarqueeViewState extends State<MarqueeView>
    with TickerProviderStateMixin {

  final GlobalKey _myKey = GlobalKey();
  late ScrollController _controller;
  double _offset = 0.0;
  int index = 0;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: _offset);
     if(widget.direction==MarqueeDirection.horizontal){
       _timer = Timer.periodic(widget.duration, (timer) {
         double newOffset = _controller.offset + widget.stepOffset;
         if (newOffset != _offset) {
           _offset = newOffset;
           _controller.animateTo(_offset,
               duration: widget.duration, curve: Curves.linear);
         }
         if(newOffset>=_controller.position.maxScrollExtent){
           if(_offset==0){
             return;
           }
           Future.delayed(
               const Duration(seconds: 2), () {
             _controller.jumpTo(0);
             _offset=0;
           });
         }
       });
     }else{

       WidgetsBinding widgetsBinding = WidgetsBinding.instance;
       widgetsBinding.addPostFrameCallback((callback) {
         _timer = Timer.periodic(Duration(seconds: widget.interval), (timer) {
           index += _myKey.currentContext?.size?.height?.toInt()??0;
           if ((index - (_myKey.currentContext?.size?.height.toInt()??0)).toDouble() >
               _controller.position.maxScrollExtent) {
             _controller.jumpTo(_controller.position.minScrollExtent);
             index = 0;
             _currentIndex = 0;
             widget.onIndexChange?.call(_currentIndex);
           }else{
             _controller.animateTo(
                 (index).toDouble(),
                 duration: Duration(milliseconds: widget.animateSpeed),
                 curve: Curves.easeOutSine);
             _currentIndex++;
             if(_currentIndex>=widget.marqueeItems.length){
               _currentIndex = widget.marqueeItems.length-1;
             }
             widget.onIndexChange?.call(_currentIndex);
           }
         });
       });
     }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.direction == MarqueeDirection.horizontal){
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:widget.marqueeItems.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.buildItem.call(context,widget.marqueeItems[index])
              ],
            );
          });
    }
    return ListView.builder(
        key: _myKey,
        physics: const NeverScrollableScrollPhysics(),
        itemExtent: widget.itemExtent,
        itemCount:widget.marqueeItems.length,
        scrollDirection: Axis.vertical,
        controller: _controller,
        itemBuilder: (context, index) {
          return Container(alignment: Alignment.centerLeft,
              child: widget.buildItem.call(context,widget.marqueeItems[index]));
        });
  }
}

