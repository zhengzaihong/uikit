import 'dart:async';

import 'package:flutter/material.dart';

class MarqueeView extends StatefulWidget {
  final Duration duration;
  final List<String> messages;
  final double stepOffset;

  const MarqueeView({
    Key? key,
    this.stepOffset=1,
    this.duration = const Duration(microseconds: 500),
    this.messages = const [],
  }) : super(key: key);

  @override
  _MarqueeViewState createState() => _MarqueeViewState();
}

class _MarqueeViewState extends State<MarqueeView>
    with TickerProviderStateMixin {

  late ScrollController _controller;
  late Timer _timer;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: _offset);
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
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          String msg = widget.messages[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                msg,
                maxLines: 1,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              )
            ],
          );
        });
  }
}

