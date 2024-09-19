
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uikit_forzzh/edit_text/input_text.dart';
import 'package:flutter_uikit_forzzh/edit_text/outline_input_text_border.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/1/23
/// create_time: 16:57
/// describe: 分页组件
/// 2024-04-09 修改页码非1开始问题。
///

enum PagerItemTypes { prev, next, ellipsis, number }
enum PagerInputType { input ,select,none}

typedef PageChangeCallback = void Function(int totalPages, dynamic currentPage);

class Pager extends StatefulWidget {
  /// 总页数
  final int totalCount;
  /// 每页的数据数量
  final int pageEach;
  /// 当前所在页的回调 点击和输入
  final PageChangeCallback? pageChange;
  /// 错误输入
  final Function()? errorInputCallback;
  /// 文本样式
  final TextStyle? textStyle;
  /// 左右边距
  final int sideDiff;
  /// 是否显示省略号
  final bool showEllipsis;
  /// 当前页数
  final int currentPage;

  ///是否开启首次进入则回调
  final bool isEnterCallback;

  final PagerInputType pagerInputType;

  final List<int>? pageSizeList;

  final String totalText;
  final String prevText;
  final String suffixText;


  final EdgeInsetsGeometry? inputContentPadding;
  final double inputHeight;
  final double inputWidth;
  final Color?  prevColor;
  final Color?  nextColor;
  final Color?  ellipsisColor;


  final TextEditingController? inputController;
  final OutlineInputTextBorder outlineInputTextBorder;

  final Color? inputBgColor;

  /// 输入文本样式
  final TextStyle? inputTextStyle;
  final TextStyle? inputHintTextStyle;
  final String? inputHintText;

  final BoxBorder? focusBorder;
  final double borderRadius;
  final Color pageIndicatorColor;
  final Color pageIndicatorActiveColor;
  final double pageTextSize;
  final double pageIndicatorHeight;
  final Color checkedPageColor;
  final BoxDecoration? checkedPageBoxDecoration;

