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
  final Builder builder;

  final OnchangeInput<String> onChanged;

  final CreateCheckedWidgets checkedWidgets;

  final double checkedItemWidth;
  final TextStyle inputTextStyle;

  final InputDecorationStyle? inputDecoration;
  final double? itemsBoxMaxWidth;
  final double? itemsBoxMixWidth;

  final double? itemsBoxMaxHeight;
  final double? itemsBoxMixHeight;
  final ScrollPhysics? physics;

  final List<T>? initCheckedValue;

  final int intervalTime;

  final int maxChecked;

  final bool enableClickClear;

  final bool enableMultipleChoice;
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
  late final int intervalTime;

  @override
  void initState() {

    intervalTime = widget.intervalTime;
    var initValue = widget.initCheckedValue;

    if (null != initValue && initValue is List<T>) {
      initValue.forEach((element) {
        _checkedData.add(element);
      });
    }
    _controller = this;
    _buildContext = context;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
        if(widget.enableHasFocusCallBack){
          _onTextChangeCallBack(_editingController.text,true);
        }

      } else {
        _overlayEntry?.remove();
      }
    });
  }

  void setSearchResultData(List<T>? newData) {
    _searchResultData = newData ?? [];
    notyOverlayDataChange();
  }

  List<T> get getSearchData => _searchResultData;

  void setCheckedData(List<T>? checkedData) {
    setState(() {
      _checkedData = checkedData ?? [];
    });
  }

  List<T> get getCheckedData => _checkedData;

  TextEditingController get getTextController => _editingController;

  Future<bool> updateCheckedData(T data, Compare compare) {
    if (widget.maxChecked <= getCheckedData.length) {
      return Future.value(false);
    }

    bool isChecked = compare(getCheckedData);
    if (widget.enableMultipleChoice) {
      if (isChecked) {
        _checkedData.remove(data);
      } else {
        _checkedData.add(data);
      }
    } else {
      _checkedData.clear();
      if (!isChecked) {
        _checkedData.add(data);
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



  List<double?> _setPopSize(){
    List<double?> sizeInfo = [];
    if(widget.popConstraintBox!=null){
      var boxSize = widget.popConstraintBox;
      ///允许无线延伸
      bool? isLimit = boxSize?.limitSize;
      if(null!=isLimit && isLimit){
        ///不限制宽高
        sizeInfo.add(null);
        sizeInfo.add(null);
      }else{
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
              width:popBox== null?size.width:popBox.limitSize?null:popBox.width,
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
    return widget.checkedWidgets(getCheckedData, _controller);
  }

  var lastTime = DateTime.now();

  bool intervalSearch() {
    if (DateTime.now().difference(lastTime) >
        Duration(milliseconds: intervalTime)) {
      lastTime = DateTime.now();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
            onChanged: (text) async {
              _onTextChangeCallBack(text,false);
            },
            decoration: widget.inputDecoration?.call(_controller),
          ))
        ],
      ),
    );
  }



  void _onTextChangeCallBack(String text,bool isFirst){
    _editingController.text = text;
    _editingController.selection =
        TextSelection.collapsed(offset: text.length);
    if ("" == text && !isFirst) {
      _focusNode.unfocus();
    }
    if(isFirst){
      widget.onChanged.call(text, _controller);
    }else{
      bool flag = intervalSearch();
      if (flag) {
        widget.onChanged.call(text, _controller);
      }
    }
  }




  void notyOverlayDataChange() {
    _overlayEntry?.markNeedsBuild();
  }

  void notyListUiChange() {
    setState(() {});
  }
}


///约束浮层的条件
class PopConstraintBox{

  double? width;
  double? height;

  ///limitSize 为真，则约束宽度无效，可无限延伸
  final bool limitSize;

  PopConstraintBox({this.width,this.height,this.limitSize=false});


}