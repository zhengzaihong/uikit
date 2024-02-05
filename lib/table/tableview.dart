import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/20
/// create_time: 9:51
/// describe: 绘制表格的组件，使用此组件一定要注意每行的权重比
/// 此组件用于通用性表格，
/// 表格存在各种合并的单元格 需根据行号单独处理
///  2023-02-25 已支持非固定行高，一行中自动适配最高行。
/// 待优化
///

/// BuildTableHeaderStyle  BuildRowStyle 中rowWidth 为总宽度 cellWidth 为单元格宽度 只再双向滚动中生效

///构建标题行
typedef BuildTableHeaderStyle<T> = Widget Function(
    BuildContext context, double rowWidth, List<double> cellWidth);

///构建每一行的样式
typedef BuildRowStyle<T> = Widget Function(
    T data, int index, double rowWidth, List<double> cellWidth);

///预处理数据
typedef PreDealData<T> = List<T> Function();

class TableView<T> extends StatefulWidget {
  ///数据 表示表格有多少行
  final List<T>? tableDatas;

  /// 构建每一行的回调
  final BuildRowStyle buildRowStyle;

  ///是否开启 顶部分割线
  final bool enableTopDivider;

  ///是否开启 尾部分割线
  final bool enableBottomDivider;

  ///添加此回调 会覆盖 tableDatas 数据
  final PreDealData? preDealData;

  final bool shrinkWrap;

  final bool enableDivider;

  ///纵向分割线  横向分割线在 TabRow配置
  final Color dividerColor;
  final double dividerHeight;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlive;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;

  ///是否开启双向滑动 以下属性只有在双向滑动时有效
  final bool doubleScroll;

  /// 需要双向滑动说明列表不满足一屏显示，此时需要设置最小宽度作为基准，
  /// 其余宽度按照此基准扩大倍数。
  final double minCellWidth;
  final int cellColumnCount;
  final List<double>? cellWidthFlex;
  final ScrollBehavior? behavior;
  final BuildTableHeaderStyle? buildTableHeaderStyle;
  final ScrollController? titleScrollController;
  final ScrollController? contentScrollController;

  const TableView(
      {this.tableDatas = const [],
      required this.buildRowStyle,
      this.enableTopDivider = false,
      this.enableBottomDivider = false,
      this.enableDivider = false,
      this.preDealData,
      this.shrinkWrap = true,
      this.dividerColor = Colors.black,
      this.dividerHeight = 1,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.controller,
      this.physics,
      this.padding,
      this.addAutomaticKeepAlive = true,
      this.addRepaintBoundaries = true,
      this.addSemanticIndexes = true,
      this.cacheExtent,
      this.doubleScroll = false,
      this.behavior,
      this.buildTableHeaderStyle,
      this.minCellWidth = 50,
      this.cellWidthFlex,
      this.cellColumnCount = 1,
      this.titleScrollController,
      this.contentScrollController,
      Key? key})
      : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState<T> extends State<TableView> {
  List<dynamic> datas = [];

  int _itemCount = 0;
  late ScrollController _titleController;
  late ScrollController _contentController;

  List<double>? cellWidthFlex;

  ///双向滚动的总宽
  double _horizontalTotalWidth = 0;

  @override
  void initState() {
    super.initState();
    _titleController = widget.titleScrollController ?? ScrollController();
    _contentController = widget.contentScrollController ?? ScrollController();

    datas = widget.tableDatas ?? [];
    if (widget.preDealData != null) {
      datas = widget.preDealData!.call();
    }
    _itemCount = datas.length;

    if (widget.enableTopDivider && widget.enableBottomDivider) {
      _itemCount = datas.length + 2;
    } else if (widget.enableTopDivider) {
      _itemCount = datas.length + 1;
    } else if (widget.enableBottomDivider) {
      _itemCount = datas.length + 1;
    }

    if (widget.doubleScroll) {
      _titleController.addListener(_updateContent);
      _contentController.addListener(_updateTitle);
      cellWidthFlex = widget.cellWidthFlex ?? [];
      if (cellWidthFlex!.length != widget.cellColumnCount) {
        cellWidthFlex = List.generate(widget.cellColumnCount, (index) => 1);
      }

      for (int i = 0; i < cellWidthFlex!.length; i++) {
        _horizontalTotalWidth += cellWidthFlex![i] * widget.minCellWidth;
      }
    }
  }

  void _updateTitle() {
    _titleController.jumpTo(_contentController.offset);
  }

  void _updateContent() {
    _contentController.jumpTo(_titleController.offset);
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateContent);
    _contentController.removeListener(_updateTitle);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.doubleScroll) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                width: _horizontalTotalWidth,
                child: SingleChildScrollView(
                  controller: _titleController,
                  scrollDirection: Axis.horizontal,
                  child: widget.buildTableHeaderStyle?.call(
                      context,
                      _horizontalTotalWidth,
                      cellWidthFlex!
                          .map((e) => e * widget.minCellWidth)
                          .toList()),
                ),
              ))
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
              controller: ScrollController(),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              final newScrollOffset = _contentController.offset - details.delta.dx;
                              _contentController.jumpTo(
                                  newScrollOffset
                              );
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _contentController,
                              physics:widget.physics ?? const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                width: _horizontalTotalWidth,
                                child: ListView.separated(
                                    itemCount: _itemCount,
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if ((widget.enableTopDivider &&
                                          index == 0) ||
                                          (widget.enableBottomDivider &&
                                              index == _itemCount - 1)) {
                                        return const SizedBox();
                                      }

                                      /// 外部处理的行的下标都从 1 第一行开始
                                      return widget.buildRowStyle(
                                          widget.enableTopDivider
                                              ? datas[index - 1]
                                              : datas[index],
                                          widget.enableTopDivider
                                              ? index
                                              : index + 1,
                                          _horizontalTotalWidth,
                                          cellWidthFlex!
                                              .map((e) =>
                                          e * widget.minCellWidth)
                                              .toList());
                                    },
                                    separatorBuilder: (context, index) {
                                      final divider = Container(
                                        ///修复 web html 像素丢失问题
                                        height: widget.dividerHeight,
                                        color: widget.dividerColor,
                                      );
                                      if (widget.enableBottomDivider &&
                                          index == _itemCount) {
                                        return divider;
                                      }
                                      return widget.enableDivider
                                          ? divider
                                          : const SizedBox();
                                    }),
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              )))
        ],
      );
    }

    return ListView.separated(
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        physics: widget.physics,
        controller: widget.controller,
        padding: widget.padding,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlive,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        itemCount: _itemCount,
        itemBuilder: (context, index) {
          if ((widget.enableTopDivider && index == 0) ||
              (widget.enableBottomDivider && index == _itemCount - 1)) {
            return const SizedBox();
          }

          /// 外部处理的行的下标都从 1 第一行开始
          return widget.buildRowStyle(
              widget.enableTopDivider ? datas[index - 1] : datas[index],
              widget.enableTopDivider ? index : index + 1,
              0, []);
        },
        separatorBuilder: (context, index) {
          final divider = Container(
            ///修复 web html 像素丢失问题
            height: widget.dividerHeight,
            color: widget.dividerColor,
          );
          if (widget.enableBottomDivider && index == _itemCount) {
            return divider;
          }
          return widget.enableDivider ? divider : const SizedBox();
        });
  }
}

