import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Card左右选择回调
typedef StackCardSelected = Function(bool right, int index);

enum Direction {
  left, //向左滑动
  right, //向右滑动
  stay //无需滑动
}

//展示方向
enum CardOrientation { left, right, bottom, top }

// 0左右滑动  1上下左右滑动
enum SlideType { horizontal, vertical }

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025/1/16
/// create_time: 15:49
/// describe: 堆叠卡片组件
///
class StackCard extends StatefulWidget {
  final List<Widget> children;
  final StackCardSelected? cardSelected;
  final SlideType slideType; 
  final CardOrientation orientation;
  final Duration duration;
  final double width;
  final double height;

  const StackCard(
      {Key? key,
      this.width = 140,
      this.height = 140,  
      this.cardSelected,
      this.children = const <Widget>[],
      this.slideType = SlideType.horizontal,
      this.orientation = CardOrientation.bottom,
      this.duration = const Duration(milliseconds: 300),  
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StackCardState();
  }
}


class _StackCardState extends State<StackCard> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  double _moveX = 0, _moveY = 0;
  double _scale = 0;
  double _upX = 0, _upY = 0, _upScale = 0;
  Direction _direction = Direction.stay;
  int current = 0; //当前下标

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        lowerBound: 0,
        upperBound: 1.0);
    _controller.addListener(() {
      setState(() {
        double width = context.size!.width;
        if (_direction == Direction.right) {
          _scale = _upScale + (1 - _upScale) * _controller.value;
          _moveX = _upX + (width - _upX) * _controller.value;
        } else if (_direction == Direction.left) {
          _scale = _upScale + (1 - _upScale) * _controller.value;
          _moveX = _upX + (-width - _upX) * _controller.value;
        } else {
          _scale = _upScale + (0 - _upScale) * _controller.value;
          _moveX = _upX + (0 - _upX) * _controller.value;
          _moveY = _upY + (0 - _upY) * _controller.value;
        }
      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //有滑动的情况下进行下标++
        if (_direction != Direction.stay) {
          current++;
          if (current >= widget.children.length) {
            current = 0;
          }
        }
        widget.cardSelected?.call(_direction == Direction.right,current);

        setState(() {
          _moveX = 0;
          _moveY = 0;
          _scale = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
      //第一层宽高
      double width =widget.width;
      double height = widget.height;
      //移动比例
      //上下布局使用maxHeight 计算移动比例
      double proportion = widget.height * 0.025;
      //左右布局使用maxWidth 计算移动比例
      if (widget.orientation == CardOrientation.right ||
          widget.orientation == CardOrientation.left) {
        proportion = widget.width * 0.025;
      }
      //计算第二层卡片x,y 默认向下布局
      double layer1X = widget.width * 0.05;
      double layer1Y = (widget.height * 0.05) + proportion;
      double width1 = widget.width - 2 * proportion;
      double height1 = widget.height + 2 * proportion;
      //缩放比例
      double layer1Scale = 0.95;
      //计算第三层卡片x,y 默认向下布局
      double layer2X = widget.width * (1 - 0.95 * 0.95);
      double layer2Y = (widget.height * (1 - 0.95 * 0.95)) + proportion * 2;
      double layer2Scale = layer1Scale * layer1Scale;
      double width2 = widget.width - 3 * proportion;
      double height2 = widget.height + 3 * proportion;
      //向上布局
      if (widget.orientation == CardOrientation.top) {
        layer1Y = (widget.height * 0.05) - proportion * 3;
        layer1X = widget.width * 0.05 - proportion;
        width1 = widget.width - 2 * proportion;
        height1 = widget.height - 2 * proportion;
        height = widget.height + 2 * proportion;

        layer2Y = (widget.height * (1 - 0.95 * 0.95)) - proportion * 6;
        layer2X = widget.width * (1 - 0.95 * 0.95) - proportion;
        width2 = widget.width - 3 * proportion;
        height2 = widget.height - 3 * proportion;
      } else if (widget.orientation == CardOrientation.bottom) {
        layer1Y = (widget.height * 0.05) + proportion * 3;
        layer1X = widget.width * 0.05 - proportion;
        width1 = widget.width - 2 * proportion;
        height1 = widget.height - 2 * proportion;
        height = widget.height + 2 * proportion;

        layer2Y = (widget.height * (1 - 0.95 * 0.95)) + proportion * 2;
        layer2X = widget.width * (1 - 0.95 * 0.95) - proportion;
        width2 = widget.width - 3 * proportion;
        height2 = widget.height + 3 * proportion;
      } else if (widget.orientation == CardOrientation.right) {
        layer1X = widget.width * 0.05 + proportion * 2;
        // layer1Y = (widget.height * 0.05) ;
        width = widget.width - proportion;
        height1 = widget.height - 3 * proportion;

        layer2X = widget.width * (1 - 0.95 * 0.95) + proportion * 4;
        layer2Y = (widget.height * (1 - 0.95 * 0.95)) + proportion;
        height2 = widget.height - 4 * proportion;
      } else if (widget.orientation == CardOrientation.left) {
        layer1X = widget.width * 0.05 - proportion * 3;
        // layer1Y = (widget.height * 0.05) ;
        width = widget.width - proportion;
        height1 = widget.height - 3 * proportion;

        layer2X = widget.width * (1 - 0.95 * 0.95) - proportion * 6;
        layer2Y = (widget.height * (1 - 0.95 * 0.95)) + proportion;
        height2 = widget.height - 4 * proportion;
      }
      if (_scale > 1) {
        _scale = 1;
      }
      List<Widget> children = [];

      if (widget.children.length > 2) {
        children.add(Opacity(
          opacity: 0.8 * 0.8 + 0.8 * 0.2 * _scale,
          child: Transform.scale(
            scale: layer2Scale + (layer1Scale - layer2Scale) * _scale,
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: Offset(layer2X + (layer1X - layer2X) * _scale,
                  layer2Y + (layer1Y - layer2Y) * _scale),
              child: SizedBox(
                child: widget.children[(current + 2) % (widget.children.length)],
                width: width2,
                height: height2,
              ),
            ),
          ),
        ));
      }

      if (widget.children.length > 1) {
        children.add(Opacity(
          opacity: 0.8 + 0.2 * _scale,
          child: Transform.scale(
            scale: layer1Scale + (1 - layer1Scale) * _scale,
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: Offset(layer1X + (0 - layer1X) * _scale,
                  layer1Y + (0 - layer1Y) * _scale),
              child: SizedBox(
                child: widget.children[(current + 1) % (widget.children.length)],
                width: width1,
                height: height1,
              ),
            ),
          ),
        ));
      }

      if (widget.children.isNotEmpty) {
        children.add(Opacity(
          opacity: _moveX == 0 ? 1 : 0.8 + 0.2 * _scale,
          child: Transform.scale(
            scale: 1,
            child: Transform.translate(
              offset: Offset(_moveX, _moveY),
              child: SizedBox(
                child: widget.children[(current) % (widget.children.length)],
                width: width,
                height: height,
              ),
            ),
          ),
        ));
      }

      return GestureDetector(
          child: Stack(
            children: children,
          ),
          onPanUpdate: _onPanUpdate,
          onPanEnd: (DragEndDetails? details) {
            setState(() {
              _upX = _moveX;
              _upY = _moveY;
              _upScale = _scale;

              if (_isToRight()) {
                _direction = Direction.right;
              } else if (_isToLeft()) {
                _direction = Direction.left;
              } else {
                if (details != null) {
                  if (details.velocity.pixelsPerSecond.dx > 1000) {
                    _direction = Direction.right;
                  } else if (details.velocity.pixelsPerSecond.dx < -1000) {
                    _direction = Direction.left;
                  } else {
                    _direction = Direction.stay;
                  }
                } else {
                  _direction = Direction.stay;
                }
              }

              if (widget.children.length == 1) {
                _direction = Direction.stay;
              }
              _startAnim();
            });
          },
          onPanCancel: () {
            setState(() {
              _moveX = 0;
              _moveY = 0;
              _scale = 0;
            });
          });
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (widget.slideType == SlideType.horizontal) {
      _moveX += details.delta.dx;
    } else if (widget.slideType == SlideType.vertical) {
      _moveX += details.delta.dx;
      _moveY += details.delta.dy;
    }

    var size = context.size;
    var distance =
        widget.slideType == SlideType.vertical ? _moveY / size!.width : _moveX / size!.width;

    setState(() {
      _scale = distance < 0 ? -distance : distance;
    });
  }

  bool _isToRight() {
    double width = context.size!.width;
    return _upX > width / 4;
  }

  bool _isToLeft() {
    double width = context.size!.width;
    return _upX < -width / 4;
  }

  void _startAnim() {
    _controller.reset();
    _controller.forward(from: 0);
  }
}
