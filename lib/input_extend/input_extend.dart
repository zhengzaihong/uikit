import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/13
/// create_time: 18:07
/// describe: 输入框拓展带自动检索组件
///

typedef Builder = Widget Function(BuildContext context, InputExtentdState controller);

typedef Compare<T> =  bool Function(List<T> data);

typedef CreateCheckedWidgets<T> = List<Widget> Function(List<T> checkDatas,InputExtentdState controller);

typedef OnchangeInput<String> = void Function(String value,InputExtentdState controller);


class InputExtentd<T> extends StatefulWidget {

  final Builder builder;

  final OnchangeInput<String> onChanged;

  final CreateCheckedWidgets checkedWidgets;

  final double checkedItemWidth;
  final TextStyle inputTextStyle;
  final InputDecoration? inputDecoration;
  final double? itemsBoxMaxWidth;
  final double? itemsBoxMixWidth;

  final double? itemsBoxMaxHeight;
  final double? itemsBoxMixHeight;
  final ScrollPhysics? physics;

  final List<T>? initCheckedValue;

  final int intervalTime;

  final int maxChecked;

  const InputExtentd({
    required this.builder,
    required this.onChanged,
    required this.checkedWidgets,
    this.checkedItemWidth = 60,
    this.itemsBoxMaxWidth,
    this.itemsBoxMixWidth,
    this.itemsBoxMaxHeight,
    this.itemsBoxMixHeight,
    this.inputTextStyle =const TextStyle(color: Colors.black,fontSize: 16),
    this.inputDecoration,
    this.physics,
    this.intervalTime = 500,
    this.initCheckedValue,
    this.maxChecked = 100,
    Key? key}) : super(key: key);

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

    if(null!=initValue && initValue is List<T>){
      _checkedData = initValue;
    }
    _controller = this;
    _buildContext = context;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
      } else {
        _overlayEntry?.remove();
      }
    });
  }

  void setSearchResultData(List<T>? newData) {
    _searchResultData = newData ?? [];
    notyDataChange();
  }

  List<T> get getSearchData => _searchResultData;
  void setCheckedData(List<T>? checkedData) {
    setState(() {
      _checkedData = checkedData ?? [];
    });
  }

  List<T> get getCheckedData => _checkedData;


  Future<bool> updateCheckedData(T data,Compare compare) {

    if(widget.maxChecked>getCheckedData.length){
      return Future.value(false);
    }

    bool isChecked = compare(getCheckedData);
    if (isChecked) {
      _checkedData.remove(data);
    }else{
      _checkedData.add(data);
    }

    var offset = _checkedData.length*widget.checkedItemWidth+
        widget.checkedItemWidth*10+
        _editingController.text.length;


    if(_scrollController.hasClients){
      _scrollController.jumpTo(offset);
    }

    ///刷新搜索列表
    notyDataChange();

    ///刷新输入框组件
    notyUiChange();

    return Future.value(true);
  }

  ///创建搜索弹窗
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: widget.builder.call(_buildContext, _controller),
              ),
            ));
  }


  ///外部构建传入选中后的数据样式
  List<Widget> createCheckedWidget(){
    return  widget.checkedWidgets(getCheckedData,_controller);
  }



  var lastTime = DateTime.now();
  bool intervalSearch(){
    if(DateTime.now().difference(lastTime) > Duration(milliseconds: intervalTime)){
      lastTime = DateTime.now();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child:Row(
        children: [

          Container(
            constraints: BoxConstraints(
                maxWidth: widget.itemsBoxMaxWidth??100,
                maxHeight: widget.itemsBoxMaxHeight??40,
                minHeight: widget.itemsBoxMixHeight??0,
                minWidth: widget.itemsBoxMixWidth??0
            ),
            child: _checkedData.isEmpty
                ? const SizedBox(width: 0,height: 0,)
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
          Expanded(child: TextFormField(
            focusNode: _focusNode,
            controller: _editingController,
            style: widget.inputTextStyle,
            onChanged:(text) async {
              _editingController.text = text;
              _editingController.selection= TextSelection.collapsed(offset: text.length);
              bool flag = intervalSearch();
              if(flag){
                widget.onChanged.call(text,_controller);
              }
            },
            decoration: widget.inputDecoration,
          ))
        ],
      ),
    );
  }

  void notyDataChange() {
    _overlayEntry?.markNeedsBuild();
  }

  void notyUiChange(){
    setState(() {
    });
  }
}
