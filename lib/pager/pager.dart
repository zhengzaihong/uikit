import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../input/style/outline_input_text_border.dart';
import '../input/view/input_text.dart';

/// author:郑再红
/// email:1096877329@qq.com
/// date: 2024/1/23
/// time: 16:57
/// describe: 分页组件 - 支持主题配置的企业级分页器
/// Enterprise-level pagination component with theme support
///
/// ## 功能特性 / Features
/// - 🎨 主题系统 - 内置多种预设主题,支持自定义 / Theme system with presets
/// - 📄 页码显示 - 智能省略号,可配置显示范围 / Smart ellipsis, configurable range
/// - 🔢 输入跳转 - 支持输入框快速跳转页码 / Input box for quick page jump
/// - 🎯 完全自定义 - 支持自定义样式和行为 / Fully customizable style and behavior
/// - 📱 响应式设计 - 适配不同屏幕尺寸 / Responsive design
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 使用默认主题
/// Pager(
///   totalCount: 1000,
///   pageEach: 20,
///   currentPage: 1,
///   pageChange: (totalPages, currentPage) {
///     print('当前页: $currentPage');
///   },
/// )
///
/// // 使用预设主题
/// Pager(
///   totalCount: 500,
///   pageEach: 10,
///   currentPage: 1,
///   theme: PagerTheme.blueTheme,
///   pageChange: (totalPages, currentPage) {
///     print('页码: $currentPage');
///   },
/// )
///
/// // 自定义主题
/// Pager(
///   totalCount: 200,
///   pageEach: 15,
///   currentPage: 1,
///   theme: PagerTheme.defaultTheme.copyWith(
///     pageIndicatorActiveColor: Colors.purple,
///     checkedPageColor: Colors.white,
///     checkedPageBoxDecoration: BoxDecoration(
///       color: Colors.purple,
///       borderRadius: BorderRadius.circular(8),
///     ),
///   ),
///   pageChange: (totalPages, currentPage) {
///     // 处理页码变化
///   },
/// )
///
/// // 暗色主题
/// Pager(
///   totalCount: 300,
///   pageEach: 20,
///   currentPage: 1,
///   theme: PagerTheme.darkTheme,
///   pageChange: (totalPages, currentPage) {
///     print('页码: $currentPage');
///   },
/// )
/// ```
/// eg:
//      Pager(
//           key: ValueKey(DateTime.now().microsecondsSinceEpoch),
//           pagerInputType: PagerInputType.none,
//           totalCount: provider.patientListEntity.total ?? 0,
//           pageEach: provider.pageSize,
//           currentPage: provider.pageNumber,
//           pageIndicatorActiveColor: Colors.black,
//           pageIndicatorColor: Colors.grey,
//           checkedPageColor: Colors.black,
//           checkedPageBoxDecoration: BoxDecoration(
//               color: ColorsUtil.color_3EC3CF,
//               borderRadius: BorderRadius.all(Radius.circular(10))
//           ),
//           pageIndicatorHeight: 30,
//           pageTextSize: 26.sp,
//           showEllipsis: true,
//           sideDiff: 1,
//           focusBorder: Border.all(color:ColorsUtil.color_3EC3CF),
//           textStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 26.sp,
//           ),
//           inputContentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//           outlineInputTextBorder: const OutlineInputTextBorder(
//             borderSide: BorderSide(
//               color:ColorsUtil.color_3EC3CF,
//               width: 1.0,
//             ),
//             childBorderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           errorInputCallback: (){
//             showToast("请输入正确的页码");
//           },
//           pageChange: (totalPages, currentPageIndex) {
//             if(provider.pageNumber == currentPageIndex){
//               return;
//             }
//             provider.pageNumber = currentPageIndex;
//             provider.getPatientList();
//           },
//         ),
///
/// ## 注意事项 / Notes
/// - 使用 theme 参数可以快速应用预设主题 / Use theme for quick preset styles
/// - 单独设置的样式参数会覆盖主题中的值 / Individual params override theme
/// - 内置主题: defaultTheme, blueTheme, greenTheme, darkTheme / Built-in themes
/// - 可以使用 copyWith 方法自定义主题 / Use copyWith to customize theme
/// - totalCount 为总数据量,pageEach 为每页数量 / totalCount is total, pageEach is per page
/// - currentPage 从 1 开始计数 / currentPage starts from 1
/// - pageChange 回调返回的 currentPage 也是从 1 开始 / Callback returns 1-based index