  const Pager({
    Key? key,
    required this.totalCount,
    required this.pageEach,
    this.prevText = "前往",
    this.suffixText = '页',
    this.totalText = '共%s条',
    this.pagerInputType = PagerInputType.input,
    this.pageChange,
    this.currentPage = 1,
    this.errorInputCallback,
    this.isEnterCallback= false,
    this.textStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color:Colors.black),
    this.pageSizeList,
    this.sideDiff = 2,
    this.showEllipsis = false,
    this.prevColor,
    this.nextColor,
    this.ellipsisColor,
    this.inputContentPadding = const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
    this.inputHeight = 30,
    this.inputWidth = 50,
    this.inputController,
    this.outlineInputTextBorder=  const OutlineInputTextBorder(
      borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0
      ),
      childBorderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    this.inputBgColor,
    this.inputTextStyle,
    this.inputHintTextStyle,
    this.inputHintText,
    this.focusBorder,
    this.borderRadius = 10,
    this.pageIndicatorColor = Colors.grey,
    this.pageIndicatorActiveColor = Colors.black,
    this.checkedPageColor = Colors.black,
    this.checkedPageBoxDecoration,
    this.pageTextSize = 14,
    this.pageIndicatorHeight = 30,
  }):super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {

  // 总页数
  late int totalPages;
  int? lastTotalPages;
  int? lastCurrentPageIndex;

  // 每页的数据数量
  late int pageEach;

  // 当前所在页
  int currentPageIndex = 1;

  late TextEditingController pageInputController;

  @override
  void initState() {
    super.initState();
    pageEach = widget.pageEach;
    currentPageIndex = widget.currentPage-1;
    if(currentPageIndex<0){
      currentPageIndex = 0;
    }
    initData();
  }

  void initData() {
    pageInputController = widget.inputController ?? TextEditingController();
    totalPages = (widget.totalCount / pageEach).ceil();
  }

  void executeCallback() {
    if (widget.pageChange != null) {
      if ((lastTotalPages == null || lastCurrentPageIndex == null) ||
          (lastTotalPages != totalPages ||
              lastCurrentPageIndex != currentPageIndex)) {
        lastTotalPages = totalPages;
        lastCurrentPageIndex = currentPageIndex;
        if(pageInputController.text.isNotEmpty){
          pageInputController.text = '';
         return;
        }
        widget.pageChange!(totalPages, currentPageIndex+1);
      }
    }
  }

  Widget pageItem(PagerIndicator item) {
    return GestureDetector(
      onTapUp: (e) {
        if (item.index != null) {
          setState(() {
            currentPageIndex = item.index!;
          });
        }
        executeCallback();
      },
      child: item,
    );
  }

  List<Widget> generatePager() {
    List<Widget> pageItems = [];
    /// prev添加上一页按钮（<）
    pageItems.add(pageItem(_buildIndicator(
      type: PagerItemTypes.prev,
      index: currentPageIndex > 0 ? currentPageIndex - 1 : null,
    )));
    /// 添加第一页（首页）
    pageItems.add(pageItem(_buildIndicator(
      type: PagerItemTypes.number,
      index: 0,
      isFocused: currentPageIndex == 0,
    )));

    if((currentPageIndex - widget.sideDiff)> 1 && widget.showEllipsis){
      pageItems.add(pageItem(_buildIndicator(
        type: PagerItemTypes.ellipsis,
        index: null,
      )));
    }

    /// 添加数字number list
    List<int> indexesBetweenEllipses = [];
    int index = max(1, currentPageIndex - widget.sideDiff);

    int minIndex = min(currentPageIndex + widget.sideDiff, totalPages - 2);
     /// 居中模式
    for (; index <= minIndex; index++) {
      indexesBetweenEllipses.add(index);
    }
    
    if(currentPageIndex < totalPages - 2 - widget.sideDiff){
      for (int i = 0; i <  widget.sideDiff; i++) {
        indexesBetweenEllipses.add(totalPages - 2 -  widget.sideDiff-i);
      }
    }

    for (var i = 0; i < indexesBetweenEllipses.length; i++) {
      int index = indexesBetweenEllipses[i];
      /// 添加数字页码ui
      pageItems.add(pageItem(_buildIndicator(
        type: PagerItemTypes.number,
        index: index,
        isFocused: currentPageIndex == index,
      )));
    }

    if(widget.showEllipsis){
      if(currentPageIndex < totalPages - 2- widget.sideDiff){
        pageItems.add(pageItem(_buildIndicator(
          type: PagerItemTypes.ellipsis,
          index: null,
        )));
      }
    }


    /// 尾页
    if (totalPages > 1) {
      pageItems.add(pageItem(_buildIndicator(
        type: PagerItemTypes.number,
        index: totalPages - 1,
        isFocused: currentPageIndex == totalPages - 1,
      )));
    }

    /// next
    pageItems.add(pageItem(_buildIndicator(type: PagerItemTypes.next, index: currentPageIndex < totalPages - 1 ? currentPageIndex + 1 : null)));
    if(widget.isEnterCallback){
      executeCallback();
    }
    return pageItems;
  }

  PagerIndicator _buildIndicator({required PagerItemTypes type, int? index, bool isFocused = false}) {
    return PagerIndicator(
      type:type,
      index: index,
      isFocused: isFocused,
      pageIndicatorActiveColor: widget.pageIndicatorActiveColor,
      pageIndicatorColor: widget.pageIndicatorColor,
      focusBorder: widget.focusBorder,
      borderRadius: widget.borderRadius,
      pageTextSize: widget.pageTextSize,
      pageIndicatorHeight: widget.pageIndicatorHeight,
      checkedPageColor: widget.checkedPageColor,
      checkedPageBoxDecoration:widget.checkedPageBoxDecoration,
      currentPageIndex:currentPageIndex
    );
  }

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
        child: Text(
          text,
          style: widget.textStyle,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> pageItems = generatePager();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _text(widget.totalText.replaceAll("%s", widget.totalCount.toString())),
        ...pageItems.map((pageItem) {
          return pageItem;
        }).toList(),
        _buildPageInputType(),
      ],
    );
  }


  Widget _buildPageInputType(){
    if(widget.pagerInputType == PagerInputType.input){
      return  Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _text(widget.prevText),
          InputText(
            width: widget.inputWidth,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            controller: pageInputController,
            allLineBorder: widget.outlineInputTextBorder,
            scrollPadding: const EdgeInsets.all(0),
            enableClear: false,
            style: widget.inputTextStyle,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            onSubmitted: (text){
              try{
                int index = int.parse(text);
                if(index > totalPages){
                  widget.errorInputCallback?.call();
                  return;
                }
                if(index <= 0){
                  widget.errorInputCallback?.call();
                  return;
                }
                setState(() {
                  if(index-1<=0){
                    index = 1;
                  }
                  currentPageIndex = index-1;
                  widget.pageChange?.call(totalPages,index);
                });
              }catch(e){
                widget.errorInputCallback?.call();
              }
            },
            decoration: InputDecoration(
              hintText: widget.inputHintText,
              hintStyle: widget.inputHintTextStyle,
              isCollapsed: true,
              filled: widget.inputBgColor != null,
              fillColor: widget.inputBgColor,
              isDense: true,
              enabledBorder: widget.outlineInputTextBorder,
              border: widget.outlineInputTextBorder,
              focusedBorder: widget.outlineInputTextBorder,
              errorBorder: widget.outlineInputTextBorder,
              focusedErrorBorder: widget.outlineInputTextBorder,
              contentPadding: widget.inputContentPadding,
            ),
          ),
          _text(widget.suffixText),
        ],
      ) ;
    }
    return const SizedBox();
  }
}

