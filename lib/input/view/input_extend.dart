
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit/uikit_lib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/13
/// create_time: 18:07
/// describe: 输入框拓展带自动检索组件
///

typedef BuildSelectPop<T> = Widget Function(BuildContext context, List<T> src);

typedef Compare<T> = bool Function(List<T> data);

typedef CompareVO<T> = bool Function(T item);

typedef BuildCheckedBarStyle<T> = Widget? Function(T checkDatas);

typedef OnChangeInput<String> = void Function(String value);

typedef InputValueChanged<String> = void Function(String value);

typedef InputDecorationStyle<T> = InputDecoration Function(List<T> checkeds);

typedef OnCreate<T> = void Function();
typedef OnComplete<T> = void Function();

// @Deprecated("搜索弹出窗或者关联性结果数据展示效果使用 InputText 组件代替")
@Deprecated("Use InputText instead of search pop-up window or correlation result data display effect.")
class InputExtend<T> extends StatefulWidget {

  final InputExtendController? controller;

  ///自定义构建弹出窗样式
  final BuildSelectPop buildSelectPop;

  ///数据发生变化时的回调
  final OnChangeInput<String> onChanged;

  ///自定义选中后样式
  final BuildCheckedBarStyle? buildCheckedBarStyle;

  ///开始创建
  final OnCreate? onCreate;
  ///创建完成
  final OnComplete? onComplete;

  ///已选择的显示项宽度
  final double? checkedItemWidth;

  ///输入文本样式
  final TextStyle inputTextStyle;

  ///输入框的背景样式
  final InputDecorationStyle? inputDecoration;

  final double? checkedBarMaxWidth;
  final double? checkedBarMinWidth;

  final double? checkedBarMaxHeight;
  final double? checkedBarMinHeight;
  final ScrollPhysics? physics;

  ///输入框中的初始数据
  final List<T>? initCheckedValue;

  ///支持的最大选择数量
  final int maxChecked;

  ///是否启用 自动清除输入框中内容（在下拉选择后）
  final bool enableClickClear;

  ///是否允许多选
  final bool enableMultipleChoice;

  ///选中后是否自动关闭下拉
  final bool autoClose;
  final FocusNode? focusNode;

  ///输入框得到焦点即回调。
  final bool enableHasFocusCallBack;

  ///点击非遮罩层是否关闭
  final bool barrierDismissible;

  final PopBox? popBox;

  final Duration duration;
  final Curve curve;

  final double selectPopMarginTop;
  final InputValueChanged<String>? onSubmitted;

  /// 以下都为输入框的样式 属性
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final VoidCallback? onEditingComplete;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final TextEditingController? textEditingController;
  final ScrollController? scrollController ;
  final ScrollController? inputScrollController;


  final double? popElevation;
  final Color? popColor;
  final Color? popShadowColor;
  final Color? popSurfaceTintColor;
  final TextStyle? popChildTextStyle;
  final BorderRadiusGeometry? popBorderRadius;
  final ShapeBorder? popShape;