enum PagerItemTypes { prev, next, ellipsis, number }

enum PagerInputType { input, select, none }

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

  /// 左右边距 ....
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
  final Color? prevColor;
  final Color? nextColor;
  final Color? ellipsisColor;

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

  /// 主题配置 / Theme configuration
  /// 
  /// 使用主题可以快速应用预设样式
  /// Use theme to quickly apply preset styles
  /// 
  /// 注意: 单独设置的样式参数会覆盖主题中的对应值
  /// Note: Individual style parameters will override theme values
  final PagerTheme? theme;

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
    this.isEnterCallback = false,
    this.textStyle = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
    this.pageSizeList,
    this.sideDiff = 2,
    this.showEllipsis = false,
    this.prevColor,
    this.nextColor,
    this.ellipsisColor,
    this.inputContentPadding =
        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    this.inputHeight = 30,
    this.inputWidth = 50,
    this.inputController,
    this.outlineInputTextBorder = const OutlineInputTextBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
    this.theme,
  }) : super(key: key);

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
    currentPageIndex = widget.currentPage - 1;
    if (currentPageIndex < 0) {
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
        if (pageInputController.text.isNotEmpty) {
          pageInputController.text = '';
          return;
        }
        widget.pageChange!(totalPages, currentPageIndex + 1);
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

    if ((currentPageIndex - widget.sideDiff) > 1 && widget.showEllipsis) {
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

    // if(currentPageIndex < totalPages - 2 - widget.sideDiff){
    //   for (int i = 0; i <  widget.sideDiff; i++) {
    //     indexesBetweenEllipses.add(totalPages - 2 -  widget.sideDiff-i);
    //   }
    // }

    for (var i = 0; i < indexesBetweenEllipses.length; i++) {
      int index = indexesBetweenEllipses[i];

      /// 添加数字页码ui
      pageItems.add(pageItem(_buildIndicator(
        type: PagerItemTypes.number,
        index: index,
        isFocused: currentPageIndex == index,
      )));
    }

    if (widget.showEllipsis) {
      if (currentPageIndex < totalPages - 2 - widget.sideDiff) {
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
    pageItems.add(pageItem(_buildIndicator(
        type: PagerItemTypes.next,
        index:
            currentPageIndex < totalPages - 1 ? currentPageIndex + 1 : null)));
    if (widget.isEnterCallback) {
      executeCallback();
    }
    return pageItems;
  }

  PagerIndicator _buildIndicator(
      {required PagerItemTypes type, int? index, bool isFocused = false}) {
    // 应用主题配置 / Apply theme configuration
    final effectiveTheme = widget.theme ?? PagerTheme.defaultTheme;
    
    return PagerIndicator(
        type: type,
        index: index,
        isFocused: isFocused,
        pageIndicatorActiveColor: widget.pageIndicatorActiveColor,
        pageIndicatorColor: widget.pageIndicatorColor,
        focusBorder: widget.focusBorder ?? effectiveTheme.focusBorder,
        borderRadius: widget.borderRadius,
        pageTextSize: widget.pageTextSize,
        pageIndicatorHeight: widget.pageIndicatorHeight,
        checkedPageColor: widget.checkedPageColor,
        checkedPageBoxDecoration: widget.checkedPageBoxDecoration ?? effectiveTheme.checkedPageBoxDecoration,
        currentPageIndex: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageItems = generatePager();
    
    // 应用主题配置 / Apply theme configuration
    final effectiveTheme = widget.theme ?? PagerTheme.defaultTheme;
    final effectiveTextStyle = widget.textStyle ?? effectiveTheme.textStyle;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _text(widget.totalText.replaceAll("%s", widget.totalCount.toString()), effectiveTextStyle),
        ...pageItems.map((pageItem) {
          return pageItem;
        }).toList(),
        _buildPageInputType(effectiveTheme, effectiveTextStyle),
      ],
    );
  }

  Widget _text(String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  Widget _buildPageInputType(PagerTheme effectiveTheme, TextStyle? effectiveTextStyle) {
    if (widget.pagerInputType == PagerInputType.input) {
      // 使用主题或单独配置的值
      final inputWidth = widget.inputWidth;
      final inputTextStyle = widget.inputTextStyle ?? effectiveTheme.inputTextStyle;
      final inputHintTextStyle = widget.inputHintTextStyle ?? effectiveTheme.inputHintTextStyle;
      final inputBgColor = widget.inputBgColor ?? effectiveTheme.inputBgColor;
      final outlineInputTextBorder = widget.outlineInputTextBorder;
      final inputContentPadding = widget.inputContentPadding ?? effectiveTheme.inputContentPadding;
      
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _text(widget.prevText, effectiveTextStyle),
          InputText(
            width: inputWidth,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            controller: pageInputController,
            allLineBorder: outlineInputTextBorder,
            scrollPadding: const EdgeInsets.all(0),
            enableClear: false,
            style: inputTextStyle,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSubmitted: (text) {
              try {
                int index = int.parse(text);
                if (index > totalPages) {
                  widget.errorInputCallback?.call();
                  return;
                }
                if (index <= 0) {
                  widget.errorInputCallback?.call();
                  return;
                }
                setState(() {
                  if (index - 1 <= 0) {
                    index = 1;
                  }
                  currentPageIndex = index - 1;
                  widget.pageChange?.call(totalPages, index);
                });
              } catch (e) {
                widget.errorInputCallback?.call();
              }
            },
            decoration: InputDecoration(
              hintText: widget.inputHintText,
              hintStyle: inputHintTextStyle,
              isCollapsed: true,
              filled: inputBgColor != null,
              fillColor: inputBgColor,
              isDense: true,
              enabledBorder: outlineInputTextBorder,
              border: outlineInputTextBorder,
              focusedBorder: outlineInputTextBorder,
              errorBorder: outlineInputTextBorder,
              focusedErrorBorder: outlineInputTextBorder,
              contentPadding: inputContentPadding,
            ),
          ),
          _text(widget.suffixText, effectiveTextStyle),
        ],
      );
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
  }) : super(key: key);

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
        decoration: widget.checkedPageBoxDecoration == null
            ? BoxDecoration(
                border: widget.type == PagerItemTypes.ellipsis
                    ? null
                    : widget.isFocused
                        ? (widget.focusBorder ??
                            Border.all(color: Colors.black))
                        : null,
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
              )
            : (widget.type == PagerItemTypes.next ||
                    widget.type == PagerItemTypes.ellipsis ||
                    widget.type == PagerItemTypes.prev ||
                    widget.index != widget.currentPageIndex)
                ? null
                : widget.checkedPageBoxDecoration,
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
                      : widget.pageIndicatorActiveColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// 分页器主题配置 / Pager Theme Configuration
///
/// 提供统一的分页器样式配置
/// Provides unified pager style configuration
class PagerTheme {
  /// 文本样式 / Text style
  final TextStyle? textStyle;

  /// 页码指示器颜色 / Page indicator color
  final Color pageIndicatorColor;

  /// 页码指示器激活颜色 / Page indicator active color
  final Color pageIndicatorActiveColor;

  /// 选中页码颜色 / Checked page color
  final Color checkedPageColor;

  /// 选中页码背景装饰 / Checked page box decoration
  final BoxDecoration? checkedPageBoxDecoration;

  /// 页码文本大小 / Page text size
  final double pageTextSize;

  /// 页码指示器高度 / Page indicator height
  final double pageIndicatorHeight;

  /// 边框圆角 / Border radius
  final double borderRadius;

  /// 焦点边框 / Focus border
  final BoxBorder? focusBorder;

  /// 输入框样式 / Input style
  final TextStyle? inputTextStyle;

  /// 输入框提示样式 / Input hint style
  final TextStyle? inputHintTextStyle;

  /// 输入框背景色 / Input background color
  final Color? inputBgColor;

  /// 输入框边框 / Input border
  final OutlineInputTextBorder? outlineInputTextBorder;

  /// 输入框内边距 / Input content padding
  final EdgeInsetsGeometry? inputContentPadding;

  /// 输入框高度 / Input height
  final double inputHeight;

  /// 输入框宽度 / Input width
  final double inputWidth;

  const PagerTheme({
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    this.pageIndicatorColor = Colors.grey,
    this.pageIndicatorActiveColor = Colors.black,
    this.checkedPageColor = Colors.black,
    this.checkedPageBoxDecoration,
    this.pageTextSize = 14,
    this.pageIndicatorHeight = 30,
    this.borderRadius = 10,
    this.focusBorder,
    this.inputTextStyle,
    this.inputHintTextStyle,
    this.inputBgColor,
    this.outlineInputTextBorder = const OutlineInputTextBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      childBorderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    this.inputContentPadding = const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    this.inputHeight = 30,
    this.inputWidth = 50,
  });

  /// 默认主题 / Default theme
  static const PagerTheme defaultTheme = PagerTheme();

  /// 蓝色主题 / Blue theme
  static PagerTheme blueTheme = PagerTheme(
    pageIndicatorActiveColor: Colors.blue,
    checkedPageColor: Colors.white,
    checkedPageBoxDecoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
    focusBorder: Border.all(color: Colors.blue, width: 2),
    outlineInputTextBorder: const OutlineInputTextBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.0),
      childBorderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  /// 绿色主题 / Green theme
  static PagerTheme greenTheme = PagerTheme(
    pageIndicatorActiveColor: Colors.green,
    checkedPageColor: Colors.white,
    checkedPageBoxDecoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10),
    ),
    focusBorder: Border.all(color: Colors.green, width: 2),
    outlineInputTextBorder: const OutlineInputTextBorder(
      borderSide: BorderSide(color: Colors.green, width: 1.0),
      childBorderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  /// 暗色主题 / Dark theme
  static PagerTheme darkTheme = PagerTheme(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    pageIndicatorColor: Colors.grey.shade600,
    pageIndicatorActiveColor: Colors.white,
    checkedPageColor: Colors.black,
    checkedPageBoxDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    focusBorder: Border.all(color: Colors.white, width: 2),
    inputTextStyle: const TextStyle(color: Colors.white),
    inputBgColor: Colors.grey.shade800,
    outlineInputTextBorder: OutlineInputTextBorder(
      borderSide: BorderSide(color: Colors.grey.shade600, width: 1.0),
      childBorderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
  );

  /// 复制并修改主题 / Copy with modifications
  PagerTheme copyWith({
    TextStyle? textStyle,
    Color? pageIndicatorColor,
    Color? pageIndicatorActiveColor,
    Color? checkedPageColor,
    BoxDecoration? checkedPageBoxDecoration,
    double? pageTextSize,
    double? pageIndicatorHeight,
    double? borderRadius,
    BoxBorder? focusBorder,
    TextStyle? inputTextStyle,
    TextStyle? inputHintTextStyle,
    Color? inputBgColor,
    OutlineInputTextBorder? outlineInputTextBorder,
    EdgeInsetsGeometry? inputContentPadding,
    double? inputHeight,
    double? inputWidth,
  }) {
    return PagerTheme(
      textStyle: textStyle ?? this.textStyle,
      pageIndicatorColor: pageIndicatorColor ?? this.pageIndicatorColor,
      pageIndicatorActiveColor: pageIndicatorActiveColor ?? this.pageIndicatorActiveColor,
      checkedPageColor: checkedPageColor ?? this.checkedPageColor,
      checkedPageBoxDecoration: checkedPageBoxDecoration ?? this.checkedPageBoxDecoration,
      pageTextSize: pageTextSize ?? this.pageTextSize,
      pageIndicatorHeight: pageIndicatorHeight ?? this.pageIndicatorHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      focusBorder: focusBorder ?? this.focusBorder,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      inputHintTextStyle: inputHintTextStyle ?? this.inputHintTextStyle,
      inputBgColor: inputBgColor ?? this.inputBgColor,
      outlineInputTextBorder: outlineInputTextBorder ?? this.outlineInputTextBorder,
      inputContentPadding: inputContentPadding ?? this.inputContentPadding,
      inputHeight: inputHeight ?? this.inputHeight,
      inputWidth: inputWidth ?? this.inputWidth,
    );
  }
}