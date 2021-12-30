import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/24
/// create_time: 14:36
/// describe: 满意度RatingBar
///
class RatingBarWidget extends StatefulWidget {
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
  final String nomalImage;

  /// 选中时的图片
  final String selectImage;

  /// 是否能够点击
  final bool selectAble;

  /// 点击回调
  final ValueChanged<String>? onRatingUpdate;

  const RatingBarWidget(
      {this.maxRating = 10.0,
      this.count = 5,
      this.value = 0,
      this.size = 20,
      this.nomalImage = "",
      this.selectImage="",
      this.padding = 3,
      this.selectAble = false,
      required this.onRatingUpdate,Key? key}):super(key: key);

  @override
  _RatingBarWidgetState createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  double value = 0 ;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: buildRowRating(),
      onPointerDown: (PointerDownEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerMove: (PointerMoveEvent event) {
        double x = event.localPosition.dx;
        if (x < 0) x = 0;
        pointValue(x);
      },
      onPointerUp: (_) {},
      behavior: HitTestBehavior.deferToChild,
    );
  }

  pointValue(double dx) {
    if (!widget.selectAble) {
      return;
    }
    if (dx >=
        widget.size * widget.count + widget.padding * (widget.count - 1)) {
      value = widget.maxRating;
    } else {
      for (double i = 1; i < widget.count + 1; i++) {
        if (dx > widget.size * i + widget.padding * (i - 1) &&
            dx < widget.size * i + widget.padding * i) {
          value = i * (widget.maxRating / widget.count);
          break;
        } else if (dx > widget.size * (i - 1) + widget.padding * (i - 1) &&
            dx < widget.size * i + widget.padding * i) {
          value = (dx - widget.padding * (i - 1)) /
              (widget.size * widget.count) *
              widget.maxRating;
          break;
        }
      }
    }
    setState(() {
      if(widget.onRatingUpdate!=null){
        widget.onRatingUpdate!(value.toStringAsFixed(1));
      }

    });
  }

  int fullStars() {
    if (value != null) {
      return (value / (widget.maxRating / widget.count)).floor();
    }
    return 0;
  }

  double star() {
    if (value != null) {
      if (widget.count / fullStars() == widget.maxRating / value) {
        return 0;
      }
      return (value % (widget.maxRating / widget.count)) /
          (widget.maxRating / widget.count);
    }
    return 0;
  }

  List<Widget> buildRow() {
    int full = fullStars();
    List<Widget> children = [];
    for (int i = 0; i < full; i++) {
      children.add(Image.asset(
        widget.selectImage,
        height: widget.size,
        width: widget.size,
      ));
      if (i < widget.count - 1) {
        children.add(
          SizedBox(
            width: widget.padding,
          ),
        );
      }
    }
    if (full < widget.count) {
      children.add(ClipRect(
        clipper: SMClipper(rating: star() * widget.size),
        child: Image.asset(widget.selectImage,
            height: widget.size, width: widget.size),
      ));
    }

    return children;
  }

  List<Widget> buildNomalRow() {
    List<Widget> children = [];
    for (int i = 0; i < widget.count; i++) {
      children.add(Image.asset(
        widget.nomalImage,
        height: widget.size,
        width: widget.size,
      ));
      if (i < widget.count - 1) {
        children.add(SizedBox(
          width: widget.padding,
        ));
      }
    }
    return children;
  }

  Widget buildRowRating() {
    return Container(
      child: Stack(
        children: <Widget>[
          Row(
            children: buildNomalRow(),
          ),
          Row(
            children: buildRow(),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }
}

class SMClipper extends CustomClipper<Rect> {
  final double rating;
  SMClipper({required this.rating}) : assert(rating != null);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, rating, size.height);
  }

  @override
  bool shouldReclip(SMClipper oldClipper) {
    return rating != oldClipper.rating;
  }
}