class PagerIndicator extends StatefulWidget {

  final PagerItemTypes type;
  final int? index;
  final int? currentPageIndex;
  final bool isFocused;
  final BoxBorder? focusBorder;
  final double borderRadius;
  final Color pageIndicatorColor;
  final Color pageIndicatorActiveColor;
  final double pageTextSize;
  final double pageIndicatorHeight;
  final Color checkedPageColor;
  final BoxDecoration? checkedPageBoxDecoration;

  const PagerIndicator({
    required this.type,
    this.index,
    this.currentPageIndex,
    this.isFocused = false,
    this.focusBorder,
    this.borderRadius = 10,
    this.pageIndicatorColor = Colors.grey,
    this.pageIndicatorActiveColor = Colors.black,
    this.checkedPageColor = Colors.black,
    this.checkedPageBoxDecoration,
    this.pageTextSize = 14,
    this.pageIndicatorHeight = 30,
    Key? key,
  }):super(key: key);

  @override
  State<PagerIndicator> createState() => _PagerIndicatorState();
}

class _PagerIndicatorState extends State<PagerIndicator> {
  @override
  Widget build(BuildContext context) {
    String itemName = "";
    switch (widget.type) {
      case PagerItemTypes.prev:
        itemName = "<";
        break;
      case PagerItemTypes.next:
        itemName = ">";
        break;
      case PagerItemTypes.ellipsis:
        itemName = "...";
        break;
      case PagerItemTypes.number:
        itemName = (widget.index! + 1).toString();
        break;
    }
    return MouseRegion(
      cursor: widget.index == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: Container(
        height: widget.pageIndicatorHeight,
        padding: EdgeInsets.symmetric(
            horizontal: widget.type == PagerItemTypes.ellipsis ? 0 : 10),
        decoration: widget.checkedPageBoxDecoration==null? BoxDecoration(
          border: widget.type == PagerItemTypes.ellipsis
              ? null
              : widget.isFocused?( widget.focusBorder??  Border.all(
              color:Colors.black)):null,
          borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
        )
        : ( widget.type == PagerItemTypes.next ||
            widget.type == PagerItemTypes.ellipsis ||
            widget.type == PagerItemTypes.prev ||
            widget.index != widget.currentPageIndex
        )?null:widget.checkedPageBoxDecoration,
        child: Center(
          child: Text(
            itemName,
            style: TextStyle(
              fontSize: widget.pageTextSize,
              color: widget.index == null
                  ? (widget.type == PagerItemTypes.ellipsis
                  ? widget.pageIndicatorActiveColor
                  : widget.pageIndicatorColor)
                  : widget.isFocused
                  ? widget.checkedPageColor
                  :widget.pageIndicatorActiveColor,
            ),
          ),
        ),
      ),
    );
  }
}