  const InputExtend(
      { required this.buildSelectPop,
        required this.onChanged,
        this.controller,
        this.buildCheckedBarStyle,
        this.focusNode,
        this.duration = const Duration(milliseconds: 300),
        this.curve = Curves.linear,
        this.checkedItemWidth = 60,
        this.checkedBarMaxWidth,
        this.checkedBarMinWidth,
        this.checkedBarMaxHeight,
        this.checkedBarMinHeight,
        this.inputTextStyle = const TextStyle(color: Colors.black, fontSize: 16),
        this.onCreate,
        this.onComplete,
        this.inputDecoration,
        this.physics,
        this.initCheckedValue,
        this.maxChecked = 100,
        this.enableClickClear = false,
        this.enableMultipleChoice = false,
        this.autoClose = false,
        this.enableHasFocusCallBack = false,
        this.barrierDismissible = true,
        this.popBox,
        this.selectPopMarginTop = 0,
        this.textEditingController,
        this.inputScrollController,
        this.scrollController,
        this.keyboardType,
        this.textInputAction,
        this.textCapitalization = TextCapitalization.none,
        this.strutStyle,
        this.textAlign = TextAlign.start,
        this.textAlignVertical,
        this.textDirection,
        this.readOnly = false,
        this.contextMenuBuilder,
        this.showCursor,
        this.autofocus = false,
        this.obscuringCharacter = '•',
        this.obscureText = false,
        this.autocorrect = true,
        this.smartDashesType,
        this.smartQuotesType,
        this.enableSuggestions = true,
        this.maxLines = 1,
        this.minLines,
        this.expands = false,
        this.maxLength,
        this.maxLengthEnforcement,
        this.onEditingComplete,
        this.onSubmitted,
        this.onAppPrivateCommand,
        this.inputFormatters,
        this.enabled,
        this.cursorWidth = 2.0,
        this.cursorHeight,
        this.cursorRadius,
        this.cursorColor,
        this.keyboardAppearance,
        this.scrollPadding = const EdgeInsets.all(20.0),
        this.dragStartBehavior = DragStartBehavior.start,
        this.enableInteractiveSelection,
        this.selectionControls,
        this.onTap,
        this.mouseCursor,
        this.buildCounter,
        this.scrollPhysics,
        this.autofillHints = const <String>[],
        this.clipBehavior = Clip.hardEdge,
        this.restorationId,
        this.scribbleEnabled = true,
        this.enableIMEPersonalizedLearning = true,
        this.popElevation = 0.0,
        this.popColor = Colors.transparent,
        this.popShadowColor,
        this.popSurfaceTintColor,
        this.popChildTextStyle,
        this.popBorderRadius,
        this.popShape,
        Key? key})
      : super(key: key);

  @override
  InputExtendState createState() => InputExtendState();
}

class InputExtendState<T> extends State<InputExtend> {

  late  FocusNode _focusNode;

  late  BuildContext _buildContext;

  ///搜索的数据
  List<T> _searchResultData = [];

  ///已选择数据
  List<T> _checkedData = [];

  late  TextEditingController _editingController;
  late  ScrollController _scrollController;
  late  ScrollController _inputScrollController;

  int oldSize = 0;

  ///关联输入框，处理在组价在列表中跟随滚动
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  StateSetter? _checkedBoxState;

