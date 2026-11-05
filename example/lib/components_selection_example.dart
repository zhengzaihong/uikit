import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ComponentsSelectionExample extends StatefulWidget {
  const ComponentsSelectionExample({super.key});

  @override
  State<ComponentsSelectionExample> createState() =>
      _ComponentsSelectionExampleState();
}

class _ComponentsSelectionExampleState
    extends State<ComponentsSelectionExample> {
  final List<MultiSelectorEntity> _menuData = [
    MultiSelectorEntity(
      id: 'frontend',
      name: '前端开发',
      children: [
        MultiSelectorEntity(
          id: 'flutter',
          name: 'Flutter',
          children: [
            MultiSelectorEntity(id: 'state', name: '状态管理'),
            MultiSelectorEntity(id: 'anim', name: '动画与手势'),
            MultiSelectorEntity(id: 'webview', name: 'WebView 混合开发'),
          ],
        ),
        MultiSelectorEntity(
          id: 'arkts',
          name: 'ArkTS',
          children: [
            MultiSelectorEntity(id: 'arkui', name: 'ArkUI 声明式'),
            MultiSelectorEntity(id: 'distributed', name: '分布式能力'),
          ],
        ),
      ],
    ),
    MultiSelectorEntity(
      id: 'backend',
      name: '后端开发',
      children: [
        MultiSelectorEntity(
          id: 'java',
          name: 'Java',
          children: [
            MultiSelectorEntity(id: 'spring', name: 'Spring Boot'),
            MultiSelectorEntity(id: 'mybatis', name: 'MyBatis'),
          ],
        ),
        MultiSelectorEntity(
          id: 'go',
          name: 'Go',
          children: [
            MultiSelectorEntity(id: 'gin', name: 'Gin'),
            MultiSelectorEntity(id: 'gorm', name: 'GORM'),
          ],
        ),
      ],
    ),
  ];

  final MultiSelectorController _menuController = MultiSelectorController();
  final SelectableController _multiTagController = SelectableController();
  final SelectableController _singleTagController = SelectableController();

  final List<String> _tags = ['全部', '科技', '体育', '电影', '时尚', '美食'];
  List<MultiSelectorEntity> _selectedEntities = const [];
  List<int> _tagSelected = [0, 2];
  int _singleSelected = 0;
  late final List<MultiSelectorEntity> _leafNodes;

  @override
  void initState() {
    super.initState();
    _leafNodes = _flatten(_menuData);
  }

  @override
  void dispose() {
    _menuController.dispose();
    _multiTagController.dispose();
    _singleTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShowcasePage(
      title: '选择与拖拽',
      children: [
        ShowcaseSection(
          title: 'MultiSelector 无限层级多选',
          icon: Icons.account_tree_outlined,
          description: '三级树形结构、叶子多选、全选/清空与已选标签',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '已选 ${_selectedEntities.length} 项',
                      style: TextStyle(
                        color: scheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _selectAll,
                    icon: const Icon(Icons.done_all, size: 16),
                    label: const Text('全选'),
                  ),
                  TextButton.icon(
                    onPressed: _clearAll,
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('清空'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 360,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: MultiSelector(
                  controller: _menuController,
                  data: _menuData,
                  accordionKey: 'showcase-menu',
                  defaultSelected: const ['state', 'arkui', 'gin'],
                  onSelectionChanged: (list) {
                    if (!mounted) return;
                    setState(() => _selectedEntities = list);
                  },
                  buildItems: (node, level, isExpanded, hasChildren) {
                    return _buildMenuNode(
                      context,
                      node,
                      isExpanded,
                      hasChildren,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              if (_selectedEntities.isEmpty)
                Text(
                  '尚未选择任何子项',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final entity in _selectedEntities)
                      InputChip(
                        label: Text(entity.name ?? ''),
                        avatar: Icon(
                          Icons.check,
                          size: 16,
                          color: scheme.primary,
                        ),
                        onDeleted: () => _menuController.setItemSelection(
                          entity,
                          false,
                        ),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        backgroundColor: scheme.primaryContainer,
                        side: BorderSide.none,
                      ),
                  ],
                ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'SelectableGroup 标签多选',
          icon: Icons.sell_outlined,
          description: 'Wrap 布局、默认选中与外部 controller 控制',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableGroup(
                itemCount: _tags.length,
                multiple: true,
                layout: SelectableLayout.wrap,
                spacing: 8,
                runSpacing: 8,
                controller: _multiTagController,
                defaultValue: _tagSelected,
                onSelectionChanged: (selected) =>
                    setState(() => _tagSelected = selected),
                itemBuilder: (context, index, isSelected) {
                  return GestureDetector(
                    onTap: () => _multiTagController.onTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? scheme.primary
                            : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isSelected
                              ? scheme.primary
                              : scheme.outlineVariant,
                        ),
                      ),
                      child: Text(
                        _tags[index],
                        style: TextStyle(
                          color: isSelected
                              ? scheme.onPrimary
                              : scheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
              vGap(12),
              Text(
                '已选择：${_tagSelected.map((i) => _tags[i]).join('、')}',
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'SelectableGroup 单选',
          icon: Icons.radio_button_checked,
          description: 'multiple 为 false 时的互斥选择',
          child: SelectableGroup(
            itemCount: _tags.length,
            layout: SelectableLayout.wrap,
            spacing: 8,
            runSpacing: 8,
            controller: _singleTagController,
            defaultValue: [_singleSelected],
            onSelectionChanged: (selected) {
              if (selected.isEmpty) return;
              setState(() => _singleSelected = selected.first);
            },
            itemBuilder: (context, index, isSelected) {
              return ChoiceChip(
                label: Text(_tags[index]),
                selected: isSelected,
                onSelected: (_) => _singleTagController.onTap(index),
                selectedColor: scheme.primaryContainer,
            );
            },
          ),
        ),
        ShowcaseSection(
          title: 'DragBox 自由拖拽',
          icon: Icons.open_with,
          description: '拖动范围自动限制在父容器内',
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '按住蓝色按钮拖动',
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
                DragBox(
                  startOffset: const Offset(24, 24),
                  child: Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6558E8), Color(0xFF00A8E8)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6558E8)
                              .withValues(alpha: 0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.drag_indicator,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuNode(
    BuildContext context,
    MultiSelectorEntity node,
    bool isExpanded,
    bool hasChildren,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final childCount = node.children?.length ?? 0;
    final selectedChildren =
        node.children?.where((child) => child.isSelected).length ?? 0;
    final isLeaf = !hasChildren;
    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: node.isSelected
            ? scheme.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isLeaf
                  ? scheme.secondaryContainer
                  : scheme.primaryContainer,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              hasChildren
                  ? (isExpanded ? Icons.folder_open : Icons.folder)
                  : Icons.description_outlined,
              size: 17,
              color: isLeaf ? scheme.secondary : scheme.primary,
            ),
          ),
          hGap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  node.name ?? '',
                  style: TextStyle(
                    fontWeight:
                        hasChildren ? FontWeight.w600 : FontWeight.w400,
                    color: node.isSelected ? scheme.primary : scheme.onSurface,
                  ),
                ),
                if (hasChildren)
                  Text(
                    selectedChildren > 0
                        ? '$selectedChildren/$childCount 个子项已选'
                        : '$childCount 个子项',
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          if (hasChildren)
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              size: 18,
              color: scheme.onSurfaceVariant,
            )
          else
            Icon(
              node.isSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              size: 20,
              color: node.isSelected ? scheme.primary : scheme.outline,
            ),
        ],
      ),
    );

    if (isLeaf) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            _menuController.setItemSelection(node, !node.isSelected),
        child: content,
      );
    }
    return content;
  }

  void _selectAll() {
    for (final leaf in _leafNodes) {
      _menuController.setItemSelection(leaf, true);
    }
  }

  void _clearAll() {
    for (final leaf in _leafNodes) {
      _menuController.setItemSelection(leaf, false);
    }
  }

  List<MultiSelectorEntity> _flatten(List<MultiSelectorEntity> nodes) {
    final result = <MultiSelectorEntity>[];
    for (final node in nodes) {
      final children = node.children;
      if (children == null || children.isEmpty) {
        result.add(node);
      } else {
        result.addAll(_flatten(children));
      }
    }
    return result;
  }
}