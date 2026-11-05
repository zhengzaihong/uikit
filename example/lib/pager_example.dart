import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class PagerExample extends StatefulWidget {
  const PagerExample({super.key});

  @override
  State<PagerExample> createState() => _PagerExampleState();
}

class _PagerExampleState extends State<PagerExample> {
  static const int _totalCount = 1000;
  int _currentPage = 1;
  int _pageEach = 10;

  int get _totalPages => (_totalCount / _pageEach).ceil();

  void _onPageChanged(int totalPages, dynamic currentPage) {
    final page = currentPage is int
        ? currentPage
        : int.tryParse('$currentPage') ?? _currentPage;
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShowcasePage(
      title: '分页组件',
      children: [
        ShowcaseSection(
          title: '分页概览',
          icon: Icons.pages_outlined,
          description: '当前页码会同步到下方三种分页样式',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '第 $_currentPage 页',
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '/ 共 $_totalPages 页',
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                  const Spacer(),
                  Text(
                    '${_totalCount} 条数据',
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  for (final size in const [10, 20, 50])
                    ChoiceChip(
                      label: Text('$size 条/页'),
                      selected: _pageEach == size,
                      onSelected: (_) => setState(() {
                        _pageEach = size;
                        if (_currentPage > _totalPages) {
                          _currentPage = _totalPages;
                        }
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < 5; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 11),
                        decoration: BoxDecoration(
                          border: i == 4
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                    color: scheme.outlineVariant,
                                  ),
                                ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: scheme.primary.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${(_currentPage - 1) * _pageEach + i + 1}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '第 ${(_currentPage - 1) * _pageEach + i + 1} 条业务数据',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: scheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                i.isEven ? '已完成' : '进行中',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: scheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: '基础分页',
          icon: Icons.numbers,
          description: '仅展示页码与前后翻页，适合内容较少的列表',
          child: _pagerBox(
            context,
            Pager(
              totalCount: _totalCount,
              pageEach: _pageEach,
              currentPage: _currentPage,
              pagerInputType: PagerInputType.none,
              showEllipsis: true,
              sideDiff: 1,
              pageIndicatorHeight: 34,
              pageTextSize: 14,
              pageIndicatorActiveColor: scheme.primary,
              pageIndicatorColor: scheme.onSurfaceVariant,
              checkedPageColor: scheme.onPrimary,
              borderRadius: 9,
              onPageChanged: _onPageChanged,
            ),
          ),
        ),
        ShowcaseSection(
          title: '完整分页',
          icon: Icons.input,
          description: '页码跳转、总数展示与输入校验',
          child: _pagerBox(
            context,
            Pager(
              totalCount: _totalCount,
              pageEach: _pageEach,
              currentPage: _currentPage,
              pagerInputType: PagerInputType.input,
              showEllipsis: true,
              sideDiff: 1,
              totalText: '共%s条',
              prevText: '前往',
              suffixText: '页',
              inputHintText: '页码',
              pageIndicatorHeight: 36,
              pageTextSize: 14,
              pageIndicatorActiveColor: scheme.primary,
              pageIndicatorColor: scheme.onSurfaceVariant,
              checkedPageColor: scheme.onPrimary,
              inputBgColor: scheme.surfaceContainerHighest,
              borderRadius: 9,
              focusBorder: Border.all(color: scheme.primary),
              outlineInputTextBorder: OutlineInputTextBorder(
                borderSide: BorderSide(color: scheme.outline),
                childBorderRadius: BorderRadius.circular(8),
              ),
              inputContentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              errorInputCallback: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('请输入正确的页码')),
                  );
              },
              onPageChanged: _onPageChanged,
            ),
          ),
        ),
        ShowcaseSection(
          title: '主题分页',
          icon: Icons.palette_outlined,
          description: '使用 PagerTheme 快速应用预设主题',
          child: _pagerBox(
            context,
            Pager(
              totalCount: _totalCount,
              pageEach: _pageEach,
              currentPage: _currentPage,
              theme: PagerTheme.blueTheme,
              showEllipsis: true,
              sideDiff: 1,
              onPageChanged: _onPageChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _pagerBox(BuildContext context, Widget pager) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(width: 620, height: 44, child: pager),
      ),
    );
  }
}