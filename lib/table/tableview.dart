import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/20
/// create_time: 9:51
/// describe: 绘制表格的组件，使用此组件一定要注意每行的权重比
/// 此组件用于通用性表格，
/// 表格存在各种合并的单元格 需根据行号单独处理
///
/// 待优化
///

///构建每一行的样式
typedef BuildRowStyle<T> = Widget Function(T data, int index);

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
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;

  const TableView({this.tableDatas = const [],
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
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    Key? key})
      : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState<T> extends State<TableView> {
  List<dynamic> datas = [];

  int _itemCount = 0;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        physics: widget.physics,
        controller: widget.controller,
        padding: widget.padding,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
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
              widget.enableTopDivider ? index : index + 1);
        },
        separatorBuilder: (context, index) {
          final divider = Divider(
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
  final List<int> cellWeiget;
  final double dividerHeight;
  final double dividerWidth;
  final Color? dividerColor;
  final CellItem cellItem;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;

  const TabRow({
    this.enableDivider = true,
    this.dividerHeight = 24,
    required this.cellWeiget,
    required this.cellItem,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.dividerWidth = 0.5,
    this.dividerColor = Colors.red,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
        textDirection: textDirection,
        children: buildCells(cellWeiget));
  }

  List<Widget> buildCells(List<int> cellWeiget) {
    List<Widget> cells = [];
    for (var i = 0; i < cellWeiget.length; i++) {
      var widget = cellItem.buildCell(cellItem, i);

      cells.add(Expanded(
          flex: cellWeiget[i],
          child: Row(children: [
            if (enableDivider)
              Container(
                width: dividerWidth,
                height: dividerHeight,
                color: dividerColor,
              ),
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
      cells.add(
        Container(
          width: dividerWidth,
          height: dividerHeight,
          color: dividerColor,
        ),
      );
    }

    return cells;
  }
}

/// CellItem 每个元素的信息
///外部构建每个表格的样式信息
typedef BuildCell = Widget Function(CellItem cellItem, int index);

class CellItem {

  AlignmentGeometry alignment;
  EdgeInsetsGeometry padding;
  Color background;

  final BuildCell buildCell;

  CellItem({
    this.alignment = Alignment.center,
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

  ///附加信息
  dynamic obj;

  CellBean({this.rowIndex, required this.name, this.cellIndex, this.obj});
}

///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class RowBean {
  final List<CellBean> cells;

  RowBean({required this.cells});
}
