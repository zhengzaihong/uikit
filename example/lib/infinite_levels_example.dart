import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class InfiniteLevelsExample extends StatefulWidget {
  const InfiniteLevelsExample({super.key});

  @override
  State<InfiniteLevelsExample> createState() => _InfiniteLevelsExampleState();
}

class _InfiniteLevelsExampleState extends State<InfiniteLevelsExample> {
  static final List<InfiniteMenu> _menus = [
    CustomMenu(
      title: '产品中心',
      obj: const _MenuMeta('业务产品与解决方案', Icons.apps_outlined),
      children: [
        CustomMenu(
          title: '移动应用',
          obj: const _MenuMeta('面向手机与平板的客户端', Icons.phone_iphone),
          children: [
            CustomMenu(
              title: 'Flutter 客户端',
              obj: const _MenuMeta('跨平台业务应用', Icons.flutter_dash),
              children: [
                CustomMenu(
                  title: '状态管理',
                  obj: const _MenuMeta('页面状态与数据流', Icons.account_tree_outlined),
                  children: [
                    CustomMenu(
                      title: '异步数据加载',
                      obj: const _MenuMeta('接口请求与缓存策略', Icons.cloud_download_outlined),
                    ),
                    CustomMenu(
                      title: '本地持久化',
                      obj: const _MenuMeta('缓存、偏好与数据库', Icons.storage_outlined),
                    ),
                  ],
                ),
                CustomMenu(
                  title: '动画与交互',
                  obj: const _MenuMeta('转场、手势与微动效', Icons.animation),
                ),
              ],
            ),
            CustomMenu(
              title: 'ArkTS 客户端',
              obj: const _MenuMeta('HarmonyOS 原生应用', Icons.devices_other),
              children: [
                CustomMenu(
                  title: 'ArkUI 声明式',
                  obj: const _MenuMeta('声明式 UI 与状态驱动', Icons.widgets_outlined),
                ),
                CustomMenu(
                  title: '分布式能力',
                  obj: const _MenuMeta('跨设备协同与流转', Icons.share_outlined),
                ),
              ],
            ),
          ],
        ),
        CustomMenu(
          title: 'Web 控制台',
          obj: const _MenuMeta('运营与数据管理后台', Icons.web_outlined),
          children: [
            CustomMenu(
              title: '管理后台',
              obj: const _MenuMeta('权限、配置与内容管理', Icons.dashboard_outlined),
            ),
            CustomMenu(
              title: '数据大屏',
              obj: const _MenuMeta('实时指标与可视化', Icons.insert_chart_outlined),
            ),
          ],
        ),
      ],
    ),
    CustomMenu(
      title: '技术文档',
      obj: const _MenuMeta('开发、接入与发布指南', Icons.menu_book_outlined),
      children: [
        CustomMenu(
          title: '组件库',
          obj: const _MenuMeta('uikit_plus 使用手册', Icons.widgets),
          children: [
            CustomMenu(
              title: '基础组件',
              obj: const _MenuMeta('按钮、开关与输入框', Icons.tune),
            ),
            CustomMenu(
              title: '数据展示',
              obj: const _MenuMeta('表格、分页与图表', Icons.table_chart_outlined),
            ),
          ],
        ),
        CustomMenu(
          title: '开发指南',
          obj: const _MenuMeta('环境、调试与发布', Icons.code),
          children: [
            CustomMenu(
              title: '环境搭建',
              obj: const _MenuMeta('Flutter 与鸿蒙环境', Icons.terminal),
            ),
            CustomMenu(
              title: '发布流程',
              obj: const _MenuMeta('版本、变更与上架', Icons.rocket_launch_outlined),
            ),
          ],
        ),
      ],
    ),
    CustomMenu(
      title: '设计资源',
      obj: const _MenuMeta('视觉规范与素材', Icons.palette_outlined),
      children: [
        CustomMenu(
          title: '设计规范',
          obj: const _MenuMeta('色彩、字体与间距', Icons.format_paint_outlined),
        ),
        CustomMenu(
          title: '图标库',
          obj: const _MenuMeta('通用图标与业务图标', Icons.interests_outlined),
        ),
      ],
    ),
  ];

  late final InfiniteMenu _initialSelected;
  late InfiniteMenu _selected;
  final InfiniteLevelsMenusController _controller =
      InfiniteLevelsMenusController();
  bool _expandAll = false;

