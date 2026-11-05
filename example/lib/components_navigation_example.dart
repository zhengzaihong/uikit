import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ComponentsNavigationExample extends StatefulWidget {
  const ComponentsNavigationExample({super.key});

  @override
  State<ComponentsNavigationExample> createState() =>
      _ComponentsNavigationExampleState();
}

class _ComponentsNavigationExampleState
    extends State<ComponentsNavigationExample> {
  int _classicIndex = 0;
  int _badgeIndex = 1;
  int _pillIndex = 0;
  int _iconIndex = 0;

  static const _drawerItems = <(IconData, String)>[
    (Icons.dashboard_outlined, '仪表盘'),
    (Icons.insights_outlined, '数据概览'),
    (Icons.folder_outlined, '项目管理'),
    (Icons.settings_outlined, '设置'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showcaseAppBar(context, '导航与动画'),
      drawer: SmartDrawer(
        width: 280,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F2430), Color(0xFF343B52)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF6558E8),
                      child: Text(
                        'U',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'uikit_plus',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '组件示例导航',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white24, height: 1),
              for (final item in _drawerItems)
                ListTile(
                  leading: Icon(item.$1, color: Colors.white70),
                  title: Text(item.$2, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.of(context).pop(),
                ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'SmartDrawer',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        children: [
          ShowcaseSection(
            title: '经典底部导航',
            icon: Icons.navigation_outlined,
            description: '图标 + 文字 + 选中动效，适合作品主框架',
            child: Column(
              children: [
                _bar(
                  index: _classicIndex,
                  onChanged: (index) => setState(() => _classicIndex = index),
                  items: [
                    MyBottomNavigationBarItem(
                      checkedIcon: Icon(Icons.home),
                      unCheckedIcon: Icon(Icons.home_outlined),
                      title: Text('首页'),
                    ),
                    MyBottomNavigationBarItem(
                      checkedIcon: Icon(Icons.explore),
                      unCheckedIcon: Icon(Icons.explore_outlined),
                      title: Text('发现'),
                    ),
                    MyBottomNavigationBarItem(
                      checkedIcon: Icon(Icons.person),
                      unCheckedIcon: Icon(Icons.person_outline),
                      title: Text('我的'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('当前索引：$_classicIndex'),
              ],
            ),
          ),
          ShowcaseSection(
            title: '徽章与主题色',
            icon: Icons.notifications_active_outlined,
            description: '每个入口可独立配置选中色与角标数量',
            child: _bar(
              index: _badgeIndex,
              onChanged: (index) => setState(() => _badgeIndex = index),
              items: [
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.storefront),
                  unCheckedIcon: Icon(Icons.storefront_outlined),
                  title: Text('商城'),
                  activeColor: Color(0xFF6558E8),
                ),
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.shopping_cart),
                  unCheckedIcon: Icon(Icons.shopping_cart_outlined),
                  title: Text('购物车'),
                  activeColor: Color(0xFF00A8E8),
                  showBadge: true,
                  badgeCount: 12,
                ),
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.favorite),
                  unCheckedIcon: Icon(Icons.favorite_border),
                  title: Text('收藏'),
                  activeColor: Color(0xFFE84393),
                ),
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.person),
                  unCheckedIcon: Icon(Icons.person_outline),
                  title: Text('我的'),
                  activeColor: Color(0xFF00B894),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: '胶囊浮岛导航',
            icon: Icons.view_agenda_outlined,
            description: '深色背景 + 超大圆角，可作为悬浮底栏',
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: CustomAnimatedBottomBar(
                  selectedIndex: _pillIndex,
                  onChanged: (index) => setState(() => _pillIndex = index),
                  backgroundColor: const Color(0xFF1F2430),
                  showElevation: false,
                  containerHeight: 58,
                  itemCornerRadius: 24,
                  items: [
                    MyBottomNavigationBarItem(
                      checkedIcon: Icon(Icons.bolt),
                      unCheckedIcon: Icon(Icons.bolt_outlined),
                      title: Text('动态'),
                      activeColor: Color(0xFF00E5FF),
                    ),
                    MyBottomNavigationBarItem(
                      checkedIcon: Icon(Icons.chat_bubble),
                      unCheckedIcon: Icon(Icons.chat_bubble_outline),
                      title: Text('消息'),
                      activeColor: Color(0xFF7C4DFF),
                      showBadge: true,
                      badgeCount: 3,
                    ),
                    MyBottomNavigationBarItem(
                      checkedIcon: Icon(Icons.settings),
                      unCheckedIcon: Icon(Icons.settings_outlined),
                      title: Text('设置'),
                      activeColor: Color(0xFFFFB74D),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ShowcaseSection(
            title: '仅图标导航',
            icon: Icons.apps_outlined,
            description: '不展示文字时可将 title 传入空组件',
            child: _bar(
              index: _iconIndex,
              onChanged: (index) => setState(() => _iconIndex = index),
              items: [
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.grid_view_rounded),
                  unCheckedIcon: Icon(Icons.grid_view_outlined),
                  title: SizedBox.shrink(),
                  activeColor: Color(0xFF6558E8),
                ),
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.search),
                  unCheckedIcon: Icon(Icons.search),
                  title: SizedBox.shrink(),
                  activeColor: Color(0xFF00A8E8),
                ),
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.bookmark),
                  unCheckedIcon: Icon(Icons.bookmark_border),
                  title: SizedBox.shrink(),
                  activeColor: Color(0xFFE84393),
                ),
                MyBottomNavigationBarItem(
                  checkedIcon: Icon(Icons.person),
                  unCheckedIcon: Icon(Icons.person_outline),
                  title: SizedBox.shrink(),
                  activeColor: Color(0xFF00B894),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'SmartDrawer 自定义抽屉',
            icon: Icons.menu_open,
            description: '支持宽度、渐变背景与完整自定义内容',
            child: Builder(
              builder: (context) => FilledButton.icon(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
                label: const Text('打开抽屉'),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Responsive 响应式布局',
            icon: Icons.devices_outlined,
            description: '根据可用宽度自动切换 mobile / tablet / desktop',
            child: Responsive(
              mobile: _deviceCard(
                'Mobile 布局',
                '单列卡片，适合手机',
                Icons.smartphone,
                Colors.orange,
              ),
              tablet: _deviceCard(
                'Tablet 布局',
                '双列卡片，适合平板',
                Icons.tablet_mac,
                Colors.blue,
              ),
              desktop: _deviceCard(
                'Desktop 布局',
                '多列布局，适合桌面',
                Icons.desktop_windows,
                Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar({
    required int index,
    required ValueChanged<int> onChanged,
    required List<MyBottomNavigationBarItem> items,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CustomAnimatedBottomBar(
        selectedIndex: index,
        onChanged: onChanged,
        items: items,
        showElevation: false,
        containerHeight: 58,
      ),
    );
  }

  Widget _deviceCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          hGap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: color.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}