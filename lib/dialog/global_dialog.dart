import 'dart:async';

import 'package:flutter/material.dart';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2025-12-26
/// time: 11:20
/// describe: 全局对话框组件 - 支持自动消失和单例管理
/// Enterprise-level global dialog component - Supports auto-dismiss and singleton management
///
/// ✨ 功能特性 / Features:
/// • 🎯 全局单例 - 确保同一时间只显示一个对话框
/// • ⏱️ 自动消失 - 支持设置自动关闭时间
/// • 🔄 智能重置 - 重复调用时重置倒计时而非重复创建
/// • 🎨 完全自定义 - 对话框内容完全由开发者控制
/// • 🔒 手动控制 - 支持主动关闭对话框
/// • 📍 根Overlay - 使用rootOverlay确保显示在最顶层
/// • 💾 资源管理 - 自动管理Timer和OverlayEntry资源
///
/// 📖 使用示例 / Usage Examples:
///
/// ```dart
/// // 示例1: 基础全局对话框(自动消失)
/// // Example 1: Basic global dialog with auto-dismiss
/// GlobalDialog.show(
///   context: context,
///   duration: Duration(seconds: 3),
///   builder: (context) {
///     return Center(
///       child: Material(
///         color: Colors.transparent,
///         child: Container(
///           padding: EdgeInsets.all(20),
///           decoration: BoxDecoration(
///             color: Colors.white,
///             borderRadius: BorderRadius.circular(12),
///             boxShadow: [
///               BoxShadow(
///                 color: Colors.black26,
///                 blurRadius: 10,
///                 offset: Offset(0, 4),
///               ),
///             ],
///           ),
///           child: Column(
///             mainAxisSize: MainAxisSize.min,
///             children: [
///               Icon(Icons.check_circle, color: Colors.green, size: 48),
///               SizedBox(height: 16),
///               Text('操作成功', style: TextStyle(fontSize: 18)),
///             ],
///           ),
///         ),
///       ),
///     );
///   },
/// );
///
/// // 示例2: 不自动消失的对话框(需手动关闭)
/// // Example 2: Dialog without auto-dismiss (manual close required)
/// GlobalDialog.show(
///   context: context,
///   builder: (context) {
///     return Center(
///       child: Material(
///         color: Colors.transparent,
///         child: Container(
///           width: 300,
///           padding: EdgeInsets.all(24),
///           decoration: BoxDecoration(
///             color: Colors.white,
///             borderRadius: BorderRadius.circular(16),
///           ),
///           child: Column(
///             mainAxisSize: MainAxisSize.min,
///             children: [
///               Text('确认操作', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
///               SizedBox(height: 16),
///               Text('是否确认执行此操作？'),
///               SizedBox(height: 24),
///               Row(
///                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
///                 children: [
///                   ElevatedButton(
///                     onPressed: () {
///                       GlobalDialog.hide();
///                     },
///                     child: Text('取消'),
///                   ),
///                   ElevatedButton(
///                     onPressed: () {
///                       // 执行操作
///                       GlobalDialog.hide();
///                     },
///                     child: Text('确认'),
///                   ),
///                 ],
///               ),
///             ],
///           ),
///         ),
///       ),
///     );
///   },
/// );
///
/// // 示例3: 加载提示对话框
/// // Example 3: Loading dialog
/// GlobalDialog.show(
///   context: context,
///   builder: (context) {
///     return Center(
///       child: Material(
///         color: Colors.transparent,
///         child: Container(
///           padding: EdgeInsets.all(32),
///           decoration: BoxDecoration(
///             color: Colors.white,
///             borderRadius: BorderRadius.circular(12),
///           ),
///           child: Column(
///             mainAxisSize: MainAxisSize.min,
///             children: [
///               CircularProgressIndicator(),
///               SizedBox(height: 16),
///               Text('加载中...'),
///             ],
///           ),
///         ),
///       ),
///     );
///   },
/// );
/// // 完成后手动关闭
/// // await someAsyncOperation();
/// // GlobalDialog.hide();
///
/// // 示例4: 错误提示对话框
/// // Example 4: Error dialog
/// GlobalDialog.show(
///   context: context,
///   duration: Duration(seconds: 4),
///   builder: (context) {
///     return Center(
///       child: Material(
///         color: Colors.transparent,
///         child: Container(
///           padding: EdgeInsets.all(20),
///           decoration: BoxDecoration(
///             color: Colors.red.shade50,
///             borderRadius: BorderRadius.circular(12),
///             border: Border.all(color: Colors.red, width: 2),
///           ),
///           child: Column(
///             mainAxisSize: MainAxisSize.min,
///             children: [
///               Icon(Icons.error, color: Colors.red, size: 48),
///               SizedBox(height: 16),
///               Text('操作失败', style: TextStyle(fontSize: 18, color: Colors.red)),
///               SizedBox(height: 8),
///               Text('请稍后重试', style: TextStyle(color: Colors.red.shade700)),
///             ],
///           ),
///         ),
///       ),
///     );
///   },
/// );
///
/// // 示例5: 重复调用时重置倒计时
/// // Example 5: Reset timer on repeated calls
/// // 第一次调用
/// GlobalDialog.show(
///   context: context,
///   duration: Duration(seconds: 5),
///   builder: (context) => Center(child: Text('消息1')),
/// );
/// 
/// // 2秒后再次调用,会重置倒计时为5秒,而不是创建新对话框
/// Future.delayed(Duration(seconds: 2), () {
///   GlobalDialog.show(
///     context: context,
///     duration: Duration(seconds: 5),
///     builder: (context) => Center(child: Text('消息2')),
///   );
/// });
/// ```
///
/// ⚠️ 注意事项 / Notes:
/// • 全局对话框使用单例模式,同一时间只能显示一个
/// • 重复调用show()会重置倒计时,不会创建多个对话框
/// • duration为null时不会自动关闭,需手动调用hide()
/// • 对话框显示在rootOverlay上,确保在所有内容之上
/// • 建议在builder中使用Material包裹内容以获得正确的样式
/// • 记得在不需要时调用hide()释放资源
/// • 适用于全局提示、加载状态、确认对话框等场景
///

