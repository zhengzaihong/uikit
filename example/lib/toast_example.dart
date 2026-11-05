import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ToastExample extends StatefulWidget {
  const ToastExample({super.key});

  @override
  State<ToastExample> createState() => _ToastExampleState();
}

class _ToastExampleState extends State<ToastExample> {
  int _queueCounter = 0;

  @override
  Widget build(BuildContext context) {
    return ShowcasePage(
      title: 'Toast 提示',
      children: [
        ShowcaseSection(
          title: '状态提示',
          icon: Icons.notification_important_outlined,
          description: '自定义深色卡片，区分成功、信息、警告与错误',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _action(
                '成功',
                Icons.check_circle,
                const Color(0xFF00B894),
                () => _show(
                  title: '操作成功',
                  subtitle: '数据已保存到本地',
                  icon: Icons.check_circle,
                  color: const Color(0xFF00B894),
                ),
              ),
              _action(
                '信息',
                Icons.info,
                const Color(0xFF00A8E8),
                () => _show(
                  title: '收到新消息',
                  subtitle: '来自组件示例',
                  icon: Icons.info,
                  color: const Color(0xFF00A8E8),
                ),
              ),
              _action(
                '警告',
                Icons.warning_amber_rounded,
                const Color(0xFFFFB020),
                () => _show(
                  title: '电量不足',
                  subtitle: '请及时充电',
                  icon: Icons.warning_amber_rounded,
                  color: const Color(0xFFFFB020),
                ),
              ),
              _action(
                '错误',
                Icons.error,
                const Color(0xFFE84393),
                () => _show(
                  title: '请求失败',
                  subtitle: '请检查网络后重试',
                  icon: Icons.error,
                  color: const Color(0xFFE84393),
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '位置与时长',
          icon: Icons.vertical_distribute,
          description: '支持顶部、居中、底部显示，并可单独设置时长',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _action(
                '顶部显示',
                Icons.vertical_align_top,
                const Color(0xFF6558E8),
                () => _show(
                  title: '顶部提示',
                  subtitle: '2 秒后自动消失',
                  icon: Icons.north,
                  color: const Color(0xFF6558E8),
                  position: ToastPosition.top,
                ),
              ),
              _action(
                '居中显示',
                Icons.center_focus_strong,
                const Color(0xFF6558E8),
                () => _show(
                  title: '居中提示',
                  subtitle: '适合重要状态反馈',
                  icon: Icons.adjust,
                  color: const Color(0xFF6558E8),
                  position: ToastPosition.center,
                ),
              ),
              _action(
                '底部显示',
                Icons.vertical_align_bottom,
                const Color(0xFF6558E8),
                () => _show(
                  title: '底部提示',
                  subtitle: '默认展示位置',
                  icon: Icons.south,
                  color: const Color(0xFF6558E8),
                  position: ToastPosition.bottom,
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '加载提示',
          icon: Icons.hourglass_bottom,
          description: '全屏遮罩 + 自定义加载卡片，可手动关闭',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _action(
                '显示加载',
                Icons.downloading,
                const Color(0xFF6558E8),
                () {
                  Toast.showLoading(
                    context: context,
                    barrierDismissible: true,
                    child: _loadingCard(),
                  );
                  Future.delayed(const Duration(seconds: 2), Toast.closeLoading);
                },
              ),
              _action(
                '立即关闭',
                Icons.close,
                const Color(0xFFE84393),
                Toast.closeLoading,
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '队列消息',
          icon: Icons.queue,
          description: '多条消息按顺序展示，适合连续状态反馈',
          child: _action(
            '发送一条队列消息',
            Icons.send,
            const Color(0xFF00A8E8),
            () {
              _queueCounter++;
              Toast.showQueueToast(
                '队列消息 #$_queueCounter',
                buildStyle: (context, task) => _toastCard(
                  icon: Icons.mark_chat_unread_outlined,
                  color: const Color(0xFF00A8E8),
                  title: task.msg,
                  subtitle: '队列序号 $_queueCounter',
                ),
              );
            },
          ),
        ),
        ShowcaseSection(
          title: '气泡定位提示',
          icon: Icons.chat_bubble_outline,
          description: '使用 Bubble 定位到按钮下方，适合新手引导',
          child: Builder(
            builder: (buttonContext) => Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                onPressed: () {
                  final box =
                      buttonContext.findRenderObject() as RenderBox?;
                  if (box == null) return;
                  final offset = box.localToGlobal(Offset.zero);
                  Toast.showCustomPoint(
                    context: context,
                    showTime: 2500,
                    buildToastPoint: (context, style) => Positioned(
                      left: offset.dx,
                      top: offset.dy + box.size.height + 10,
                      child: Material(
                        color: Colors.transparent,
                        child: Bubble(
                          direction: BubbleArrowDirection.top,
                          radius: 12,
                          arrowWidth: 14,
                          arrowHeight: 8,
                          arrowShape: BubbleArrowShape.rounded,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              '这是气泡定位提示',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.touch_app),
                label: const Text('点击查看气泡提示'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _show({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    ToastPosition position = ToastPosition.bottom,
  }) {
    Toast.show(
      title,
      context: context,
      position: position,
      showTime: 2200,
      buildToastStyle: (context, msg) => _toastCard(
        icon: icon,
        color: color,
        title: msg,
        subtitle: subtitle,
      ),
    );
  }

  Widget _action(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color.withValues(alpha: 0.12),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _toastCard({
    required IconData icon,
    required Color color,
    required String title,
    String? subtitle,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 340),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2430).withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.24),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            hGap(12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xFF6558E8),
              ),
            ),
            SizedBox(height: 14),
            Text(
              '加载中...',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}