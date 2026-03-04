import 'package:flutter/material.dart';
import 'package:uikit_plus/utils/color_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/1/4
/// create_time: 16:40
/// describe: 底部导航栏动画组件 - 流畅的切换动画效果
/// Enterprise-level animated bottom navigation bar component - Smooth switching animation
///
/// ✨ 功能特性 / Features:
/// • 🎬 流畅动画 - 选中项平滑展开/收缩动画
/// • 🎨 高度自定义 - 支持自定义图标、颜色、尺寸
/// • 📱 响应式设计 - 自适应不同屏幕尺寸
/// • 🎯 灵活布局 - 支持多种对齐方式
/// • 🔄 状态管理 - 自动管理选中状态
/// • 🎪 Material风格 - 支持阴影、圆角等Material属性
/// • 📏 尺寸可控 - 支持自定义容器高度、图标大小
/// • 🌈 多彩主题 - 每个项可配置独立的激活颜色
///
/// 📖 使用示例 / Usage Examples:
///
/// ```dart
/// // 示例1: 基础底部导航栏
/// // Example 1: Basic bottom navigation bar
/// int currentIndex = 0;
/// 
/// CustomAnimatedBottomBar(
///   containerHeight: 56,
///   mainAxisAlignment: MainAxisAlignment.spaceAround,
///   backgroundColor: Colors.white,
///   selectedIndex: currentIndex,
///   itemCornerRadius: 24,
///   curve: Curves.easeInOut,
///   showElevation: true,
///   onItemSelected: (index) => setState(() => currentIndex = index),
///   items: <MyBottomNavigationBarItem>[
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.home, color: Colors.blue),
///       unCheckedIcon: Icon(Icons.home_outlined, color: Colors.grey),
///       title: Text('首页'),
///       activeColor: Colors.blue,
///       textAlign: TextAlign.center,
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.person, color: Colors.green),
///       unCheckedIcon: Icon(Icons.person_outline, color: Colors.grey),
///       title: Text('我的'),
///       activeColor: Colors.green,
///       textAlign: TextAlign.center,
///     ),
///   ],
/// )
///
/// // 示例2: 自定义图标和颜色
/// // Example 2: Custom icons and colors
/// CustomAnimatedBottomBar(
///   containerHeight: 60,
///   backgroundColor: Color(0xFF1E1E1E),
///   selectedIndex: currentIndex,
///   iconSize: 28,
///   onItemSelected: (index) => setState(() => currentIndex = index),
///   items: [
///     MyBottomNavigationBarItem(
///       checkedIcon: Image.asset('assets/home_active.png', width: 28),
///       unCheckedIcon: Image.asset('assets/home_inactive.png', width: 28),
///       title: Text('首页', style: TextStyle(fontSize: 12)),
///       activeColor: Color(0xFF8E93F9),
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Image.asset('assets/discover_active.png', width: 28),
///       unCheckedIcon: Image.asset('assets/discover_inactive.png', width: 28),
///       title: Text('发现', style: TextStyle(fontSize: 12)),
///       activeColor: Color(0xFFFF6B6B),
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Image.asset('assets/profile_active.png', width: 28),
///       unCheckedIcon: Image.asset('assets/profile_inactive.png', width: 28),
///       title: Text('我的', style: TextStyle(fontSize: 12)),
///       activeColor: Color(0xFF4ECDC4),
///     ),
///   ],
/// )
///
/// // 示例3: 无阴影扁平风格
/// // Example 3: Flat style without elevation
/// CustomAnimatedBottomBar(
///   containerHeight: 56,
///   backgroundColor: Colors.transparent,
///   selectedIndex: currentIndex,
///   showElevation: false,
///   itemCornerRadius: 20,
///   animationDuration: Duration(milliseconds: 300),
///   onItemSelected: (index) => setState(() => currentIndex = index),
///   items: [
///     // ... items
///   ],
/// )
///
/// // 示例4: 自定义动画曲线
/// // Example 4: Custom animation curve
/// CustomAnimatedBottomBar(
///   containerHeight: 56,
///   selectedIndex: currentIndex,
///   curve: Curves.elasticOut,
///   animationDuration: Duration(milliseconds: 500),
///   onItemSelected: (index) => setState(() => currentIndex = index),
///   items: [
///     // ... items
///   ],
/// )
///
/// // 示例5: 多项导航(最多5项)
/// // Example 5: Multiple items (max 5)
/// CustomAnimatedBottomBar(
///   containerHeight: 56,
///   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
///   selectedIndex: currentIndex,
///   onItemSelected: (index) => setState(() => currentIndex = index),
///   items: [
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.home, color: Colors.blue),
///       unCheckedIcon: Icon(Icons.home_outlined, color: Colors.grey),
///       title: Text('首页'),
///       activeColor: Colors.blue,
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.explore, color: Colors.orange),
///       unCheckedIcon: Icon(Icons.explore_outlined, color: Colors.grey),
///       title: Text('发现'),
///       activeColor: Colors.orange,
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.message, color: Colors.green),
///       unCheckedIcon: Icon(Icons.message_outlined, color: Colors.grey),
///       title: Text('消息'),
///       activeColor: Colors.green,
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.shopping_cart, color: Colors.red),
///       unCheckedIcon: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
///       title: Text('购物车'),
///       activeColor: Colors.red,
///     ),
///     MyBottomNavigationBarItem(
///       checkedIcon: Icon(Icons.person, color: Colors.purple),
///       unCheckedIcon: Icon(Icons.person_outline, color: Colors.grey),
///       title: Text('我的'),
///       activeColor: Colors.purple,
///     ),
///   ],
/// )
/// ```
///
/// ⚠️ 注意事项 / Notes:
/// • 导航项数量必须在2-5之间
/// • checkedIcon和unCheckedIcon分别表示选中和未选中状态的图标
/// • activeColor会应用到选中项的背景和文本
/// • 建议使用状态管理(如Provider)管理currentIndex
/// • 动画时长建议在200-500ms之间,过长会影响体验
/// • 容器高度建议在48-72之间,过高或过低都会影响美观
///

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
          isSelected ? item.activeColor.setAlpha(0.2) : backgroundColor,
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