class TabRow extends StatelessWidget {
  final bool enableDivider;
  final List<int> cellWidget;
  final double? rowDividerHeight;
  final double rowDividerWidth;
  final Color? dividerColor;
  final CellItem cellItem;
  final double? rowHeight;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final bool fixRowHeight;

  const TabRow(
      {this.enableDivider = true,
      this.rowDividerHeight,
      this.rowDividerWidth = 0.5,
      required this.cellWidget,
      required this.cellItem,
      this.rowHeight,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.verticalDirection = VerticalDirection.down,
      this.textDirection,
      this.dividerColor = Colors.red,
      this.fixRowHeight = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRow();
  }

  Widget _buildRow() {
    return IntrinsicHeight(
      child: Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          verticalDirection: verticalDirection,
          textDirection: textDirection,
          children: _buildCells(cellWidget)),
    );
  }

  Widget _createRowLine() {
    if (!fixRowHeight && rowHeight != null) {
      return SizedBox(
        width: rowDividerWidth,
        height: rowHeight,
        child: Row(
          children: [
            Expanded(
                child: Container(
              width: rowDividerWidth,
              color: dividerColor,
            ))
          ],
        ),
      );
    }
    return Container(
      width: rowDividerWidth,
      height: rowDividerHeight,
      color: dividerColor,
    );
  }

  List<Widget> _buildCells(List<int> cellWidget) {
    List<Widget> cells = [];

    for (var i = 0; i < cellWidget.length; i++) {
      var widget = cellItem.buildCell(cellItem, i, null);
      cells.add(Expanded(
          flex: cellWidget[i],
          child: Row(children: [
            if (enableDivider) _createRowLine(),
            Expanded(
                child: Container(
              color: cellItem.background,
              padding: cellItem.padding,
              alignment: cellItem.alignment,
              child: widget,
            ))
          ])));
    }
    if (enableDivider) {
      cells.add(_createRowLine());
    }

    return cells;
  }
}

/// CellItem 每个元素的信息
///外部构建每个表格的样式信息
typedef BuildCell = Widget Function(
    CellItem cellItem, int index, double? weight);

class CellItem {
  AlignmentGeometry alignment;
  EdgeInsetsGeometry padding;
  Color background;

  final BuildCell buildCell;

  CellItem(
      {this.alignment = Alignment.center,
      this.background = Colors.transparent,
      this.padding = const EdgeInsets.all(0),
      required this.buildCell});
}

///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class CellBean {
  String? name;
  int? rowIndex;
  int? cellIndex;
  final bool isTitle;

  ///附加信息
  dynamic obj;

  CellBean(
      {this.rowIndex,
      required this.name,
      this.cellIndex,
      this.obj,
      this.isTitle = false});
}

///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class RowBean {
  final List<CellBean> cells;

  RowBean({required this.cells});
}

/// 如果想让标题类的 左右对齐可使用该文本组件
/// 外部可直接使用该组件，
/// eg:  return TabSpaceText(
///  contents: KitMath.parseStr((cellBean.name).toString()),
///  padding: const EdgeInsets.only(left: 10,right: 10),
///  style: const TextStyle(fontSize: 14,color: Colors.black));
///
class TabSpaceText extends StatelessWidget {
  final List<String> contents;
  final TextStyle style;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const TabSpaceText(
      {Key? key,
      required this.contents,
      this.margin,
      this.padding,
      this.backgroundColor,
      this.width,
      this.height,
      this.alignment,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisSize = MainAxisSize.max,
      this.style = const TextStyle(color: Colors.red, fontSize: 12)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      alignment: alignment,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [...contents.map((e) => Text(e, style: style)).toList()],
      ),
    );
  }
}
