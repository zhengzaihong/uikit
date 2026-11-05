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
      name: '前端',
      children: [
        MultiSelectorEntity(id: 'flutter', name: 'Flutter'),
        MultiSelectorEntity(id: 'arkts', name: 'ArkTS'),
        MultiSelectorEntity(id: 'web', name: 'Web'),
      ],
    ),
    MultiSelectorEntity(
      id: 'backend',
      name: '后端',
      children: [
        MultiSelectorEntity(id: 'java', name: 'Java'),
        MultiSelectorEntity(id: 'go', name: 'Go'),
        MultiSelectorEntity(id: 'python', name: 'Python'),
      ],
    ),
  ];

  final List<String> _tags = ['全部', '科技', '体育', '电影', '时尚', '美食'];
  Set<String> _multiSelected = {};
  List<int> _tagSelected = [0, 2];
  int _singleSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ShowcasePage(
      title: '选择与拖拽',
      children: [
        ShowcaseSection(
          title: 'MultiSelector 无限层级多选',
          description: '支持手风琴展开、默认选中与选中结果回调',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MultiSelector(
                data: _menuData,
                accordionKey: 'showcase-menu',
                defaultSelected: const ['flutter', 'go'],
                onSelectionChanged: (list) => setState(() {
                  _multiSelected =
                      list.map((item) => item.name ?? '').toSet();
                }),
                buildItems: (node, level, isExpanded, hasChildren) {
                  return Row(
                    children: [
                      Icon(
                        hasChildren
                            ? (isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more)
                            : Icons.circle_outlined,
                        size: 18,
                        color: Colors.blue,
                      ),
                      hGap(6),
                      Text(node.name ?? ''),
                    ],
                  );
                },
              ),
              vGap(12),
              Text(
                _multiSelected.isEmpty
                    ? '尚未选择'
                    : '已选择：${_multiSelected.join('、')}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'SelectableGroup 标签多选',
          description: 'Wrap 布局、支持默认选中与外部 controller',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableGroup(
                itemCount: _tags.length,
                multiple: true,
                layout: SelectableLayout.wrap,
                spacing: 8,
                runSpacing: 8,
                defaultValue: _tagSelected,
                onSelectionChanged: (selected) =>
                    setState(() => _tagSelected = selected),
                itemBuilder: (context, index, isSelected) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _tags[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
              vGap(12),
              Text(
                '已选择：${_tagSelected.map((i) => _tags[i]).join('、')}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'SelectableGroup 单选',
          description: 'multiple 为 false 时的互斥选择',
          child: SelectableGroup(
            itemCount: _tags.length,
            layout: SelectableLayout.wrap,
            spacing: 8,
            runSpacing: 8,
            defaultValue: [_singleSelected],
            onSelectionChanged: (selected) => setState(() {
              if (selected.isNotEmpty) _singleSelected = selected.first;
            }),
            itemBuilder: (context, index, isSelected) {
              return ChoiceChip(
                label: Text(_tags[index]),
                selected: isSelected,
                onSelected: (_) {},
              );
            },
          ),
        ),
        ShowcaseSection(
          title: 'DragBox 自由拖拽',
          description: '拖动范围自动限制在父容器内',
          child: SizedBox(
            height: 220,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '按住蓝色按钮拖动',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
                DragBox(
                  startOffset: const Offset(24, 24),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.drag_indicator, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}