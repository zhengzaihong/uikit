import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class SelectionMenuExample extends StatefulWidget {
  const SelectionMenuExample({super.key});

  @override
  State<SelectionMenuExample> createState() => _SelectionMenuExampleState();
}

class _SelectionMenuExampleState extends State<SelectionMenuExample> {
  static const _frameworks = ['Flutter', 'ArkTS', 'React Native', 'SwiftUI'];
  static const _groups = <String, List<String>>{
    '前端方向': ['Flutter', 'ArkTS', 'Web'],
    '后端方向': ['Java', 'Go', 'Python'],
    '数据方向': ['SQL', '数据分析', '机器学习'],
  };

  final SelectionMenuController _singleController = SelectionMenuController();
  final SelectionMenuController _multiController = SelectionMenuController();
  final SelectionMenuController _groupController = SelectionMenuController();
  final SelectionMenuController _compactController = SelectionMenuController();

  String? _single;
  final Set<String> _multi = {'Flutter', 'Go'};
  String? _group;
  String? _compact;

  @override
  void dispose() {
    _singleController.dispose();
    _multiController.dispose();
    _groupController.dispose();
    _compactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcasePage(
      title: '下拉菜单',
      children: [
        ShowcaseSection(
          title: '标准单选',
          icon: Icons.expand_circle_down_outlined,
          description: '白色气泡 + 选中勾选，适合常规表单选择',
          child: SelectionMenu(
            controller: _singleController,
            popWidth: 280,
            popHeight: 320,
            matchParentWidth: false,
            buttonBuilder: (show) => _trigger(
              context,
              show: show,
              label: _single ?? '选择技术方向',
              icon: Icons.widgets_outlined,
            ),
            selectorBuilder: (context) => _bubble(
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final item in _frameworks)
                      _option(
                        context,
                        text: item,
                        selected: _single == item,
                        onTap: () {
                          setState(() => _single = item);
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ShowcaseSection(
          title: '渐变气泡多选',
          icon: Icons.checklist_rtl,
          description: '渐变气泡 + 多选状态，完成后关闭弹层',
          child: SelectionMenu(
            controller: _multiController,
            popWidth: 300,
            popHeight: 350,
            matchParentWidth: false,
            buttonBuilder: (show) => _trigger(
              context,
              show: show,
              label: '已选择 ${_multi.length} 项',
              icon: Icons.tune,
              gradient: true,
            ),
            selectorBuilder: (context) => _bubble(
              gradient: true,
              child: StatefulBuilder(
                builder: (context, setPopupState) {
                  return Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final item in _frameworks)
                          CheckboxListTile(
                            dense: true,
                            value: _multi.contains(item),
                            activeColor: Colors.white,
                            checkColor: const Color(0xFF6558E8),
                            title: Text(
                              item,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onChanged: (checked) {
                              setPopupState(() {
                                if (checked == true) {
                                  _multi.add(item);
                                } else {
                                  _multi.remove(item);
                                }
                              });
                              setState(() {});
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                '完成',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        ShowcaseSection(
          title: '分组选择',
          icon: Icons.category_outlined,
          description: '分组标题 + 右对齐弹层，适合分类较多的场景',
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 240,
              child: SelectionMenu(
                controller: _groupController,
                popWidth: 300,
                popHeight: 400,
                alignType: AlignType.right,
                matchParentWidth: false,
                buttonBuilder: (show) => _trigger(
                  context,
                  show: show,
                  label: _group ?? '按分组选择',
                  icon: Icons.account_tree_outlined,
                ),
                selectorBuilder: (context) => _bubble(
                  child: SingleChildScrollView(
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final group in _groups.entries) ...[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                              child: Text(
                                group.key,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                            ),
                            for (final item in group.value)
                              _option(
                                context,
                                text: item,
                                selected: _group == item,
                                onTap: () {
                                  setState(() => _group = item);
                                  Navigator.of(context).pop();
                                },
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        ShowcaseSection(
          title: '自定义触发按钮',
          icon: Icons.bolt_outlined,
          description: '按钮完全由业务控制，可选择任意图标和文案',
          child: SelectionMenu(
            controller: _compactController,
            popWidth: 260,
            popHeight: 260,
            matchParentWidth: false,
            buttonBuilder: (show) => Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF0FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.auto_awesome,
                      color: Color(0xFF6558E8)),
                ),
                hGap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '推荐算法',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        _compact ?? '点击选择模型',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: show ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
            selectorBuilder: (context) => _bubble(
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final item in const ['精准推荐', '热门推荐', '附近推荐'])
                      _option(
                        context,
                        text: item,
                        selected: _compact == item,
                        onTap: () {
                          setState(() => _compact = item);
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _trigger(
    BuildContext context, {
    required bool show,
    required String label,
    required IconData icon,
    bool gradient = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: gradient ? null : scheme.surface,
        gradient: gradient
            ? const LinearGradient(
                colors: [Color(0xFF6558E8), Color(0xFF00A8E8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: gradient ? Colors.transparent : scheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: (gradient ? const Color(0xFF6558E8) : Colors.black)
                .withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: gradient ? Colors.white : scheme.primary),
          hGap(10),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: gradient ? Colors.white : scheme.onSurface,
              ),
            ),
          ),
          AnimatedRotation(
            turns: show ? 0.5 : 0,
            duration: const Duration(milliseconds: 180),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: gradient ? Colors.white : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble({required Widget child, bool gradient = false}) {
    return Bubble(
      direction: BubbleArrowDirection.top,
      radius: 16,
      arrowWidth: 18,
      arrowHeight: 10,
      arrowShape: BubbleArrowShape.rounded,
      decoration: BoxDecoration(
        color: gradient ? null : Colors.white,
        gradient: gradient
            ? const LinearGradient(
                colors: [Color(0xFF6558E8), Color(0xFF00A8E8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: gradient ? Colors.transparent : Colors.black12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _option(
    BuildContext context, {
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? scheme.primary : scheme.onSurface,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, size: 18, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}