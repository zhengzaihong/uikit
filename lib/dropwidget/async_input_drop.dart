import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uikit/dropwidget/drop_wapper.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-21
/// create_time: 12:31
/// describe: 支持异步加载的选择下拉框，此组件是对 DropdownButton的封装扩展
/// 建议使用 本库提供 InputExtentd 组件，可完全高度自定义，规避了系统DropdownButton的子项
/// 必须是itemWidget中的某项的问题，不利于实际项目开发，
///

///下拉框的默认选中项，初始值，切必须是 itemWidget 中的某项
typedef InitialData<T> = T Function();

///填充下拉框集合的回调
typedef ItemWidget<T> = DropWapper Function(T list);

typedef AsyncLoad<T> = Future<T> Function(Completer completer);

class AsyncInputDrop<T> extends StatelessWidget {
  /// 输入框是否只读 默认 false
  final bool? readOnly;

  ///输入框右边显示的widget
  final Widget? suffixIcon;

  ///下拉框点击事件
  final ValueChanged<Object?>? onChanged;

  ///填充数据回调
  final ItemWidget<T?>? itemWidget;

  ///异步加载的回调
  final AsyncLoad<T>? asyncLoad;

  final BoxDecoration decoration;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;

  final InputDecoration inputdecoration;

  ///加载中显示的组件
  final Widget? loadingWidget;

  ///加载错误显示的组件
  final Widget? errorWidget;

  ///监听加载状态
  final Function(AsyncSnapshot state)? loadStatus;

  final Widget? hint;
  final Widget? disabledHint;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize = 24.0;
  final bool isDense = true;
  final bool isExpanded = false;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;

  final bool autofocus = false;
  final Color? dropdownColor;
  final FormFieldSetter<dynamic>? onSaved;
  final FormFieldValidator<dynamic>? validator;

  final bool autovalidate = false;
  final AutovalidateMode? autovalidateMode;
  final double? menuMaxHeight;
  final bool? enableFeedback;

  const AsyncInputDrop({
    Key? key,
    required this.itemWidget,
    required this.asyncLoad,
    this.loadingWidget,
    this.errorWidget,
    this.loadStatus,
    this.readOnly = false,
    this.suffixIcon,
    this.onChanged,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.alignment = Alignment.center,
    this.decoration = const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    this.inputdecoration = const InputDecoration(
      border: InputBorder.none,
      hintText: "请输入",
      hintStyle: TextStyle(fontSize: 14),
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    ),
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.itemHeight,
    this.focusColor,
    this.focusNode,
    this.dropdownColor,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.menuMaxHeight,
    this.enableFeedback,
    this.hint,
    this.disabledHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<T> completer = Completer();
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: FutureBuilder<T>(
        future: asyncLoad!(completer),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadStatusWidget(loadingWidget, snapshot);
          }
          if (snapshot.hasError) {
            return loadStatusWidget(errorWidget, snapshot);
          }

          var contentList = snapshot.data;

          DropWapper wapper = itemWidget!(contentList);
          dynamic value = wapper.initValue;
          return DropdownButtonFormField<dynamic>(
              decoration: inputdecoration,
              iconEnabledColor: iconEnabledColor,
              iconDisabledColor: iconDisabledColor,
              itemHeight: itemHeight,
              focusColor: focusColor,
              focusNode: focusNode,
              dropdownColor: dropdownColor,
              onSaved: onSaved,
              validator: validator,
              autovalidateMode: autovalidateMode,
              menuMaxHeight: menuMaxHeight,
              enableFeedback: enableFeedback,
              icon: suffixIcon,
              hint: hint,
              value: value,
              disabledHint: disabledHint,

              ///子item 不允许两个相同对象。
              items: wapper.drops,
              onChanged: (item) {
                if (onChanged != null) {
                  onChanged!(item);
                }
              });
        },
      ),
    );
  }

  Widget loadStatusWidget(Widget? child, AsyncSnapshot snapshot) {
    return readOnly!
        ? Container(
            child: child,
          )
        : GestureDetector(
            onTap: () {
              loadStatus?.call(snapshot);
            },
            child: Container(child: child));
  }
}
