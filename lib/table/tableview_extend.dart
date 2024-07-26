import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/table/tableview_lib.dart';

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

typedef HandlerControllerCallBack = void Function(HandlerController handler);

class TableViewExtend<T> extends StatefulWidget {

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

  const TableViewExtend(
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
  State<TableViewExtend> createState() => _TableViewExtendState<T>();
}

class _TableViewExtendState<T> extends State<TableViewExtend<T>> {

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

    // _titleController?.addListener(bindTitleListener);
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
                  thickness: MaterialStateProperty.all(0),
                  thumbColor: MaterialStateProperty.all(Colors.transparent),
                  trackColor: MaterialStateProperty.all(Colors.transparent),
                  trackBorderColor: MaterialStateProperty.all(Colors.transparent),
                  thumbVisibility: MaterialStateProperty.all(false),
                  trackVisibility: MaterialStateProperty.all(false),
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
              child:  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _contentHorizontalController,
                physics:widget.physics ?? const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: _horizontalTotalWidth,
                  height: box.maxHeight,
                  child: ListView.separated(
                      itemCount: _itemCount,
                      controller: _contentVerticalController,
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
                        child: buildTableHeaderStyle.call(
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
                        thickness: MaterialStateProperty.all(0),
                        thumbColor: MaterialStateProperty.all(Colors.transparent),
                        trackColor: MaterialStateProperty.all(Colors.transparent),
                        trackBorderColor: MaterialStateProperty.all(Colors.transparent),
                        thumbVisibility: MaterialStateProperty.all(false),
                        trackVisibility: MaterialStateProperty.all(false),
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
                    child:  ListView.separated(
                        itemCount: _itemCount,
                        shrinkWrap: true,
                        controller: contentController,
                        physics: const AlwaysScrollableScrollPhysics(),
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
