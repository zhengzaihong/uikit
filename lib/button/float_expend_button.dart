import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2023/4/19
/// create_time: 13:44
/// describe: 用于悬浮伸展菜单
///
class FloatExpendButton extends StatefulWidget {

  //展开的按钮
  final List<FloatButtonStyle> iconList;

  //按钮高度
  final double? fabHeight;

  //主菜单按钮图标大小
  final double? iconSize;

  //选项卡按钮间隔
  final double? tabSpace;

  //主菜单卡收起后颜色
  final Color? mainTabBeginColor;

  //主菜单卡展开后颜色
  final Color? mainTabAfterColor;

  //主菜单卡变化图标（动画图标）
  final AnimatedIconData? mainAnimatedIcon;

  //选项卡类型即展开方向
  final ButtonType? type;

  //按钮的点击事件
  final Function(int index) callback;

  //动画执行速率
  final Curve? curve;

  final Duration? duration;

  const FloatExpendButton({
    required this.callback,
    required this.iconList,
    this.fabHeight = 30,
    this.tabSpace = 10,
    this.mainTabBeginColor = Colors.red,
    this.mainTabAfterColor = Colors.grey,
    this.mainAnimatedIcon = AnimatedIcons.menu_close,
    this.iconSize = 15,
    this.curve = Curves.easeOut,
    this.duration = const Duration(milliseconds: 300),
    this.type = ButtonType.left,
    Key? key,
  }) : super(key: key);

  @override
  _FloatExpendState createState() => _FloatExpendState();
}

class _FloatExpendState extends State<FloatExpendButton> with SingleTickerProviderStateMixin {
  //记录是否打开
  bool isOpened = false;

  //动画控制器
  late AnimationController _animationController;

  //颜色变化取值
  late Animation<Color?> _animateColor;

  //图标变化取值
  late Animation<double> _animateIcon;

  //按钮的位置动画
  late Animation<double> _fabTween;

  @override
  initState() {
    super.initState();
    //初始化动画控制器
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    //添加动画监听
    _animationController.addListener(() {
      setState(() {});
    });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: widget.mainTabBeginColor,
      end: widget.mainTabAfterColor,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: widget.curve!));

    _fabTween = Tween<double>(
      begin: 0,
      end: _getFabTweenAfter(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: widget.curve!,
      ),
    ));
  }

  //根据类型获取变化结束值
  double _getFabTweenAfter() {
    if (widget.type == ButtonType.right || widget.type == ButtonType.bottom) {
      return widget.fabHeight! + widget.tabSpace!;
    } else {
      return -(widget.fabHeight! + widget.tabSpace!);
    }
  }

  //根据类型获取X轴移动数值
  double _getFabTranslateX(int i) {
    if (widget.type == ButtonType.left || widget.type == ButtonType.right) {
      return _fabTween.value * (i + 1);
    } else {
      return 0;
    }
  }

  //根据类型获取Y轴移动数值
  double _getFabTranslateY(int i) {
    if (widget.type == ButtonType.top || widget.type == ButtonType.bottom) {
      return _fabTween.value * (i + 1);
    } else {
      return 0;
    }
  }

  //根据类型获取主菜单位置
  AlignmentGeometry _getAlignment() {
    if (widget.type == ButtonType.top) {
      return Alignment.bottomCenter;
    } else if (widget.type == ButtonType.left) {
      return Alignment.centerRight;
    } else if (widget.type == ButtonType.bottom) {
      return Alignment.topCenter;
    } else {
      return Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    //构建子菜单
    List<Widget> itemList = [];

    for (int i = 0; i < widget.iconList.length; i++) {
      //通过Transform来促成FloatingActionButton的平移
      itemList.add(
        Transform(
          transform: Matrix4.translationValues(
              _getFabTranslateX(i), _getFabTranslateY(i), 0.0),
          child: SizedBox(
            width: widget.fabHeight,
            height: widget.fabHeight,
            child: FloatingActionButton(
              heroTag: "$i",
              elevation: 0.5,
              backgroundColor: widget.iconList[i].tabColor,
              onPressed: () {
                //点击菜单子选项要求菜单弹缩回去
                floatClick();
                widget.callback(i);
              },
              child: widget.iconList[i].icon,
            ),
          ),
        ),
      );
    }

    return Stack(
      alignment: _getAlignment(),
      children: [
        widget.type == ButtonType.left || widget.type == ButtonType.right
            ? SizedBox(
                width: (widget.fabHeight! + widget.tabSpace!) *
                        widget.iconList.length +
                    widget.fabHeight!)
            : SizedBox(
                height: (widget.fabHeight! + widget.tabSpace!) *
                        widget.iconList.length +
                    widget.fabHeight!),

        ...itemList,

        Positioned(
          child: floatButton(),
        ),
      ]
    );
  }

  //构建固定旋转菜单按钮
  Widget floatButton() {
    return SizedBox(
      width: widget.fabHeight,
      height: widget.fabHeight,
      child: FloatingActionButton(
        //通过_animateColor实现背景颜色的过渡
        backgroundColor: _animateColor.value, // _animateColor.value
        onPressed: floatClick,
        elevation: 0.5,
        //通过AnimatedIcon实现标签的过渡
        child: AnimatedIcon(
          icon: widget.mainAnimatedIcon!,
          size: widget.iconSize,
          progress: _animateIcon,
        ),
      ),
    );
  }

  ///FloatingActionButton的点击事件，用来控制按钮的动画变换
  void floatClick() {
    if (!isOpened) {
      _animationController.forward(); //展开动画
    } else {
      _animationController.reverse(); //收回动画
    }
    isOpened = !isOpened;
  }

  //页面销毁时，销毁动画控制器
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum ButtonType { left, right, top, bottom }

class FloatButtonStyle {

  //选项卡按钮颜色
  final Color? tabColor;

  //选项卡按钮
  final Widget? icon;

  FloatButtonStyle({
    this.tabColor = Colors.blue,
    required this.icon
  });
}