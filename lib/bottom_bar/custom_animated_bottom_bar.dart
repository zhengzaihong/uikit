import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/1/4
/// create_time: 16:40
/// describe: 底部菜单 动画组件
/// eg:
//    CustomAnimatedBottomBar(
//           containerHeight: 56,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           backgroundColor:  Colors.transparent,
//           selectedIndex: currentIndex,
//           itemCornerRadius: 24,
//           curve: Curves.linear,
//           showElevation: false,
//           onItemSelected: (index) => setState(() => currentIndex = index),
//           items: <MyBottomNavigationBarItem>[
//             MyBottomNavigationBarItem(
//               checkedIcon: _bottomIcon(homeImage(_bottomNavList[0].checkedIcon),iconColor: ColorUtils.ff8E93F9),
//               unCheckedIcon: _bottomIcon(homeImage(_bottomNavList[0].unCheckIcon),iconColor: Colors.grey),
//               title: Text(_bottomNavList[0].name),
//               activeColor:ColorUtils.ff8E93F9,
//               textAlign: TextAlign.center,
//             ),
//             MyBottomNavigationBarItem(
//               checkedIcon: _bottomIcon(homeImage(_bottomNavList[1].checkedIcon),iconColor: ColorUtils.ff8E93F9),
//               unCheckedIcon: _bottomIcon(homeImage(_bottomNavList[1].unCheckIcon),iconColor: Colors.grey),
//               // icon:  Icon(Icons.person),
//               title: Text(_bottomNavList[1].name),
//               activeColor: ColorUtils.ff8E93F9,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         )

class CustomAnimatedBottomBar extends StatelessWidget {

  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor = Colors.white,
    this.itemCornerRadius = 28,
    this.containerHeight = 48,
    this.animationDuration = const Duration(milliseconds: 200),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.easeInOut,
  }):assert(items.length >= 2 && items.length <= 5),
   super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<MyBottomNavigationBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              final index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: backgroundColor!,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final MyBottomNavigationBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 100 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
          isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 100 : 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                if (isSelected) item.checkedIcon else item.unCheckedIcon,
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class MyBottomNavigationBarItem {

  MyBottomNavigationBarItem({
    required this.checkedIcon,
    required this.unCheckedIcon,
    required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
  });

  final Widget checkedIcon;
  final Widget unCheckedIcon;
  final Widget title;
  final Color activeColor;
  final TextAlign? textAlign;

}