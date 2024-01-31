
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/edit_text/input_text.dart';
import 'package:flutter_uikit_forzzh/edit_text/outline_input_text_border.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/1/23
/// create_time: 16:57
/// describe: 分页组件
///

enum PagerItemTypes { prev, next, ellipsis, number }
typedef PagerClickCallback = void Function(int totalPages, dynamic currentPageIndex);

class Pager extends StatefulWidget {
  final int totalCount;
  final int pageEach;
  final PagerClickCallback? callback;
  final Function()? errorInputCallback;
  const Pager({
    Key? key,
    required this.totalCount,
    required this.pageEach,
    this.callback,
    this.errorInputCallback,
  }):super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
   int sideDiff = 2;
  // late int sideDiff;

  // 总页数
  late int totalPages;
  int? lastTotalPages;
  int? lastCurrentPageIndex;

  // 每页的数据数量
  late int pageEach;

  // 当前所在页
  int currentPageIndex = 0;

  TextEditingController gotoControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    pageEach = widget.pageEach;
    initData();
  }

  void initData() {
    totalPages = (widget.totalCount / pageEach).ceil();
    currentPageIndex = 0;
  }

  executeCallback() {
    if (widget.callback != null) {
      if ((lastTotalPages == null || lastCurrentPageIndex == null) ||
          (lastTotalPages != totalPages ||
              lastCurrentPageIndex != currentPageIndex)) {
        lastTotalPages = totalPages;
        lastCurrentPageIndex = currentPageIndex;
        widget.callback!(totalPages, currentPageIndex);
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
    pageItems.add(pageItem(PagerIndicator(
      type: PagerItemTypes.prev,
      index: currentPageIndex > 0 ? currentPageIndex - 1 : null,
    )));
    /// 添加第一页（首页）
    pageItems.add(pageItem(PagerIndicator(
      type: PagerItemTypes.number,
      index: 0,
      isFocused: currentPageIndex == 0,
    )));

    if((currentPageIndex - sideDiff)> 1){
      pageItems.add(pageItem(const PagerIndicator(
        type: PagerItemTypes.ellipsis,
        index: null,
      )));
    }

    /// 添加数字number list
    List<int> indexesBetweenEllipses = [];
    int index = max(1, currentPageIndex - sideDiff);

    int minIndex = min(currentPageIndex + sideDiff, totalPages - 2);
     /// 居中模式
    for (; index <= minIndex; index++) {
      indexesBetweenEllipses.add(index);
    }
    // if(currentPageIndex < totalPages - 2 - sideDiff){
    //  for (int i = 0; i < sideDiff; i++) {
    //    indexesBetweenEllipses.add(totalPages - 2 - sideDiff-i);
    //  }
    // }

    for (var i = 0; i < indexesBetweenEllipses.length; i++) {
      int index = indexesBetweenEllipses[i];
      /// 添加数字页码ui
      pageItems.add(pageItem(PagerIndicator(
        type: PagerItemTypes.number,
        index: index,
        isFocused: currentPageIndex == index,
      )));
    }

    if(currentPageIndex < totalPages - 2- sideDiff){
      pageItems.add(pageItem(const PagerIndicator(
        type: PagerItemTypes.ellipsis,
        index: null,
      )));
    }
    /// 尾页
    if (totalPages > 1) {
      pageItems.add(pageItem(PagerIndicator(
        type: PagerItemTypes.number,
        index: totalPages - 1,
        isFocused: currentPageIndex == totalPages - 1,
      )));
    }

    /// next
    pageItems.add(pageItem(PagerIndicator(
      type: PagerItemTypes.next,
      index: currentPageIndex < totalPages - 1 ? currentPageIndex + 1 : null,
    )));
    executeCallback();
    return pageItems;
  }

  Widget text(String text) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:Colors.black),
        ),
      ),
    );
  }

  final outlineInputTextBorder = const OutlineInputTextBorder(
    borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0
    ),
    childBorderRadius: BorderRadius.all(Radius.circular(5)),
  );


  @override
  Widget build(BuildContext context) {
    List<Widget> pageItems = generatePager();
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          text("共\t${widget.totalCount}\t条"),
          ...pageItems.map((pageItem) {
            return Container(
              child: pageItem,
            );
          }).toList(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              text("前往"),
              InputText(
                width: 50,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                controller: gotoControl,
                allLineBorder: outlineInputTextBorder,
                enableClear: false,
                style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
                onSubmitted: (text){
                  try{
                    int index = int.parse(text);
                    if(index > totalPages){
                      widget.errorInputCallback?.call();
                      return;
                    }
                    if(index < 0){
                      widget.errorInputCallback?.call();
                      return;
                    }
                    setState(() {
                      if(index-1<=0){
                        index = 1;
                      }
                      currentPageIndex = index-1;
                      widget.callback?.call(totalPages,index);
                    });
                  }catch(e){
                    widget.errorInputCallback?.call();
                  }
                },
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  isCollapsed: false,
                  isDense: true,
                  enabledBorder: outlineInputTextBorder,
                  border: outlineInputTextBorder,
                  focusedBorder: outlineInputTextBorder,
                  errorBorder: outlineInputTextBorder,
                  focusedErrorBorder: outlineInputTextBorder,
                  // contentPadding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                ),
              ),
              text("页"),
            ],
          ),
        ],
      ),
    );
  }
}

class PagerIndicator extends StatefulWidget {

  final PagerItemTypes type;
  final int? index;
  final bool isFocused;
  const PagerIndicator({
    required this.type,
    this.index,
    this.isFocused = false,
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
        height: 30,
        padding: EdgeInsets.symmetric(
            horizontal: widget.type == PagerItemTypes.ellipsis ? 0 : 10),
        decoration: BoxDecoration(
          border: widget.type == PagerItemTypes.ellipsis
              ? null
              : Border.all(
              color:
              widget.isFocused ? const Color(0xffc4c77ff ): Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // color: widget.isFocused ? const Color(0xff5078F0) : null,
        ),
        child: Center(
          child: Text(
            itemName,
            style: TextStyle(
              fontSize: 14,
              color: widget.index == null
                  ? (widget.type == PagerItemTypes.ellipsis
                  ? Colors.black
                  : Colors.grey)
                  : widget.isFocused
                  ?  const Color(0xffc4c77ff )
                  :Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}