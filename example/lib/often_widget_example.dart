import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class OftenWidgetExample extends StatefulWidget {
  const OftenWidgetExample({super.key});

  @override
  State<OftenWidgetExample> createState() => _OftenWidgetExampleState();
}

class _OftenWidgetExampleState extends State<OftenWidgetExample> {
  static const _notices = [
    'uikit_plus 0.4.4 示例已更新，欢迎体验新组件',
    '新增下拉菜单气泡样式与多选树交互',
    '常用小组件页面完成视觉升级',
    '移动端与桌面端均支持自适应布局',
  ];

  static const _tabs = ['推荐', '关注', '热榜', '附近'];

  final ZToolTipController _tooltipController = ZToolTipController();
  final TimeViewController _timeController = TimeViewController();

  bool _switchValue = true;
  bool _imageSwitchValue = true;
  bool? _checkValue = true;
  double _rating = 3.5;
  int _selectedTab = 0;
  int _floatIndex = -1;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShowcasePage(
      title: '常用小组件',
      children: [
        ShowcaseSection(
          title: '跑马灯 MarqueeView',
          icon: Icons.campaign_outlined,
          description: '垂直滚动通知与水平滚动公告，支持暂停/恢复',
          child: Column(
            children: [
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF00A8E8)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2D3436),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(14),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.notifications_active,
                          color: Colors.white, size: 20),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: MarqueeView(
                          direction: MarqueeDirection.vertical,
                          itemExtent: 52,
                          interval: const Duration(seconds: 2),
                          animateDuration: const Duration(milliseconds: 400),
                          marqueeItems: _notices,
                          buildItem: (context, data) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.chevron_right,
                          color: Colors.white70, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.campaign_outlined,
                        color: scheme.primary, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: MarqueeView(
                        direction: MarqueeDirection.horizontal,
                        itemExtent: 42,
                        interval: const Duration(seconds: 2),
                        animateDuration: const Duration(milliseconds: 800),
                        marqueeItems: const [
                          '这是一条水平滚动的公告：更多组件用法请查看 example 源码。',
                        ],
                        buildItem: (context, data) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: scheme.onSurface,
                                fontSize: 13,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '堆叠卡片 StackCard',
          icon: Icons.layers_outlined,
          description: '左右滑动切换卡片，松开后自动回弹',
          child: Center(
            child: StackCard(
              width: 230,
              height: 160,
              slideType: SlideType.horizontal,
              orientation: CardOrientation.bottom,
              cardSelected: (right, index) {
                _notify(context, '${right ? '右滑' : '左滑'} · 第 ${index + 1} 张');
              },
              children: List.generate(6, (index) {
                final gradient = index.isEven
                    ? const [Color(0xFF6C5CE7), Color(0xFF00A8E8)]
                    : const [Color(0xFF00B894), Color(0xFF00CEC9)];
                return Container(
                  width: 230,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -12,
                        top: -12,
                        child: Icon(
                          Icons.layers,
                          size: 110,
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.auto_awesome,
                                color: Colors.white, size: 24),
                            const Spacer(),
                            Text(
                              '卡片 ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '左右滑动切换 · StackCard',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        ShowcaseSection(
          title: '气泡与提示',
          icon: Icons.chat_bubble_outline,
          description: 'Bubble 气泡菜单与 ZTooltip 自定义提示',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bubble(
                direction: BubbleArrowDirection.top,
                radius: 16,
                arrowWidth: 18,
                arrowHeight: 10,
                arrowShape: BubbleArrowShape.rounded,
                arrowPositionPercent: 0.16,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: scheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final item in const [
                        (Icons.check_circle_outline, '待办事项', '3 项待处理'),
                        (Icons.forum_outlined, '消息中心', '2 条未读消息'),
                        (Icons.tune, '偏好设置', '管理展示选项'),
                      ])
                        InkWell(
                          onTap: () => _notify(context, '点击了 ${item.$2}'),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 11),
                            child: Row(
                              children: [
                                Icon(item.$1,
                                    size: 20, color: scheme.primary),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.$2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        item.$3,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: scheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    size: 18, color: scheme.outline),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: ZTooltip(
                  controller: _tooltipController,
                  direction: BubbleArrowDirection.top,
                  arrowShape: BubbleArrowShape.rounded,
                  arrowPositionPercent: 0.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2430),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.20),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 300),
                  buildTip: () => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final action in const ['翻译', '查询', '下载'])
                          TextButton(
                            onPressed: () {
                              _notify(context, 'Tooltip：$action');
                              _tooltipController.close();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              minimumSize: Size.zero,
                            ),
                            child: Text(action,
                                style: const TextStyle(fontSize: 13)),
                          ),
                      ],
                    ),
                  ),
                  child: TextExtend(
                    text: '自定义 Tooltip',
                    onTap: () => _tooltipController.toggle(),
                    isSelectable: false,
                    mainAxisSize: MainAxisSize.min,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 9),
                    onHoverPadding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 9),
                    borderRadius: BorderRadius.circular(22),
                    prefix: const Icon(Icons.touch_app, size: 18),
                    suffix: const Icon(Icons.expand_more, size: 18),
                    onHoverPrefix:
                        const Icon(Icons.touch_app, size: 18, color: Colors.white),
                    onHoverSuffix:
                        const Icon(Icons.expand_less, size: 18, color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: scheme.primary),
                    ),
                    onHoverDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: scheme.primary,
                    ),
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    onHoverStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '进度与评分',
          icon: Icons.donut_large_outlined,
          description: '环形/线性进度条与可交互星级评分',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CycleProgressBar(
                    radius: 46,
                    lineWidth: 9,
                    percent: 0.72,
                    animation: true,
                    animationDuration: 1000,
                    progressColor: scheme.primary,
                    backgroundColor: scheme.primary.withValues(alpha: 0.10),
                    center: const Text(
                      '72%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  CycleProgressBar(
                    radius: 46,
                    lineWidth: 9,
                    percent: 0.38,
                    animation: true,
                    animationDuration: 1200,
                    progressColor: scheme.tertiary,
                    backgroundColor: scheme.tertiary.withValues(alpha: 0.10),
                    center: const Icon(Icons.bolt, color: Colors.amber, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LinearProgressBar(
                width: 260,
                lineHeight: 14,
                percent: 0.86,
                animation: true,
                animationDuration: 800,
                barRadius: const Radius.circular(7),
                progressColor: scheme.primary,
                backgroundColor: scheme.primary.withValues(alpha: 0.10),
                leading: const Text('完成度'),
                trailing: Text('86%', style: TextStyle(color: scheme.primary)),
              ),
              const SizedBox(height: 20),
              RatingBar(
                value: _rating,
                count: 5,
                maxRating: 5,
                size: 34,
                step: 0.5,
                selectAble: true,
                normalImage:
                    const Icon(Icons.star_border, color: Colors.amber),
                selectImage: const Icon(Icons.star, color: Colors.amber),
                onChanged: (value) {
                  setState(() => _rating = value);
                  _notify(context, '评分：${value.toStringAsFixed(1)}');
                },
              ),
              const SizedBox(height: 6),
              Text(
                '当前评分：${_rating.toStringAsFixed(1)} / 5.0',
                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '开关与复选框',
          icon: Icons.toggle_on_outlined,
          description: 'KitSwitch、ImageSwitch 与 KitCheckBox 的常用形态',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        KitSwitch(
                          isOpen: _switchValue,
                          label: const Text('通知开关'),
                          activeTrackColor: scheme.primary,
                          onChanged: (value) =>
                              setState(() => _switchValue = value),
                        ),
                        const SizedBox(height: 14),
                        const Text('KitSwitch',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ImageSwitch(
                          value: _imageSwitchValue,
                          width: 70,
                          height: 32,
                          radius: 16,
                          activeTrackColor: scheme.primary,
                          inactiveTrackColor: scheme.surfaceContainerHighest,
                          activeImage: const Icon(Icons.dark_mode,
                              size: 18, color: Colors.white),
                          inactiveImage: const Icon(Icons.light_mode,
                              size: 18, color: Colors.amber),
                          onChanged: (value) =>
                              setState(() => _imageSwitchValue = value),
                        ),
                        const SizedBox(height: 14),
                        const Text('ImageSwitch',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(height: 1, color: scheme.outlineVariant),
              const SizedBox(height: 8),
              KitCheckBox(
                isChecked: _checkValue,
                text: const Text('下次自动登录'),
                checkedText: const Text('已开启自动登录'),
                onChanged: (value) => setState(() => _checkValue = value),
              ),
              const SizedBox(height: 8),
              const KitCheckBox(
                tristate: true,
                text: Text('三态复选框（点击循环）'),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '旋转与浮动菜单',
          icon: Icons.rotate_right_outlined,
          description: 'RotatingView 持续旋转与 FloatExpendButton 展开菜单',
          child: SizedBox(
            height: 190,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RotatingView(
                          speed: const Duration(seconds: 2),
                          child: Container(
                            width: 78,
                            height: 78,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C5CE7), Color(0xFF00A8E8)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6C5CE7)
                                      .withValues(alpha: 0.30),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.refresh,
                                color: Colors.white, size: 34),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('RotatingView',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatExpendButton(
                          type: ButtonType.left,
                          fabHeight: 36,
                          tabSpace: 8,
                          iconSize: 16,
                          mainTabBeginColor: scheme.primary,
                          mainTabAfterColor: scheme.tertiary,
                          iconList: [
                            FloatButtonStyle(
                              tabColor: const Color(0xFF6C5CE7),
                              icon: const Icon(Icons.edit, size: 16),
                            ),
                            FloatButtonStyle(
                              tabColor: const Color(0xFF00B894),
                              icon: const Icon(Icons.share, size: 16),
                            ),
                            FloatButtonStyle(
                              tabColor: const Color(0xFFE84393),
                              icon: const Icon(Icons.delete, size: 16),
                            ),
                          ],
                          callback: (index) {
                            setState(() => _floatIndex = index);
                            _notify(context, '浮动菜单第 ${index + 1} 项');
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _floatIndex < 0 ? 'FloatExpendButton' : '已选第 ${_floatIndex + 1} 项',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ShowcaseSection(
          title: 'TextExtend 与仿 JS 菜单',
          icon: Icons.text_fields_outlined,
          description: '悬停样式、选中态与图标前后缀',
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    for (var i = 0; i < _tabs.length; i++)
                      Expanded(
                        child: TextExtend(
                          text: _tabs[i],
                          height: 40,
                          width: double.infinity,
                          onTap: () => setState(() => _selectedTab = i),
                          isSelectable: false,
                          alignment: Alignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          borderRadius: BorderRadius.circular(10),
                          decoration: BoxDecoration(
                            color: _selectedTab == i
                                ? scheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onHoverDecoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: _selectedTab == i
                                ? Colors.white
                                : scheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          onHoverStyle: TextStyle(
                            fontSize: 14,
                            color: _selectedTab == i
                                ? Colors.white
                                : scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextExtend(
                  text: '有动画的 TextExtend',
                  onTap: () => _notify(context, '点击了 TextExtend'),
                  animation: true,
                  isSelectable: false,
                  mainAxisSize: MainAxisSize.min,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  onHoverPadding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  borderRadius: BorderRadius.circular(24),
                  prefix: const Icon(Icons.access_alarm, size: 18),
                  suffix: const Icon(Icons.account_circle, size: 18),
                  onHoverPrefix:
                      Icon(Icons.access_alarm, size: 18, color: scheme.primary),
                  onHoverSuffix: Icon(Icons.account_circle,
                      size: 18, color: scheme.primary),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  onHoverDecoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: scheme.primary.withValues(alpha: 0.30),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  onHoverStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '鼠标右键菜单',
          icon: Icons.mouse_outlined,
          description: '桌面端右键、移动端长按触发',
          child: MousePopupButton<String>(
            child: _dashedAction(context, '右键或长按此处'),
            itemBuilder: (context) => const [
              PopupMenuItem<String>(
                value: 'view',
                child: Row(
                  children: [
                    Icon(Icons.visibility_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('查看'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'translate',
                child: Row(
                  children: [
                    Icon(Icons.translate, size: 18),
                    SizedBox(width: 8),
                    Text('翻译'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 8),
                    Text('删除', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) => _notify(context, '菜单选择：$value'),
          ),
        ),
        ShowcaseSection(
          title: '倒计时 TimeView',
          icon: Icons.timer_outlined,
          description: '常用于获取验证码、倒计时重试等场景',
          child: Center(
            child: TimeView(
              countdown: 10,
              controller: _timeController,
              duration: const Duration(seconds: 1),
              onComplete: (_) {
                if (mounted) setState(() {});
              },
              build: (context, time) {
                if (!_timeController.isStart()) {
                  return FilledButton.icon(
                    onPressed: () {
                      _timeController.startTimer();
                      _notify(context, '验证码已发送');
                    },
                    icon: const Icon(Icons.sms_outlined),
                    label: const Text('获取验证码'),
                  );
                }
                return FilledButton.tonalIcon(
                  onPressed: null,
                  icon: const Icon(Icons.hourglass_top),
                  label: Text('$time 秒后重新获取'),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _dashedAction(BuildContext context, String text) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: scheme.onSurfaceVariant),
      ),
    );
  }

  void _notify(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }
}