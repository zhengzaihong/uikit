import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/12
/// create_time: 13:54
/// describe: 智能侧边栏组件 - 灵活的抽屉式导航
/// Enterprise-level smart drawer component - Flexible drawer navigation
///
/// ✨ 功能特性 / Features:
/// • 📏 灵活尺寸 - 支持百分比或固定宽度
/// • 🎨 自定义装饰 - 支持BoxDecoration自定义样式
/// • 🎪 Material风格 - 支持elevation阴影效果
/// • 🔔 状态回调 - 提供打开/关闭状态回调
/// • ♿ 无障碍支持 - 完整的语义化标签支持
/// • 🎯 精确控制 - 支持固定宽度或响应式宽度
/// • 🌈 透明背景 - 支持透明Material背景
///
/// 📖 使用示例 / Usage Examples:
///
/// ```dart
/// // 示例1: 基础侧边栏(百分比宽度)
/// // Example 1: Basic drawer with percentage width
/// Scaffold(
///   drawer: SmartDrawer(
///     widthPercent: 0.7, // 屏幕宽度的70%
///     child: Container(
///       color: Colors.white,
///       child: ListView(
///         children: [
///           DrawerHeader(
///             decoration: BoxDecoration(color: Colors.blue),
///             child: Text('菜单', style: TextStyle(color: Colors.white, fontSize: 24)),
///           ),
///           ListTile(
///             leading: Icon(Icons.home),
///             title: Text('首页'),
///             onTap: () => Navigator.pop(context),
///           ),
///           ListTile(
///             leading: Icon(Icons.settings),
///             title: Text('设置'),
///             onTap: () => Navigator.pop(context),
///           ),
///         ],
///       ),
///     ),
///   ),
///   body: Center(child: Text('主内容')),
/// )
///
/// // 示例2: 固定宽度侧边栏
/// // Example 2: Fixed width drawer
/// Scaffold(
///   drawer: SmartDrawer(
///     width: 300, // 固定300像素宽度
///     elevation: 16.0,
///     child: Container(
///       color: Colors.white,
///       padding: EdgeInsets.all(16),
///       child: Column(
///         crossAxisAlignment: CrossAxisAlignment.start,
///         children: [
///           Text('侧边栏', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
///           Divider(),
///           // 菜单项...
///         ],
///       ),
///     ),
///   ),
/// )
///
/// // 示例3: 自定义装饰样式
/// // Example 3: Custom decoration style
/// SmartDrawer(
///   widthPercent: 0.6,
///   elevation: 8.0,
///   decoration: BoxDecoration(
///     gradient: LinearGradient(
///       colors: [Colors.blue.shade100, Colors.blue.shade300],
///       begin: Alignment.topCenter,
///       end: Alignment.bottomCenter,
///     ),
///     boxShadow: [
///       BoxShadow(
///         color: Colors.black26,
///         blurRadius: 10,
///         offset: Offset(2, 0),
///       ),
///     ],
///   ),
///   child: ListView(
///     padding: EdgeInsets.zero,
///     children: [
///       // 菜单内容...
///     ],
///   ),
/// )
///
/// // 示例4: 带状态回调的侧边栏
/// // Example 4: Drawer with state callback
/// bool isDrawerOpen = false;
/// 
/// SmartDrawer(
///   widthPercent: 0.75,
///   callback: (isOpen) {
///     setState(() {
///       isDrawerOpen = isOpen;
///     });
///     print('侧边栏状态: ${isOpen ? "打开" : "关闭"}');
///   },
///   child: Container(
///     color: Colors.white,
///     child: Column(
///       children: [
///         AppBar(title: Text('侧边栏')),
///         Expanded(
///           child: ListView(
///             children: [
///               // 菜单项...
///             ],
///           ),
///         ),
///       ],
///     ),
///   ),
/// )
///
/// // 示例5: 自定义语义标签
/// // Example 5: Custom semantic label
/// SmartDrawer(
///   widthPercent: 0.65,
///   semanticLabel: '主导航菜单',
///   elevation: 12.0,
///   child: Container(
///     color: Color(0xFF1E1E1E),
///     child: ListView(
///       children: [
///         DrawerHeader(
///           decoration: BoxDecoration(color: Colors.blue.shade900),
///           child: Column(
///             crossAxisAlignment: CrossAxisAlignment.start,
///             children: [
///               CircleAvatar(radius: 30, child: Icon(Icons.person, size: 40)),
///               SizedBox(height: 10),
///               Text('用户名', style: TextStyle(color: Colors.white, fontSize: 18)),
///             ],
///           ),
///         ),
///         ListTile(
///           leading: Icon(Icons.dashboard, color: Colors.white),
///           title: Text('仪表盘', style: TextStyle(color: Colors.white)),
///           onTap: () {},
///         ),
///         ListTile(
///           leading: Icon(Icons.analytics, color: Colors.white),
///           title: Text('分析', style: TextStyle(color: Colors.white)),
///           onTap: () {},
///         ),
///       ],
///     ),
///   ),
/// )
/// ```
///
/// ⚠️ 注意事项 / Notes:
/// • widthPercent和width二选一,优先使用width
/// • widthPercent取值范围建议0.3-0.9,避免过宽或过窄
/// • callback会在侧边栏打开时传入true,关闭时传入false
/// • elevation控制阴影深度,建议范围0-16
/// • 使用decoration时会包裹child,可实现渐变等效果
/// • semanticLabel用于无障碍支持,建议提供有意义的标签
/// • 通常与Scaffold的drawer或endDrawer属性配合使用
///
class SmartDrawer extends StatefulWidget {
  /// 阴影深度 / Elevation depth
  /// 默认值: 0.0
  /// 建议范围: 0-16
  final double elevation;
  
  /// 子组件 / Child widget
  final Widget child;
  
  /// 语义标签(用于无障碍) / Semantic label (for accessibility)
  /// 默认使用系统提供的drawerLabel
  final String? semanticLabel;
  
  /// 宽度百分比(相对屏幕宽度) / Width percentage (relative to screen width)
  /// 默认值: 0.35 (35%)
  /// 范围: 0.0-1.0
  /// 注意: width和widthPercent二选一,优先使用width
  final double? widthPercent;
  
  /// 固定宽度(像素) / Fixed width (pixels)
  /// 优先级高于widthPercent
  final double? width;
  
  /// 状态回调 / State callback
  /// 打开时传入true,关闭时传入false
  final DrawerCallback? callback;
  
  /// 装饰样式 / Decoration style
  /// 支持渐变、边框、阴影等
  final BoxDecoration? decoration;

  const SmartDrawer({
    Key? key,
    this.elevation = 0.0,
    required this.child,
    this.semanticLabel,
    this.widthPercent = 0.35,
    this.width,
    this.decoration,
    this.callback,
  }) : super(key: key);

  @override
  _SmartDrawerState createState() => _SmartDrawerState();
}

class _SmartDrawerState extends State<SmartDrawer> {
  @override
  void initState() {
    if (widget.callback != null) {
      widget.callback!(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.callback != null) {
      widget.callback!(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String? label = widget.semanticLabel ?? MaterialLocalizations.of(context).drawerLabel;
    double _width;
    if (widget.width != null) {
      _width = widget.width!;
    } else {
      _width = MediaQuery.of(context).size.width * widget.widthPercent!;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          color: Colors.transparent,
          elevation: widget.elevation,
          child: widget.decoration == null
              ? widget.child
              : Container(decoration: widget.decoration, child: widget.child),
        ),
      ),
    );
  }
}
