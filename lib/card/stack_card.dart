import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2025/1/16
/// time: 15:49
/// describe: 堆叠卡片组件 / Stack Card Component
///
/// 支持左右或上下滑动的堆叠卡片效果组件
/// Stack card component with swipe left/right or up/down support
///
/// ## 功能特性 / Features
/// - 📚 堆叠卡片效果 / Stack card effect
/// - 👆 支持滑动切换 / Swipe to switch
/// - 🎨 支持自定义方向 / Custom orientation
/// - 🎬 平滑的动画过渡 / Smooth animation transition
/// - 🔄 自动循环播放 / Auto-loop playback
/// - 📢 支持选择回调 / Selection callback
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单堆叠卡片
/// StackCard(
///   width: 300,
///   height: 400,
///   children: [
///     Card(child: Center(child: Text('卡片1'))),
///     Card(child: Center(child: Text('卡片2'))),
///     Card(child: Center(child: Text('卡片3'))),
///   ],
/// )
///
/// // 带回调的卡片
/// StackCard(
///   width: 280,
///   height: 350,
///   slideType: SlideType.horizontal,
///   children: cards,
///   cardSelected: (isRight, index) {
///     print('向${isRight ? "右" : "左"}滑动, 当前索引: $index');
///   },
/// )
///
/// // 垂直滑动
/// StackCard(
///   width: 300,
///   height: 400,
///   slideType: SlideType.vertical,
///   orientation: CardOrientation.bottom,
///   children: [
///     Image.asset('assets/img1.jpg'),
///     Image.asset('assets/img2.jpg'),
///     Image.asset('assets/img3.jpg'),
///   ],
/// )
///
/// // 自定义动画时长
/// StackCard(
///   width: 250,
///   height: 350,
///   duration: Duration(milliseconds: 500),
///   children: cards,
///   cardSelected: (isRight, index) {
///     // 处理选择逻辑
///   },
/// )
///
/// // 探探式卡片
/// StackCard(
///   width: 320,
///   height: 450,
///   slideType: SlideType.horizontal,
///   orientation: CardOrientation.bottom,
///   children: List.generate(10, (i) {
///     return Container(
///       decoration: BoxDecoration(
///         color: Colors.primaries[i % Colors.primaries.length],
///         borderRadius: BorderRadius.circular(20),
///       ),
///       child: Center(
///         child: Text('用户 ${i + 1}', style: TextStyle(fontSize: 24)),
///       ),
///     );
///   }),
///   cardSelected: (isRight, index) {
///     if (isRight) {
///       print('喜欢');
///     } else {
///       print('不喜欢');
///     }
///   },
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - 至少需要1个子组件 / Requires at least 1 child
/// - 滑动超过1/4宽度会触发切换 / Swipe over 1/4 width triggers switch
/// - 卡片会自动循环显示 / Cards auto-loop
/// - 支持快速滑动手势 / Supports fast swipe gesture
///

/// 卡片选择回调 / Card selection callback
/// [right] true表示向右滑动 / true means swipe right
/// [index] 当前卡片索引 / Current card index
typedef StackCardSelected = Function(bool right, int index);

/// 滑动方向 / Swipe direction
enum Direction {
  /// 向左滑动 / Swipe left
  left,
  /// 向右滑动 / Swipe right
  right,
  /// 无滑动 / No swipe
  stay
}

/// 展示方向 / Display orientation
enum CardOrientation { 
  /// 向左展开 / Expand left
  left, 
  /// 向右展开 / Expand right
  right, 
  /// 向下展开 / Expand bottom
  bottom, 
  /// 向上展开 / Expand top
  top 
}

/// 滑动类型 / Slide type
enum SlideType { 
  /// 左右滑动 / Horizontal slide
  horizontal, 
  /// 上下左右滑动 / Vertical slide (all directions)
  vertical 
}

class StackCard extends StatefulWidget {
  /// 子组件列表 / Children list
  /// 
  /// 堆叠的卡片组件列表
  /// List of stacked card widgets
  /// 
  /// 默认值: [] / Default: []
  final List<Widget> children;

  /// 卡片选择回调 / Card selection callback
  /// 
  /// 滑动选择时触发
  /// Triggered on swipe selection
  final StackCardSelected? cardSelected;

  /// 滑动类型 / Slide type
  /// 
  /// 水平或垂直滑动
  /// Horizontal or vertical slide
  /// 
  /// 默认值: SlideType.horizontal / Default: SlideType.horizontal
  final SlideType slideType;

  /// 展示方向 / Display orientation
  /// 
  /// 卡片堆叠的方向
  /// Direction of card stacking
  /// 
  /// 默认值: CardOrientation.bottom / Default: CardOrientation.bottom
  final CardOrientation orientation;

  /// 动画时长 / Animation duration
  /// 
  /// 切换动画的持续时间
  /// Duration of switch animation
  /// 
  /// 默认值: Duration(milliseconds: 300) / Default: Duration(milliseconds: 300)
  final Duration duration;

  /// 卡片宽度 / Card width
  /// 
  /// 默认值: 140 / Default: 140
  final double width;

  /// 卡片高度 / Card height
  /// 
  /// 默认值: 140 / Default: 140
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