  @override
  void initState() {
    super.initState();
    _initialSelected = _menus.first.children!.first.children!.first;
    _selected = _initialSelected;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showcaseAppBar(
        context,
        '无限层级菜单',
        actions: [
          IconButton(
            tooltip: _expandAll ? '收起全部' : '展开全部',
            onPressed: () => setState(() => _expandAll = !_expandAll),
            icon: Icon(
              _expandAll ? Icons.unfold_less : Icons.unfold_more,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 760) {
            return Column(
              children: [
                SizedBox(height: 360, child: _buildMenuPanel(context)),
                Expanded(child: _buildDetailPanel(context)),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 340, child: _buildMenuPanel(context)),
              Expanded(child: _buildDetailPanel(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
            child: Row(
              children: [
                Icon(Icons.account_tree_outlined, color: scheme.primary),
                const SizedBox(width: 8),
                const Text(
                  '菜单目录',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_countNodes(_menus)} 个节点',
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: InfiniteLevelsMenus(
                key: ValueKey(_expandAll),
                controller: _controller,
                datas: _menus,
                allExpand: _expandAll,
                defaultExpand: _expandAll ? _initialSelected : null,
                titleChildSpace: 12,
                buildComplete: (item) {
                  if (item != null && mounted) {
                    setState(() => _selected = item);
                  }
                },
                buildMenuItem: (isCurrent, data, level) {
                  return _buildMenuTile(context, data, level, isCurrent);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context,
    InfiniteMenu data,
    int level,
    bool isCurrent,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final meta = data.obj is _MenuMeta ? data.obj as _MenuMeta : null;
    final hasChildren = data.children?.isNotEmpty ?? false;
    final selected = isCurrent || identical(data, _selected);

    return Material(
      color: selected ? scheme.primaryContainer : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() => _selected = data);
          _controller.setItem(data);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: selected
                      ? scheme.primary.withValues(alpha: 0.14)
                      : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  meta?.icon ??
                      (hasChildren
                          ? Icons.folder_outlined
                          : Icons.article_outlined),
                  size: 17,
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: level <= 2 ? 14 : 13,
                        fontWeight:
                            hasChildren ? FontWeight.w600 : FontWeight.w400,
                        color: selected ? scheme.primary : scheme.onSurface,
                      ),
                    ),
                    if (meta != null)
                      Text(
                        meta.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.5,
                          color: selected
                              ? scheme.primary.withValues(alpha: 0.72)
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (hasChildren)
                Icon(
                  data.isChecked ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                )
              else if (selected)
                Icon(Icons.check_circle, size: 17, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final meta = _selected.obj is _MenuMeta ? _selected.obj as _MenuMeta : null;
    final path = _pathTo(_selected, _menus);
    final children = _selected.children ?? const <InfiniteMenu>[];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [scheme.primary, scheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    meta?.icon ?? Icons.article_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selected.title ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meta?.subtitle ?? '无限层级菜单节点',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  context,
                  '层级',
                  '${path.length}',
                  Icons.layers_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  context,
                  '子节点',
                  '${children.length}',
                  Icons.account_tree_outlined,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  context,
                  '节点类型',
                  children.isEmpty ? '叶子' : '目录',
                  Icons.category_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            '层级路径',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (var i = 0; i < path.length; i++) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: i == path.length - 1
                        ? scheme.primaryContainer
                        : scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    path[i].title ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: i == path.length - 1
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                      fontWeight: i == path.length - 1
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (i != path.length - 1)
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: scheme.outline,
                  ),
              ],
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            '节点数据预览',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: SelectableText(
              JsonEncoder.withIndent('  ').convert(_previewMap(_selected)),
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: scheme.primary),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _previewMap(InfiniteMenu node) {
    final meta = node.obj is _MenuMeta ? node.obj as _MenuMeta : null;
    return {
      'title': node.title,
      'isChecked': node.isChecked,
      'childrenCount': node.children?.length ?? 0,
      if (meta != null) 'meta': {'subtitle': meta.subtitle},
    };
  }

  int _countNodes(List<InfiniteMenu> nodes) {
    var count = 0;
    for (final node in nodes) {
      count++;
      final children = node.children;
      if (children != null && children.isNotEmpty) {
        count += _countNodes(children);
      }
    }
    return count;
  }

  List<InfiniteMenu> _pathTo(
    InfiniteMenu target,
    List<InfiniteMenu> nodes, [
    List<InfiniteMenu> path = const [],
  ]) {
    for (final node in nodes) {
      final current = <InfiniteMenu>[...path, node];
      if (identical(node, target)) return current;
      final children = node.children;
      if (children != null && children.isNotEmpty) {
        final found = _pathTo(target, children, current);
        if (found.isNotEmpty) return found;
      }
    }
    return const [];
  }
}

class _MenuMeta {
  final String subtitle;
  final IconData icon;

  const _MenuMeta(this.subtitle, this.icon);
}

class CustomMenu extends InfiniteMenu {
  CustomMenu({
    dynamic obj,
    String? title,
    List<InfiniteMenu>? children,
    bool isChecked = false,
  }) : super(
          obj: obj,
          title: title,
          children: children,
          isChecked: isChecked,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'obj': obj,
      'title': title,
      'children': children?.map((e) => e.toMap()).toList(),
      'isChecked': isChecked,
    };
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    obj = map['obj'];
    title = map['title'];
    children = (map['children'] as List?)
        ?.map((e) => CustomMenu()..fromMap(e))
        .toList();
    isChecked = map['isChecked'];
  }
}