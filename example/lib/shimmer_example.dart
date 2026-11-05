import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ShimmerLoadingExample extends StatefulWidget {
  const ShimmerLoadingExample({super.key});

  @override
  State<ShimmerLoadingExample> createState() => _ShimmerLoadingExampleState();
}

class _ShimmerLoadingExampleState extends State<ShimmerLoadingExample> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShowcasePage(
      title: '微光加载',
      children: [
        ShowcaseSection(
          title: '加载控制',
          icon: Icons.tune,
          description: '切换骨架屏与真实内容，观察 Shimmer 过渡效果',
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    _loading ? Icons.hourglass_top : Icons.check_circle,
                    color: scheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _loading ? '骨架屏展示中' : '真实内容已加载',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _loading ? '所有示例区域显示占位骨架' : '关闭后展示完整业务内容',
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _loading,
                    onChanged: (value) => setState(() => _loading = value),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: () => setState(() => _loading = !_loading),
                  icon: Icon(_loading ? Icons.visibility : Icons.refresh),
                  label: Text(_loading ? '显示真实内容' : '重新展示骨架屏'),
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '列表骨架',
          icon: Icons.view_list_outlined,
          description: 'AutoShimmerList 垂直列表，适合消息、联系人等场景',
          child: AutoShimmerList(
            isLoading: _loading,
            direction: ShimmerListDirection.vertical,
            spacing: 10,
            children: List.generate(4, (index) => _listCard(context, index)),
          ),
        ),
        ShowcaseSection(
          title: '网格骨架',
          icon: Icons.grid_view_outlined,
          description: 'AutoShimmerList 网格模式，适合商品、卡片列表',
          child: AutoShimmerList(
            isLoading: _loading,
            direction: ShimmerListDirection.grid,
            crossAxisCount: 2,
            spacing: 12,
            children: List.generate(4, (index) => _gridCard(context, index)),
          ),
        ),
        ShowcaseSection(
          title: '自定义骨架',
          icon: Icons.auto_awesome_outlined,
          description: 'Shimmer + placeholderBuilder 自定义业务占位结构',
          child: Shimmer(
            isLoading: _loading,
            builder: (context) => _profileCard(context),
            placeholderBuilder: (context) => _profilePlaceholder(context),
          ),
        ),
      ],
    );
  }

  Widget _listCard(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: index.isEven
                    ? [scheme.primary, scheme.tertiary]
                    : [scheme.secondary, scheme.primary],
              ),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '组件设计稿 v${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '更新于 ${index + 1} 小时前',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: scheme.outline),
        ],
      ),
    );
  }

  Widget _gridCard(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 132,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            scheme.primaryContainer.withValues(alpha: 0.9),
            scheme.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.widgets_outlined, color: scheme.primary),
          ),
          const Spacer(),
          Text(
            '组件卡片 ${index + 1}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            '12 个组件 · 已更新',
            style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _profileCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [scheme.primary, scheme.tertiary],
              ),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'uikit_plus 组件库',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '30+ 组件 · 覆盖表单、数据展示、动效与导航',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profilePlaceholder(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 180,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 240,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}