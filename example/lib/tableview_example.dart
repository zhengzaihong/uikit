import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class TableViewExample extends StatefulWidget {
  const TableViewExample({super.key});

  @override
  State<TableViewExample> createState() => _TableViewExampleState();
}

class _TableViewExampleState extends State<TableViewExample> {
  final List<TestBean> _list = List.generate(
    60,
    (index) => TestBean(
      name: '用户 ${index + 1}',
      age: '${20 + index % 30}',
      phone: '138${(1000 + index).toString().padLeft(7, '0')}',
      address: index % 3 == 0
          ? '广东省深圳市南山区科技园 ${index + 1} 号'
          : '北京市朝阳区望京街道 ${index + 1} 号',
      birth: '199${index % 10}-0${index % 9 + 1}-1${index % 9}',
      card: '4403********${(1000 + index).toString().substring(0, 4)}',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: showcaseAppBar(context, '表格布局'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          children: [
            _summaryCard(context),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: scheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: scheme.shadow.withValues(alpha: 0.07),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: TableExtend<TestBean>(
                  tableDatas: _list,
                  minCellWidth: 76,
                  shrinkWrap: true,
                  enableDivider: true,
                  gridDivider: false,
                  dividerColor: scheme.outlineVariant,
                  enableFixHeaderColumn: true,
                  enableFixFootColumn: false,
                  fixCellHeaderWidthFlex: const [1],
                  cellWidthFlex: const [1.2, 0.7, 1.1, 1.3, 1.4, 2.8],
                  buildFixHeaderTableHeaderStyle: (context, rowStyle) {
                    return Container(
                      width: rowStyle.rowWidth,
                      height: 46,
                      color: scheme.primary,
                      child: TableExtendCells(
                        rowStyle: rowStyle,
                        children: [
                          _cell(context, '操作', header: true),
                        ],
                      ),
                    );
                  },
                  fixHeaderRowStyle: (rowStyle) {
                    final index = rowStyle.index ?? 0;
                    return Container(
                      width: rowStyle.rowWidth,
                      height: 46,
                      constraints: const BoxConstraints(minHeight: 46),
                      color: index.isEven
                          ? scheme.surface
                          : scheme.surfaceContainerLowest,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => _showDetail(rowStyle.data),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: const Size(0, 32),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text('查看'),
                      ),
                    );
                  },
                  buildTableHeaderStyle: (context, rowStyle) {
                    return Container(
                      width: rowStyle.rowWidth,
                      height: 46,
                      color: scheme.primary,
                      child: TableExtendCells(
                        rowStyle: rowStyle,
                        children: [
                          _cell(context, '姓名', header: true),
                          _cell(context, '年龄', header: true),
                          _cell(context, '生日', header: true),
                          _cell(context, '身份证', header: true),
                          _cell(context, '电话', header: true),
                          _cell(context, '住址', header: true),
                        ],
                      ),
                    );
                  },
                  buildRowStyle: (rowStyle) {
                    final bean = rowStyle.data!;
                    final index = rowStyle.index ?? 0;
                    return Container(
                      width: rowStyle.rowWidth,
                      constraints: const BoxConstraints(minHeight: 46),
                      color: index.isEven
                          ? scheme.surface
                          : scheme.surfaceContainerLowest,
                      child: TableExtendCells(
                        rowStyle: rowStyle,
                        children: [
                          _cell(context, bean.name ?? ''),
                          _cell(context, bean.age ?? ''),
                          _cell(context, bean.birth ?? ''),
                          _cell(context, bean.card ?? ''),
                          _cell(context, bean.phone ?? ''),
                          _cell(
                            context,
                            bean.address ?? '',
                            maxLines: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.swipe, size: 16, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(
                  '左右滑动查看更多列 · 共 ${_list.length} 条数据',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            scheme.primary.withValues(alpha: 0.85),
            scheme.tertiary.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.table_chart_outlined,
                color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '双向滚动数据表格',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '固定操作列 + 表头 · 支持横向与纵向滚动',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _statPill('${_list.length}', '记录'),
          const SizedBox(width: 8),
          _statPill('6', '列'),
        ],
      ),
    );
  }

  Widget _statPill(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _cell(
    BuildContext context,
    String text, {
    bool header = false,
    int maxLines = 1,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: header ? 13 : 12.5,
          color: header ? Colors.white : scheme.onSurface,
          fontWeight: header ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  void _showDetail(TestBean? bean) {
    if (bean == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('查看：${bean.name} · ${bean.phone}')),
      );
  }
}

class TestBean {
  String? name;
  String? age;
  String? birth;
  String? phone;
  String? card;
  String? address;

  TestBean({
    this.name,
    this.age,
    this.birth,
    this.phone,
    this.card,
    this.address,
  });
}