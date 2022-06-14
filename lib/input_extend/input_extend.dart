import 'dart:async';

import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/13
/// create_time: 18:07
/// describe: 输入框拓展带自动检索组件
///

typedef Builder = Widget Function(
    BuildContext context, InputExtentdState controller);

typedef Compare<T> = bool Function(List<T> data);

typedef CreateCheckedWidgets<T> = List<Widget> Function(
    List<T> checkDatas, InputExtentdState controller);

typedef OnchangeInput<String> = void Function(
    String value, InputExtentdState controller);

typedef InputDecorationStyle = InputDecoration Function(
    InputExtentdState controller);


class InputExtentd<T> extends StatefulWidget {

  ///自定义构建弹出窗样式
  final Builder builder;

  ///数据发生变化时的回调
  final OnchangeInput<String> onChanged;

  ///自定义选中后样式
  final CreateCheckedWidgets checkedWidgets;

  ///已选择的显示项宽度
  final double checkedItemWidth;
  ///
  final TextStyle inputTextStyle;

  ///输入框的背景样式
  final InputDecorationStyle? inputDecoration;
  final double? itemsBoxMaxWidth;
  final double? itemsBoxMixWidth;

  final double? itemsBoxMaxHeight;
  final double? itemsBoxMixHeight;
  final ScrollPhysics? physics;

  ///输入框中的初始数据
  final List<T>? initCheckedValue;

  ///触发搜索的间隔时间
  final int intervalTime;

  ///支持的最大选择数量
  final int maxChecked;

  ///是否启用 自动清除输入框中内容（在下拉选择后）
  final bool enableClickClear;

  ///是否允许多选
  final bool enableMultipleChoice;

  ///选中后是否自动关闭下拉
  final bool autoClose;

  ///输入框得到焦点即回调。
  final bool enableHasFocusCallBack;

  final PopConstraintBox? popConstraintBox;

  const InputExtentd(
      {required this.builder,
        required this.onChanged,
        required this.checkedWidgets,
        this.checkedItemWidth = 60,
        this.itemsBoxMaxWidth,
        this.itemsBoxMixWidth,
        this.itemsBoxMaxHeight,
        this.itemsBoxMixHeight,
        this.inputTextStyle = const TextStyle(color: Colors.black, fontSize: 16),
        this.inputDecoration,
        this.physics,
        this.intervalTime = 500,
        this.initCheckedValue,
        this.maxChecked = 100,
        this.enableClickClear = false,
        this.enableMultipleChoice = false,
        this.autoClose = false,
        this.enableHasFocusCallBack = false,
        this.popConstraintBox,
        Key? key})
      : super(key: key);

  @override
  InputExtentdState createState() => InputExtentdState();
}

class InputExtentdState<T> extends State<InputExtentd> {
  final FocusNode _focusNode = FocusNode();

  ///关联输入框，处理在组价在列表中跟随滚动
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  ///提供给外部的控制器
  late InputExtentdState _controller;

  late final BuildContext _buildContext;

  List<T> _searchResultData = [];

  List<T> _checkedData = [];

  final TextEditingController _editingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _inputScrollController = ScrollController();
  late final int intervalTime;

  late List<T> initCheckedValue;
  Timer? _timer;