  @override
  void initState() {
    super.initState();

    widget.controller?.bind(this);
     widget.onCreate?.call();

    _editingController = widget.textEditingController?? TextEditingController();
    _scrollController = widget.scrollController?? ScrollController();
    _inputScrollController = widget.inputScrollController?? ScrollController();
    _focusNode = widget.focusNode?? FocusNode();

    if (widget.initCheckedValue == null) {
      _checkedData = [];
    } else {
      List<T> temps = [];
      for (var element in widget.initCheckedValue!) {
        temps.add(element);
      }
      _checkedData = temps;
      oldSize = _checkedData.length;
    }

    _buildContext = context;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.enableHasFocusCallBack) {
        _onTextChangeCallBack(_editingController.text, true);
      }
    });

    if(widget.onComplete!=null){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onComplete?.call();
      });
    }
  }

  @override
  void didUpdateWidget(covariant InputExtend oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?.bind(this);
    }
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
      return _checkedData;
    } else {
      return [];
    }
  }


  ///
  /// data:需要比较的对象
  /// compare：比较器
  /// 说明：当是同一数据源则可以不传比较器，直接比较对象地址。
  /// 当非同一数据源时(网络接口等)，必须传入比较器，根据数据源字段信息比较(eg:id 等)
  ///
  Future<bool> setCheckChange({required T data, Compare? compare}) {
    final initValue = _checkedData;
    if (widget.maxChecked <= initValue.length) {
      return Future.value(false);
    }

    bool isChecked = false;

    ///如果外部不传入比较器 则默认比较对象是否一致
    if (compare == null) {
      isChecked = initValue.contains(data);
    } else {
      isChecked = compare(initValue);
    }

    ///多选
    if (widget.enableMultipleChoice) {
      if (isChecked) {
        initValue.remove(data);
      } else {
        initValue.add(data);
      }
    }

    ///单选
    if (!widget.enableMultipleChoice) {
      if (isChecked) {
        initValue.remove(data);
      } else {
        initValue.clear();
        initValue.add(data);
      }
    }

    if (widget.buildCheckedBarStyle != null) {
      final offset = _checkedData.length * widget.checkedItemWidth!+
          widget.checkedItemWidth! * 10 +
          _editingController.text.length;

      if (_scrollController.hasClients) {
        if (_checkedData.length > oldSize) {
          _scrollController.animateTo(offset,
              duration: widget.duration, curve: widget.curve);
        } else {
          _scrollController.jumpTo(offset);
        }
        oldSize = _checkedData.length;
      }
    }

    if (widget.enableClickClear) {
      _editingController.text = "";
    }

    ///刷新搜索列表
    notyOverlayDataChange();

    ///刷新输入框组件
    // notyListUiChange();
    notyCheckedBoxChange();



    if (widget.autoClose) {
      _removePop();
    }

    return Future.value(true);
  }



  TextEditingController get getTextController => _editingController;

  ///返回输入框的滑动控制器
  ScrollController get getInputScrollController => _inputScrollController;


  FocusNode get getFocusNode => _focusNode;


  void closePop(){
    _removePop();
  }

  TextEditingController? getTextEditingController() {
    return widget.textEditingController;
  }

  void setText(String text) {
    _editingController.text = text;
    _editingController.selection = TextSelection.collapsed(offset: text.length);
  }

  // ignore: unused_element
  List<double?> _setPopSize() {
    List<double?> sizeInfo = [];
    if (widget.popBox != null) {
      var boxSize = widget.popBox;

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
    var popBox = widget.popBox;
    return OverlayEntry(
        builder: (context) => Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.barrierDismissible
                  ? () {
                _removePop();
                ///让输入框失去焦点
                if(_focusNode.hasFocus){
                  _focusNode.unfocus();
                }
              } : null,
              child: const SizedBox(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Positioned(
              width: popBox == null
                  ? size.width
                  : popBox.limitSize
                  ? null
                  : popBox.width,
              height: popBox?.height,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + widget.selectPopMarginTop),
                child: Material(
                  elevation: widget.popElevation!,
                  shadowColor: widget.popShadowColor,
                  color: widget.popColor,
                  shape: widget.popShape,
                  borderRadius: widget.popBorderRadius,
                  surfaceTintColor: widget.popSurfaceTintColor,
                  textStyle: widget.popChildTextStyle,
                  child:  widget.buildSelectPop.call(_buildContext, getSearchData),
                ),
              ),
            ),
          ],
        ));
  }

  ///外部构建传入选中后的数据样式
  List<Widget> createCheckedWidget() {
    List<Widget> widgets = [];
    for (var element in _checkedData) {
      final widgetItem =
      widget.buildCheckedBarStyle?.call(element);
      if (null != widgetItem) {
        widgets.add(widgetItem);
      }
    }
    return widgets;
  }

  @override
  void dispose() {
    // _editingController.dispose();
    // _inputScrollController.dispose();
    // _focusNode.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  ///提供给同一个数据源集合的判断方法，实际中 通常不是
  bool isChecked(int index) {
    final bean = getSearchData[index];
    return getCheckedData.contains(bean);
  }

  ///提供不同数据源的比较，通常是边搜索，边比较是否选中
  bool isCheckedVO(CompareVO compareVO) {

    List list = getCheckedData;
    if(list.isEmpty){
      return false;
    }
    for (var item in list) {
      ///检查到外部有相等的内容 则认为是已包含此项
      if(compareVO.call(item)){
        return true;
      }
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        children: [
          widget.buildCheckedBarStyle != null
              ? Container(
            constraints: BoxConstraints(
                maxWidth: widget.checkedBarMaxWidth ?? 100,
                maxHeight: widget.checkedBarMaxHeight ?? 40,
                minHeight: widget.checkedBarMinHeight ?? 0,
                minWidth: widget.checkedBarMinWidth ?? 0),
            child: SingleChildScrollView(
              physics:widget.physics ?? const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: StatefulBuilder(
                builder: (context,state) {
                  _checkedBoxState = state;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: createCheckedWidget(),
                  );
                },
              ),
            ),
          )
              : const SizedBox.shrink(),
          Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _editingController,
                style: widget.inputTextStyle,
                scrollController: _inputScrollController,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                strutStyle: widget.strutStyle,
                textAlign: widget.textAlign,
                textAlignVertical: widget.textAlignVertical,
                textDirection: widget.textDirection,
                autofocus: widget.autofocus,
                obscuringCharacter: widget.obscuringCharacter,
                obscureText: widget.obscureText,
                smartDashesType: widget.smartDashesType,
                autocorrect: widget.autocorrect,
                smartQuotesType: widget.smartQuotesType,
                enableSuggestions: widget.enableSuggestions,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                expands: widget.expands,
                readOnly: widget.readOnly,
                contextMenuBuilder: widget.contextMenuBuilder,
                showCursor: widget.showCursor,
                maxLength: widget.maxLength,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                onEditingComplete: widget.onEditingComplete,
                onAppPrivateCommand: widget.onAppPrivateCommand,
                inputFormatters: widget.inputFormatters,
                enabled: widget.enabled,
                cursorWidth: widget.cursorWidth,
                cursorHeight: widget.cursorHeight,
                cursorRadius: widget.cursorRadius,
                keyboardAppearance: widget.keyboardAppearance,
                scrollPadding: widget.scrollPadding,
                enableInteractiveSelection: widget.enableInteractiveSelection,
                selectionControls: widget.selectionControls,
                dragStartBehavior: widget.dragStartBehavior,
                onTap: widget.onTap,
                mouseCursor: widget.mouseCursor,
                buildCounter: widget.buildCounter,
                scrollPhysics: widget.scrollPhysics,
                autofillHints: widget.autofillHints,
                clipBehavior: widget.clipBehavior,
                restorationId: widget.restorationId,
                scribbleEnabled: widget.scribbleEnabled,
                enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
                onSubmitted:(text){
                  widget.onSubmitted?.call(text);
                },
                onChanged: (text) async {
                  _onTextChangeCallBack(text, false);
                },
                decoration: widget.inputDecoration?.call(getCheckedData),
              ))
        ],
      ),
    );
  }

  void _onTextChangeCallBack(String text, bool isFirst) {
    // setText(text); //fix bug // ios
    if (StrUtils.isEmpty(text) && !isFirst) {
      _removePop();
    }else{
      _addPop();
    }
    widget.onChanged.call(text);
  }

  void _addPop(){
    if(null==_overlayEntry){
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }
  void _removePop(){
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
  void notyOverlayDataChange() {
    _overlayEntry?.markNeedsBuild();
  }

  void notyListUiChange() {
    if (mounted) {
      setState(() {});
    }
  }
  void notyCheckedBoxChange() {
    if (mounted) {
      _checkedBoxState?.call((){});
    }
  }
}



/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/11/26
/// create_time: 11:15
/// describe:控制器
///
class InputExtendController {
  InputExtendController();

  InputExtendState? _state;

  get getSearchData => _state?.getSearchData;

  void bind(InputExtendState state) {
    _state = state;
  }

  void notyListUiChange() {
    _state?.notyListUiChange();
  }

  void setText(String text) {
    _state?.setText(text);
  }

  InputExtendState? getState() {
    return _state;
  }

  TextEditingController? getTextEditingController() {
    return _state?.getTextEditingController();
  }

  RenderBox? getRenderBox() {
    final obj = _state?.context.findRenderObject();
    if (obj != null) {
      return obj as RenderBox;
    }
    return null;
  }

  void dispose() {
    _state = null;
  }


  void setCheckChange({required data}) {
    _state?.setCheckChange(data: data);
  }

  bool isCheckedVO(bool Function(dynamic item) data) {
    return _state?.isCheckedVO(data) ?? false;
  }
  bool isChecked(int index) {
    return _state?.isChecked(index)??false;
  }

  void closePop() {
    _state?.closePop();
  }


  void setSearchData(List<dynamic> list) {
    _state?.setSearchData(list);
  }
}