class GlobalDialog {
  GlobalDialog._internal();

  static final GlobalDialog _instance = GlobalDialog._internal();

  static GlobalDialog get instance => _instance;

  OverlayEntry? _entry;
  Timer? _timer;

  /// 显示全局对话框 / Show global dialog
  /// 
  /// [context] 上下文 / Context (required)
  /// [builder] 对话框内容构建器 / Dialog content builder (required)
  /// [duration] 自动消失时间,为null时不自动消失 / Auto-dismiss duration, null means no auto-dismiss
  /// 
  /// 如果在弹框未消失前再次调用，会仅重置倒计时，不会重复创建弹框
  /// If called again before the dialog disappears, it will only reset the timer without creating a new dialog
  static void show({
    required BuildContext context,
    required WidgetBuilder builder,
    Duration? duration}) {
    _instance._show(context:context, builder: builder, duration: duration);
  }

  void _show({
    required BuildContext context,
    required WidgetBuilder builder,
    Duration? duration}) {
    // 首次创建 Overlay
    if (_entry == null) {
      _entry = OverlayEntry(
        builder: (context) => builder(context),
      );
      Overlay.of(context, rootOverlay: true).insert(_entry!);
    }

    // 无论是否已显示，都重置计时器
    if(duration!=null){
      _startTimer(duration);
    }
  }

  void _startTimer(Duration duration) {
    _timer?.cancel();
    _timer = Timer(duration, hide);
  }

  /// 主动关闭全局对话框 / Manually close global dialog
  static void hide() {
    _instance._hide();
  }


  void _hide() {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;
  }
}


