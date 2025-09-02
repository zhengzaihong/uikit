import 'package:flutter/material.dart';
import 'package:uikit/behavior/overscrollbehavior.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/6/20
/// create_time: 9:51
/// describe: 支持横向和纵向滚动的表格的组件，使用此组件一定要注意每行的权重比
/// 此组件用于通用性表格，
/// 表格存在各种合并的单元格 需根据行号单独处理
///  2023-02-25 已支持非固定行高，一行中自动适配最高行。
/// 待优化
///

typedef HandlerControllerCallBack = void Function(HandlerController handler);

///构建标题行
typedef BuildTableHeaderStyle<T> = Widget Function(
    BuildContext context, RowStyleParam rowStyle);

///构建每一行的样式
typedef BuildRowStyle<T> = Widget Function(RowStyleParam rowStyle);

///预处理数据
typedef PreDealData<T> = List<T> Function();

///构建每一行的样式
typedef BuildFixHeaderRowStyle<T> = Widget Function(RowStyleParam rowStyle);

class TableExtend<T> extends StatefulWidget {

  ///数据 表示表格有多少行
  final List<T>? tableDatas;

  /// 构建每一行的回调 内容
  final BuildRowStyle buildRowStyle;
  final BuildTableHeaderStyle? buildTableHeaderStyle;

  ///构建表格固定头 水平方向
  final BuildRowStyle? fixHeaderRowStyle;
  final BuildTableHeaderStyle? buildFixHeaderTableHeaderStyle;

  ///构建表格固定尾 水平方向
  final BuildRowStyle? fixFootRowStyle;
  final BuildTableHeaderStyle? buildFixFootTableHeaderStyle;
  final HandlerControllerCallBack? handlerControllerCallBack;

  ///表格体的样式
  final BoxDecoration? headerDecoration;
  final BoxDecoration? bodyDecoration;


  ///添加此回调 会覆盖 tableDatas 数据
  final PreDealData<T>? preDealData;

  final bool shrinkWrap;

  final bool enableDivider;
  final bool gridDivider;

  ///纵向分割线  横向分割线在 TabRow配置
  final Color dividerColor;
  final double dividerSize;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlive;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;

  ///是否开启 固定头和脚的列 -->水平方向
  final bool enableFixHeaderColumn;
  final bool enableFixFootColumn;

  /// 需要双向滑动说明列表不满足一屏显示，此时需要设置最小宽度作为基准，
  /// 其余宽度按照此基准扩大倍数。
  final double minCellWidth;
  final List<double>? cellWidthFlex;
  final List<double>? fixCellHeaderWidthFlex;
  final List<double>? fixCellFootWidthFlex;
  final ScrollBehavior? behavior;

  const TableExtend(
      { this.tableDatas = const [],
        this.bodyDecoration,
        this.headerDecoration,
        this.enableDivider = false,
        this.gridDivider = false,
        this.preDealData,
        this.shrinkWrap = true,
        this.dividerColor = Colors.black,
        this.dividerSize = 1,
        this.scrollDirection = Axis.vertical,
        this.reverse = false,
        this.controller,
        this.physics,
        this.padding,
        this.addAutomaticKeepAlive = true,
        this.addRepaintBoundaries = true,
        this.addSemanticIndexes = true,
        this.cacheExtent,
        this.enableFixHeaderColumn = false,
        this.enableFixFootColumn = false,
        this.behavior,
        this.handlerControllerCallBack,
        required this.buildRowStyle,
        this.buildTableHeaderStyle,

        this.fixHeaderRowStyle,
        this.buildFixHeaderTableHeaderStyle,

        this.fixFootRowStyle,
        this.buildFixFootTableHeaderStyle,

        this.minCellWidth = 50,
        this.cellWidthFlex,

        this.fixCellHeaderWidthFlex,
        this.fixCellFootWidthFlex,
        Key? key})
      : super(key: key);