  @override
  void initState() {
    if (widget.initCheckedValue == null) {
      initCheckedValue = [];
    } else {
      initCheckedValue = widget.initCheckedValue!.cast<T>();
    }

    intervalTime = widget.intervalTime;
    _controller = this;
    _buildContext = context;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
        if (widget.enableHasFocusCallBack) {
          _onTextChangeCallBack(_editingController.text, true);
        }
      } else {
        _overlayEntry?.remove();
      }
    });
  }

  void setSearchData(List<T>? newData) {
    _searchResultData = newData ?? [];
    notyOverlayDataChange();
  }

  List<T> get getSearchData => _searchResultData;

  void setCheckedData(List<T>? checkedData) {
    setState(() {
      _checkedData = checkedData ?? [];
    });
  }

  List<T> get getCheckedData {
    if (mounted) {
      return initCheckedValue;
    } else {
      return [];
    }
  }

  TextEditingController get getTextController => _editingController;

  ///返回输入框的滑动控制器
  ScrollController get getInputScrollController => _inputScrollController;

  Future<bool> updateCheckedData(T data, Compare compare) {
    if (widget.maxChecked <= widget.initCheckedValue!.length) {
      return Future.value(false);
    }

    bool isChecked = compare(widget.initCheckedValue!);
    var initValue = widget.initCheckedValue!;
    if (widget.enableMultipleChoice) {
      if (isChecked) {
        initValue.remove(data);
      } else {
        initValue.add(data);
      }
    } else {
      if (!isChecked) {
        widget.initCheckedValue!.clear();
        widget.initCheckedValue!.add(data);
      } else {
        initValue.remove(data);
      }
    }

    var offset = _checkedData.length * widget.checkedItemWidth +
        widget.checkedItemWidth * 10 +
        _editingController.text.length;

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(offset);
    }

    if (widget.enableClickClear) {
      _editingController.text = "";
    }

    ///刷新搜索列表
    notyOverlayDataChange();

    ///刷新输入框组件
    notyListUiChange();

    if (widget.autoClose) {
      _focusNode.unfocus();
    }

    return Future.value(true);
  }

  void setText(String text) {
    // _editingController.text = text;
    _editingController.selection = TextSelection.collapsed(offset: text.length);
    if (_inputScrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _inputScrollController.animateTo(
            _inputScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
      });
    }
  }

  // ignore: unused_element
  List<double?> _setPopSize() {
    List<double?> sizeInfo = [];
    if (widget.popConstraintBox != null) {
      var boxSize = widget.popConstraintBox;

      ///允许无线延伸
      bool? isLimit = boxSize?.limitSize;
      if (null != isLimit && isLimit) {
        ///不限制宽高
        sizeInfo.add(null);
        sizeInfo.add(null);
      } else {
        ///设置约束条件
        sizeInfo.add(boxSize?.width);
        sizeInfo.add(boxSize?.height);
      }
    }
    return sizeInfo;
  }

  ///创建搜索弹窗
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var popBox = widget.popConstraintBox;
    return OverlayEntry(
        builder: (context) => Positioned(
          width: popBox == null
              ? size.width
              : popBox.limitSize
              ? null
              : popBox.width,
          height: popBox?.height,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: widget.builder.call(_buildContext, _controller),
          ),
        ));
  }

  ///外部构建传入选中后的数据样式
  List<Widget> createCheckedWidget() {
    return widget.checkedWidgets(_checkedData, _controller);
  }


  void _initData() {
    var initValue = widget.initCheckedValue;
    _checkedData.clear();
    if (initValue is List<T>) {
      for (var element in initValue) {
        _checkedData.add(element);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: widget.itemsBoxMaxWidth ?? 100,
                maxHeight: widget.itemsBoxMaxHeight ?? 40,
                minHeight: widget.itemsBoxMixHeight ?? 0,
                minWidth: widget.itemsBoxMixWidth ?? 0),
            child: _checkedData.isEmpty
                ? const SizedBox(
              width: 0,
              height: 0,
            )
                : SingleChildScrollView(
              physics: widget.physics,
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: createCheckedWidget(),
              ),
            ),
          ),
          Expanded(
              child: TextFormField(
                focusNode: _focusNode,
                controller: _editingController,
                style: widget.inputTextStyle,
                scrollController: _inputScrollController,
                onChanged: (text) async {
                  _timer?.cancel();
                  _timer = Timer( Duration(milliseconds: intervalTime), () {
                    _onTextChangeCallBack(text, false);
                  });
                },
                decoration: widget.inputDecoration?.call(_controller),
              ))
        ],
      ),
    );
  }

  void _onTextChangeCallBack(String text, bool isFirst) {
    setText(text);
    if ("" == text && !isFirst) {
      _focusNode.unfocus();
    }
    if (isFirst) {
      widget.onChanged.call(text, _controller);
    } else {
      widget.onChanged.call(text, _controller);
    }
  }

  void notyOverlayDataChange() {
    _overlayEntry?.markNeedsBuild();
  }

  void notyListUiChange() {
    if (mounted) {
      setState(() {});
    }
  }
}

///约束浮层的条件
class PopConstraintBox {
  double? width;
  double? height;

  ///limitSize 为真，则约束宽度无效，可无限延伸
  final bool limitSize;

  PopConstraintBox({this.width, this.height, this.limitSize = false});
}
