import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// describe: 满意度 RatingBar（支持 step、allowZero、readOnly）
///
class RatingBar extends StatefulWidget {
  /// 星星数量
  final int count;

  /// 最大值
  final double maxRating;

  /// 当前值
  final double value;

  /// 星星大小
  final double size;

  /// 两个星星之间的间隔
  final double padding;

  ///非选中的星星图片
  final Widget normalImage;

  /// 选中时的图片
  final Widget selectImage;

  /// 是否能够点击和滑动
  final bool selectAble;

  /// 点击回调
  final ValueChanged<double>? onRatingUpdate;

  /// 步长（例如 1.0 表示整星，0.5 半星，0.1 精确到 0.1）
  final double step;

  /// 是否允许为 0 分（false 时至少为 step）
  final bool allowZero;

  /// 是否只读（只展示，不能交互）
  final bool readOnly;

  const RatingBar({
    this.maxRating = 10.0,
    this.count = 5,
    this.value = 0,
    this.size = 20,
    required this.normalImage,
    required this.selectImage,
    this.padding = 3,
    this.selectAble = false,
    this.step = 1.0,
    this.allowZero = true,
    this.readOnly = false,
    this.onRatingUpdate,
    Key? key,
  }) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double value = 0;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.readOnly) {
      // 只读模式：仅展示
      return buildRowRating();
    }

    return Listener(
      child: buildRowRating(),
      onPointerDown: (PointerDownEvent event) {
        if (widget.selectAble) pointValue(event.localPosition.dx);
      },
      onPointerMove: (PointerMoveEvent event) {
        if (widget.selectAble) pointValue(event.localPosition.dx);
      },
      onPointerUp: (_) {},
      behavior: HitTestBehavior.deferToChild,
    );
  }

  void pointValue(double dx) {
    if (dx < 0) dx = 0;
    double newValue;
    if (dx >= widget.size * widget.count + widget.padding * (widget.count - 1)) {
      newValue = widget.maxRating;
    } else {
      newValue = dx /
          (widget.size * widget.count + widget.padding * (widget.count - 1)) *
          widget.maxRating;
    }

    // ====== 对齐到 step ======
    if (widget.step > 0) {
      newValue = (newValue / widget.step).roundToDouble() * widget.step;
    }

    // 限制范围
    if (newValue > widget.maxRating) {
      newValue = widget.maxRating;
    } else if (newValue < 0) {
      newValue = 0;
    }

    // ====== 判断 allowZero ======
    if (!widget.allowZero && newValue == 0) {
      newValue = widget.step; // 至少为 step
    }

    setState(() {
      value = newValue;
      widget.onRatingUpdate?.call(value);
    });
  }

  int fullStars() {
    return (value / (widget.maxRating / widget.count)).floor();
  }

  double star() {
    return (value % (widget.maxRating / widget.count)) /
        (widget.maxRating / widget.count);
  }

  List<Widget> buildRow() {
    int full = fullStars();
    List<Widget> children = [];
    for (int i = 0; i < full; i++) {
      children.add(widget.selectImage);
      if (i < widget.count - 1) {
        children.add(SizedBox(width: widget.padding));
      }
    }

    if (full < widget.count) {
      children.add(
        ClipRect(
          clipper: SMClipper(rating: star() * widget.size),
          child: widget.selectImage,
        ),
      );
    }

    return children;
  }

  List<Widget> buildNormalRow() {
    List<Widget> children = [];
    for (int i = 0; i < widget.count; i++) {
      children.add(widget.normalImage);
      if (i < widget.count - 1) {
        children.add(SizedBox(width: widget.padding));
      }
    }
    return children;
  }

  Widget buildRowRating() {
    return Stack(
      children: <Widget>[
        Row(children: buildNormalRow()),
        Row(children: buildRow()),
      ],
    );
  }
}

class SMClipper extends CustomClipper<Rect> {
  final double rating;

  SMClipper({required this.rating});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, rating, size.height);
  }

  @override
  bool shouldReclip(SMClipper oldClipper) {
    return rating != oldClipper.rating;
  }
}
