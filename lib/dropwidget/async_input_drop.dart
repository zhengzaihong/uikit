import 'dart:async';

import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-21
/// create_time: 12:31
/// describe: 支持异步加载的选择下拉框
///

typedef ItemWidget<T> = List<DropdownMenuItem> Function(T list);

typedef AsyncLoad<T> = Future<T> Function(Completer completer);

typedef InitialData<T> = T Function();

class AsyncInputDrop<T> extends StatelessWidget {
  /// 输入框是否只读 默认 false
  final bool? readOnly;

  ///输入框右边显示的widget
  final Widget? suffixIcon;

  ///下拉框点击事件
  final ValueChanged<Object?>? onChanged;

  ///填充数据回调
  final ItemWidget<T>? itemWidget;

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

  const AsyncInputDrop(
      {Key? key,
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
        this.disabledHint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: FutureBuilder<T>(
        future: asyncLoad!(Completer()),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadStatusWidget(loadingWidget, snapshot);
          }
          if (snapshot.hasError) {
            return loadStatusWidget(errorWidget, snapshot);
          }

          var contentList = snapshot.data;
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
              disabledHint: disabledHint,
              ///子item 不允许两个相同对象。
              items: itemWidget!(contentList!),
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