  @override
  State<TableExtend> createState() => _TableExtendState<T>();
}

class _TableExtendState<T> extends State<TableExtend<T>> {

  List<T> datas = [];

  int _itemCount = 0;

  ScrollController? _titleController;
  ScrollController? _contentHorizontalController;
  ScrollController? _contentVerticalController;

  ScrollController? _fixHeaderTitleController;
  ScrollController? _fixHeaderContentController;

  ScrollController? _fixFootTitleController;
  ScrollController? _fixFootContentController;

  List<double>? cellWidthFlex;
  List<double>? fixCellHeaderWidthFlex;
  List<double>? fixCellFootWidthFlex;

  ///双向滚动的总宽
  double _horizontalTotalWidth = 0;
  double _fixHeaderColumnTotalWidth = 0;
  double _fixFootColumnTotalWidth = 0;

  final handlerController = HandlerController._();

  @override
  void initState() {
    super.initState();

    _titleController =  ScrollController();
    _contentHorizontalController = ScrollController();
    _contentVerticalController =  ScrollController();

    handlerController.titleController = _titleController;
    handlerController.contentHorizontalController = _contentHorizontalController;
    handlerController.contentVerticalController = _contentVerticalController;

    if(widget.enableFixHeaderColumn){
      _fixHeaderTitleController = ScrollController();
      _fixHeaderContentController = ScrollController();

      handlerController.fixHeaderTitleController = _fixHeaderTitleController;
      handlerController.fixHeaderContentController = _fixHeaderContentController;
    }

    if(widget.enableFixFootColumn){
      _fixFootTitleController =  ScrollController();
      _fixFootContentController = ScrollController();
      handlerController.fixFooterTitleController = _fixFootTitleController;
      handlerController.fixFooterContentController = _fixFootContentController;
    }

    datas = widget.tableDatas ?? [];

    if (widget.preDealData != null) {
      datas = widget.preDealData!.call();
    }

    _itemCount = datas.length;

    _titleController?.addListener(bindTitleListener);
    _contentHorizontalController?.addListener(bindHorizontalListener);


    _contentVerticalController?.addListener(bindContentListener);

    if(widget.enableFixHeaderColumn){
      _fixHeaderContentController?.addListener(bindHeaderListener);
    }
    if(widget.enableFixFootColumn){
      _fixFootContentController?.addListener(bindFooterListener);
    }
    cellWidthFlex = widget.cellWidthFlex ?? [];
    fixCellHeaderWidthFlex = widget.fixCellHeaderWidthFlex ?? [];
    fixCellFootWidthFlex = widget.fixCellFootWidthFlex ?? [];

    for (int i = 0; i < cellWidthFlex!.length; i++) {
      _horizontalTotalWidth += cellWidthFlex![i] * widget.minCellWidth;
    }
    for (int i = 0; i < fixCellHeaderWidthFlex!.length; i++) {
      _fixHeaderColumnTotalWidth += fixCellHeaderWidthFlex![i] * widget.minCellWidth;
    }
    for (int i = 0; i < fixCellFootWidthFlex!.length; i++) {
      _fixFootColumnTotalWidth += fixCellFootWidthFlex![i] * widget.minCellWidth;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.handlerControllerCallBack?.call(handlerController);
    });

  }

  void bindTitleListener() {
    _contentHorizontalController?.removeListener(bindHorizontalListener);
    _contentHorizontalController?.jumpTo(_titleController?.offset??0);
    _contentHorizontalController?.addListener(bindHorizontalListener);
  }

  void bindHorizontalListener() {
    _titleController?.removeListener(bindTitleListener);
    _titleController?.jumpTo(_contentHorizontalController?.offset??0);
    _titleController?.addListener(bindTitleListener);
  }

  void bindHeaderListener(){
    _contentVerticalController?.removeListener(bindContentListener);
    _fixFootContentController?.removeListener(bindFooterListener);

    scrollContent(_fixHeaderContentController?.offset??0);
    scrollFooter(_fixHeaderContentController?.offset??0);

    _contentVerticalController?.addListener(bindContentListener);
    _fixFootContentController?.addListener(bindFooterListener);
  }

  void bindContentListener(){
    _fixHeaderContentController?.removeListener(bindHeaderListener);
    _fixFootContentController?.removeListener(bindFooterListener);

    scrollHeader(_contentVerticalController?.offset??0);
    scrollFooter(_contentVerticalController?.offset??0);

    _fixHeaderContentController?.addListener(bindHeaderListener);
    _fixFootContentController?.addListener(bindFooterListener);
  }

  void bindFooterListener(){
    _fixHeaderContentController?.removeListener(bindHeaderListener);
    _contentVerticalController?.removeListener(bindContentListener);

    scrollHeader(_fixFootContentController?.offset??0);
    scrollContent(_fixFootContentController?.offset??0);

    _fixHeaderContentController?.addListener(bindHeaderListener);
    _contentVerticalController?.addListener(bindContentListener);
  }

  void scrollContent(double offset){
    _contentVerticalController?.jumpTo(offset);
  }

  void scrollHeader(double offset){
    _fixHeaderContentController?.jumpTo(offset);
  }
  void scrollFooter(double offset){
    _fixFootContentController?.jumpTo(offset);
  }


  @override
  void dispose() {
    handlerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        //固定列头
        widget.enableFixHeaderColumn?buildFixColumnTable(
          header: true,
          width: _fixHeaderColumnTotalWidth,
          fixWidthFlex: fixCellHeaderWidthFlex!,
          titleController: _fixHeaderTitleController,
          contentController: _fixHeaderContentController,
          buildTableHeaderStyle: widget.buildFixHeaderTableHeaderStyle!,
          rowStyle: widget.fixHeaderRowStyle!,
        ):const SizedBox(),

        Expanded(
            child: widget.enableFixFootColumn? Theme(data: ThemeData(
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(0),
                  thickness: WidgetStateProperty.all(0),
                  thumbColor: WidgetStateProperty.all(Colors.transparent),
                  trackColor: WidgetStateProperty.all(Colors.transparent),
                  trackBorderColor: WidgetStateProperty.all(Colors.transparent),
                  thumbVisibility: WidgetStateProperty.all(false),
                  trackVisibility: WidgetStateProperty.all(false),
                )
            ), child: buildCenterTable()):buildCenterTable()
        ),

        //固定列尾
        widget.enableFixFootColumn?buildFixColumnTable(
          header: false,
          width: _fixFootColumnTotalWidth,
          fixWidthFlex: fixCellFootWidthFlex!,
          titleController: _fixFootTitleController,
          contentController: _fixFootContentController,
          buildTableHeaderStyle: widget.buildFixFootTableHeaderStyle!,
          rowStyle: widget.fixFootRowStyle!,
        ):const SizedBox()
      ],
    );
  }

  Widget buildCenterTable() {
    return LayoutBuilder(builder: (context,box){
      if(box.maxWidth>_horizontalTotalWidth){
        _horizontalTotalWidth = box.maxWidth;
      }
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: DecoratedBox(
                    decoration: widget.headerDecoration??BoxDecoration(
                      border:widget.enableDivider && widget.gridDivider? Border(
                          top: BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                          bottom: BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                          right: BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                          left: BorderSide(color:widget.dividerColor,width:widget.dividerSize)):null,
                    ),
                    child: ScrollConfiguration(
                      behavior: OverScrollBehavior(),
                      child: SingleChildScrollView(
                        controller: _titleController,
                        scrollDirection: Axis.horizontal,
                        child: widget.buildTableHeaderStyle?.call(
                            context,
                            RowStyleParam(
                                enableDivider: widget.enableDivider,
                                rowWidth: _horizontalTotalWidth,
                                cellWidth: cellWidthFlex!
                                    .map((e) => e * widget.minCellWidth)
                                    .toList())
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          Expanded(
              child: DecoratedBox(
                decoration: widget.bodyDecoration??BoxDecoration(
                  border:widget.enableDivider  && widget.gridDivider? Border(
                      top: BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                      bottom: BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                      right: BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                      left: BorderSide(color:widget.dividerColor,width:widget.dividerSize)):null,
                ),
                child:GestureDetector(
                  // onHorizontalDragUpdate: (details) {
                  //   final newScrollOffset = _contentHorizontalController!.offset - details.delta.dx;
                  //   _contentHorizontalController!.jumpTo(newScrollOffset);
                  // },
                  child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child:  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _contentHorizontalController,
                      physics:widget.physics ?? const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        width: _horizontalTotalWidth,
                        height: box.maxHeight,
                        child:ScrollConfiguration(
                          behavior:OverScrollBehavior() ,
                          child:  ListView.separated(
                              itemCount: _itemCount,
                              controller: _contentVerticalController,
                              // physics: ClampingScrollPhysics(),
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final rowStyleParam = RowStyleParam(
                                    enableDivider: widget.enableDivider,
                                    rowWidth: _horizontalTotalWidth,
                                    data: datas[index],
                                    index: index,
                                    cellWidth: cellWidthFlex!
                                        .map((e) =>
                                    e * widget.minCellWidth)
                                        .toList());
                                return widget.buildRowStyle(rowStyleParam);
                              },
                              separatorBuilder: (context, index) {
                                final divider = Container(
                                  height: widget.dividerSize,
                                  color: widget.dividerColor,
                                );
                                return widget.enableDivider
                                    ? divider
                                    : const SizedBox();
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      );
    });
  }

  Widget buildFixColumnTable({
    required bool header,
    required double width,
    required List<double> fixWidthFlex,
    required ScrollController? titleController,
    required ScrollController? contentController,
    required BuildTableHeaderStyle buildTableHeaderStyle,
    required BuildRowStyle rowStyle,
  }) {
    return SizedBox(
      width: width,
      child:  Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                    width: width,
                    child: DecoratedBox(
                      decoration: widget.headerDecoration??BoxDecoration(
                        border:widget.enableDivider  && widget.gridDivider? Border(
                          top:BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                          bottom:BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                          left: getBorderSide(header,isLeft: true),
                          right:getBorderSide(header,isLeft: false),
                        ):null,
                      ),
                      child: SingleChildScrollView(
                        controller: titleController,
                        scrollDirection: Axis.horizontal,
                        child:buildTableHeaderStyle.call(
                            context,
                            RowStyleParam(
                                enableDivider: widget.enableDivider,
                                rowWidth: width,
                                cellWidth:fixWidthFlex
                                    .map((e) => e * widget.minCellWidth)
                                    .toList())
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          Expanded(
              child: Theme(
                  data: ThemeData(
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(0),
                        thickness: WidgetStateProperty.all(0),
                        thumbColor: WidgetStateProperty.all(Colors.transparent),
                        trackColor: WidgetStateProperty.all(Colors.transparent),
                        trackBorderColor: WidgetStateProperty.all(Colors.transparent),
                        thumbVisibility: WidgetStateProperty.all(false),
                        trackVisibility: WidgetStateProperty.all(false),
                      )
                  ),
                  child:DecoratedBox(
                    decoration: widget.bodyDecoration??BoxDecoration(
                      border:widget.enableDivider  && widget.gridDivider? Border(
                        top:BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                        bottom:BorderSide(color:widget.dividerColor,width:widget.dividerSize),
                        left: getBorderSide(header,isLeft: true),
                        right:getBorderSide(header,isLeft: false),
                      ):null,
                    ),
                    child:ScrollConfiguration(
                      behavior:OverScrollBehavior() ,
                      child: ListView.separated(
                          itemCount: _itemCount,
                          shrinkWrap: true,
                          controller: contentController,
                          // physics: const AlwaysScrollableScrollPhysics(),
                          // physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final rowStyleParam = RowStyleParam(
                                enableDivider: widget.enableDivider,
                                rowWidth: _horizontalTotalWidth,
                                data: datas[index],
                                index:index,
                                cellWidth: cellWidthFlex!
                                    .map((e) =>
                                e * widget.minCellWidth)
                                    .toList());
                            return rowStyle(rowStyleParam);
                          },
                          separatorBuilder: (context, index) {
                            final divider = Container(
                              height: widget.dividerSize,
                              color: widget.dividerColor,
                            );
                            return widget.enableDivider
                                ? divider
                                : const SizedBox();
                          }),
                    ),
                  )))
        ],
      ),
    );
  }

  BorderSide getBorderSide(bool header,{bool isLeft = true}) {
    if(header){
      return isLeft?BorderSide(color:widget.dividerColor,width:widget.dividerSize): BorderSide.none;
    }
    return isLeft? BorderSide.none:BorderSide(color:widget.dividerColor,width:widget.dividerSize);
  }
}

class HandlerController {

  HandlerController._();

  ScrollController? _fixHeaderTitleController;

  ScrollController? get getFixHeaderTitleController => _fixHeaderTitleController;

  ScrollController? _fixHeaderContentController;

  ScrollController? get getFixHeaderContentController =>
      _fixHeaderContentController;

  ScrollController? _titleController;

  ScrollController? get getTitleController => _titleController;

  ScrollController? _contentHorizontalController;

  ScrollController? get getContentHorizontalController =>
      _contentHorizontalController;

  ScrollController? _contentVerticalController;

  ScrollController? get getContentVerticalController =>
      _contentVerticalController;

  ScrollController? _fixFooterTitleController;

  ScrollController? get getFixFooterTitleController => _fixFooterTitleController;

  ScrollController? _fixFooterContentController;

  ScrollController? get getFixFooterContentController =>
      _fixFooterContentController;

  set titleController(ScrollController? value) {
    _titleController = value;
  }

  set contentHorizontalController(ScrollController? value) {
    _contentHorizontalController = value;
  }

  set contentVerticalController(ScrollController? value) {
    _contentVerticalController = value;
  }

  set fixHeaderTitleController(ScrollController? value) {
    _fixHeaderTitleController = value;
  }

  set fixHeaderContentController(ScrollController? value) {
    _fixHeaderContentController = value;
  }

  set fixFooterTitleController(ScrollController? value) {
    _fixFooterTitleController = value;
  }

  set fixFooterContentController(ScrollController? value) {
    _fixFooterContentController = value;
  }



  void dispose() {
    _fixHeaderTitleController?.dispose();
    _fixHeaderContentController?.dispose();
    _titleController?.dispose();
    _contentHorizontalController?.dispose();
    _contentVerticalController?.dispose();
    _fixFooterTitleController?.dispose();
    _fixFooterContentController?.dispose();

  }
}

// 每一行
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

// 如果想让标题类的 左右对齐可使用该文本组件，外部可直接使用该组件，
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


/// 构建每一行的参数
class RowStyleParam<T>{

  RowStyleParam({this.data,this.rowWidth,this.cellWidth,this.index,this.enableDivider = false});

  bool enableDivider;

  int? index;

  T? data;

  /// 行高
  double? rowWidth;
  /// 单元格宽度
  List<double>? cellWidth;

}

///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class RowBean {

  ///单元格宽度 权重
  final List<int> flex;
  ///单元格内容
  final List<CellBean> cells;

  RowBean({required this.cells, this.flex = const []});
}



/// CellItem 每个元素的信息
///外部构建每个表格的样式信息
typedef BuildCell = Widget Function(CellItem cellItem, int index, double? weight);

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
