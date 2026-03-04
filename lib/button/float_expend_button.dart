import 'package:flutter/material.dart';
import 'package:uikit_plus/button/float_expend_button.dart';


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

  //主菜单卡变化图标（动画图标，保持兼容）
  final AnimatedIconData? mainAnimatedIcon;

  //自定义收起/展开图标（可传入任意Widget）
  final Widget? mainCollapseWidget;
  final Widget? mainExpandWidget;

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
    this.mainTabBeginColor = Colors.transparent,
    this.mainTabAfterColor = Colors.grey,
    this.mainAnimatedIcon = AnimatedIcons.menu_close,
    this.iconSize = 15,
    this.curve = Curves.easeOut,
    this.duration = const Duration(milliseconds: 300),
    this.type = ButtonType.left,
    this.mainCollapseWidget,
    this.mainExpandWidget,
    Key? key,
  }) : super(key: key);

  @override
  _FloatExpendState createState() => _FloatExpendState();
}

class _FloatExpendState extends State<FloatExpendButton> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _fabTween;

  @override
  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.addListener(() {
      setState(() {});
    });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
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
      curve: const Interval(0.0, 0.75),
    ));
  }

  double _getFabTweenAfter() {
    if (widget.type == ButtonType.right || widget.type == ButtonType.bottom) {
      return widget.fabHeight! + widget.tabSpace!;
    } else {
      return -(widget.fabHeight! + widget.tabSpace!);
    }
  }

  double _getFabTranslateX(int i) {
    if (widget.type == ButtonType.left || widget.type == ButtonType.right) {
      return _fabTween.value * (i + 1);
    } else {
      return 0;
    }
  }

  double _getFabTranslateY(int i) {
    if (widget.type == ButtonType.top || widget.type == ButtonType.bottom) {
      return _fabTween.value * (i + 1);
    } else {
      return 0;
    }
  }

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
    List<Widget> itemList = [];

    for (int i = 0; i < widget.iconList.length; i++) {
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
              shape: const CircleBorder(),
              onPressed: () {
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
        Positioned(child: floatButton()),
      ],
    );
  }

  Widget floatButton() {
    return SizedBox(
      width: widget.fabHeight,
      height: widget.fabHeight,
      child: FloatingActionButton(
        backgroundColor: _animateColor.value,
        onPressed: floatClick,
        elevation: 0.5,
        shape: const CircleBorder(),
        child: _buildMainIcon(),
      ),
    );
  }

  Widget _buildMainIcon() {
    // 优先使用自定义 Widget
    if (widget.mainCollapseWidget != null &&
        widget.mainExpandWidget != null) {
      return AnimatedCrossFade(
        firstChild: widget.mainCollapseWidget!,
        secondChild: widget.mainExpandWidget!,
        crossFadeState:
        isOpened ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: widget.duration!,
        firstCurve: widget.curve!,
        secondCurve: widget.curve!,
      );
    }

    // 回退使用 AnimatedIcon
    return AnimatedIcon(
      icon: widget.mainAnimatedIcon!,
      size: widget.iconSize,
      progress: _animateIcon,
    );
  }

  void floatClick() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

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