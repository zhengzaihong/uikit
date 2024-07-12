import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/table/tableview_lib.dart';
import 'tableview_extend.dart';
import 'interface/callback.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/20
/// create_time: 9:51
/// describe: 绘制表格的组件，使用此组件一定要注意每行的权重比
/// 此组件用于通用性表格，
/// 表格存在各种合并的单元格 需根据行号单独处理
/// 需要水平和垂直方向都可滑动的表格 使用 [TableViewExtend] 实现，
/// TableView 不在支持双向滑动，仅垂直滑动的表格


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
      Key? key})
      : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState<T> extends State<TableView> {

  List<dynamic> datas = [];
  int _itemCount = 0;
  List<double>? cellWidthFlex;


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
          final rowStyleParam = RowStyleParam(
              data: widget.enableTopDivider
                  ? datas[index - 1]
                  : datas[index],
              index: widget.enableTopDivider
                  ? index
                  : index + 1,
            );
          return widget.buildRowStyle(rowStyleParam);
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
