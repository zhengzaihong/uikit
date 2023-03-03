import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uikit_forzzh/edit_text/style/clear_style_input.dart';
import 'package:flutter_uikit_forzzh/edit_text/style/inline_style.dart';
import 'package:flutter_uikit_forzzh/utils/string_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/12/30
/// create_time: 16:28
/// describe: 通用文本输入框，可内置样式，外部定义等。支持系统全部属性 ,默认自带删除按钮。
/// 使用此组件一定要注意使用规范：输入框的高度应该由输入框自身大小所决定。当使用
/// 于较多文本编辑时高度通过 maxLines 设置填充。而非外部容器设置虚拟高度和背景来包裹输入框（TextField）
///
/// 当启用enableForm时，完成校验工作需要在你全部需要校验的输入框最外层提供 Form 布局包裹。并提供 FormState，列如：
///          final _formKey = GlobalKey<FormState>();
///           Form(
///               key: _formKey,
///               child:xxx包含输入框的子布局
///            ）
/// 在提交处验证输入信息：
///             onPressed: () {
///                  if (_formKey.currentState!.validate()) {
///                    print("验证通过");
///                  }else{
///                    print("验证失败");
///                  }
///              },
///
///常规简易用法: 更多内容查看 demo 源码
//        InputText(
//          // width: 200, //不传宽度默认填充父容器宽度
//           controller: TextEditingController(),//必传参数,规避后期TextFormField 中的initValue的二义性
//           hintText: "请输入手机号",
//           clearIcon: const Icon(Icons.delete,size: 20,color: Colors.red),
//           inputFormatters: [
//             LengthLimitingTextInputFormatter(11),
//             FilteringTextInputFormatter.digitsOnly
//           ],
//           onSubmitted: (text){
//             print("---------onSubmitted:$text");
//           },
//           onChanged: (msg){
//             print("---------onChanged:$msg");
//           },
//           // decoration: InputDecoration( // 自定义样式
//           //   hintText: "患者姓名/联系方式/证件号码",
//           //   hintStyle: const TextStyle(
//           //       fontSize: 14,
//           //       color: Colors.black
//           //   ),
//           //   suffixIcon: const Icon(Icons.add),
//           //   fillColor: Colors.purple,
//           //   enabledBorder: _outlineInputBorder,
//           //   border: _outlineInputBorder,
//           //   focusedBorder: _outlineInputBorder,
//           //   errorBorder: _outlineInputBorder,
//           //   focusedErrorBorder: _outlineInputBorder,
//           //   contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
//           // ),
//         )
typedef BuildInputDecorationStyle = InputDecoration Function(
    InputTextState state);

class InputText extends StatefulWidget {
  final Widget? title;
  ///设置为真 ，边框样式将取下
  final bool noBorder;
  /// 配合边框样式 实现圆角
  final double bgRadius;
  /// 是否使用表单输入框
  final bool enableForm;
  /// 输入框末尾的删除按钮样式 enableClear为真是生效
  final Widget clearIcon;
  /// 是否开启删除按钮
  final bool enableClear;
  /// 所有边框的样式
  final InputBorder? allLineBorder;

  final InlineStyle inline;
  /// 输入框的宽度，默认填充父布局
  final double? width;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final TextSelectionControls? selectionControls;

  final GestureTapCallback? onTap;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;

  final Widget? icon;
  final Color? iconColor;
  final Widget? label;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final String? helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextDirection? hintTextDirection;
  final int? hintMaxLines;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final EdgeInsetsGeometry? contentPadding;
  final bool isCollapsed;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefix;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final bool? isDense;
  final Color? suffixIconColor;
  final BoxConstraints? suffixIconConstraints;
  final String? counterText;
  final Widget? counter;
  final TextStyle? counterStyle;
  final bool? filled;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final String? semanticCounterText;
  final bool? alignLabelWithHint;
  final BoxConstraints? constraints;

  ///TextFormField所支持的属性
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  // final String? initialValue;
  const InputText(
      {
        this.inline = InlineStyle.clearStyle,
        this.title,
        this.noBorder = false,
        this.bgRadius = 10,
        this.enableForm = false,
        this.enableClear = true,
        this.clearIcon = const Icon(
          Icons.cancel,
          size: 20.0,
          color: Colors.grey,
        ),
        this.allLineBorder = const OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        this.width,
        this.padding,
        this.margin,
        this.alignment = Alignment.centerLeft,
        required this.controller,
        this.focusNode,
        this.decoration,
        this.keyboardType = TextInputType.text,
        this.textInputAction = TextInputAction.done,
        this.textCapitalization = TextCapitalization.none,
        this.style =
        const TextStyle(fontSize: 14, color:Color(0xff222222)),
        this.strutStyle,
        this.textAlign = TextAlign.start,
        this.textAlignVertical,
        this.textDirection,
        this.readOnly = false,
        this.toolbarOptions,
        this.showCursor,
        this.autofocus = false,
        this.obscuringCharacter = '•',
        this.obscureText = false,
        this.autocorrect = true,
        this.enableSuggestions = true,
        this.maxLines = 1,
        this.minLines,
        this.expands = false,
        this.maxLength,
        this.maxLengthEnforcement,
        this.onChanged,
        this.onEditingComplete,
        this.onSubmitted,
        this.onAppPrivateCommand,
        this.inputFormatters,
        this.enabled = true,
        this.cursorWidth = 2.0,
        this.cursorHeight,
        this.cursorRadius,
        this.cursorColor,
        this.keyboardAppearance,
        this.scrollPadding = const EdgeInsets.all(20.0),
        this.selectionControls,
        this.onTap,
        this.mouseCursor,
        this.buildCounter,
        this.scrollController,
        this.scrollPhysics,
        this.autofillHints = const <String>[],
        this.clipBehavior = Clip.hardEdge,
        this.restorationId,
        this.scribbleEnabled = true,
        this.enableIMEPersonalizedLearning = true,
        this.icon,
        this.iconColor,
        this.label,
        this.labelText,
        this.labelStyle,
        this.floatingLabelStyle,
        this.helperText,
        this.helperStyle,
        this.helperMaxLines,
        this.hintText,
        this.hintStyle = const TextStyle(fontSize: 14, color: Color(0xff999999)),
        this.hintTextDirection,
        this.hintMaxLines,
        this.errorText,
        this.errorStyle,
        this.errorMaxLines,
        this.floatingLabelBehavior,
        this.floatingLabelAlignment,
        this.isCollapsed = true,
        this.isDense,
        this.contentPadding = const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        this.prefixIcon,
        this.prefixIconConstraints,
        this.prefix,
        this.prefixText,
        this.prefixStyle,
        this.prefixIconColor,
        this.suffixIcon,
        this.suffix,
        this.suffixText,
        this.suffixStyle,
        this.suffixIconColor,
        this.suffixIconConstraints,
        this.counter,
        this.counterText,
        this.counterStyle,
        this.filled = true,
        this.fillColor = Colors.transparent,
        this.focusColor,
        this.hoverColor =  Colors.transparent,
        this.errorBorder,
        this.focusedBorder,
        this.focusedErrorBorder,
        this.disabledBorder,
        this.enabledBorder,
        this.border,
        this.semanticCounterText,
        this.alignLabelWithHint,
        this.constraints,
        this.onFieldSubmitted,
        this.onSaved,
        this.validator,
        // this.initialValue,
        Key? key})
      : super(key: key);

  @override
  State<InputText> createState() => InputTextState();
}

class InputTextState extends State<InputText> with AutomaticKeepAliveClientMixin{

  bool _hasContent = false;

  @override
  void initState() {
    super.initState();
    if (StringUtils.isEmpty(widget.controller?.text)) {
      _hasContent = false;
    } else {
      _hasContent = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.title ?? const SizedBox.shrink(),
        widget.noBorder
            ? Theme(
            data: ThemeData(
              primaryColor: Colors.transparent,
              inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.bgRadius)),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.bgRadius)),
                      borderSide: const BorderSide(color: Colors.transparent))),
            ),
            child: widget.enableForm ? _createInputForm() : _createInput())
            : widget.enableForm
            ? _createInputForm()
            : _createInput(),
      ],
    );
  }

  Widget _createInput() {
    return widget.width == null
        ? Row(
      children: [
        Expanded(
            child: Container(
              alignment: widget.alignment,
              padding: widget.padding,
              margin: widget.margin,
              width: widget.width,
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                style: widget.style,
                scrollController: widget.scrollController,
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
                autocorrect: widget.autocorrect,
                enableSuggestions: widget.enableSuggestions,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                expands: widget.expands,
                readOnly: widget.readOnly,
                toolbarOptions: widget.toolbarOptions,
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
                selectionControls: widget.selectionControls,
                onTap: widget.onTap,
                mouseCursor: widget.mouseCursor,
                buildCounter: widget.buildCounter,
                scrollPhysics: widget.scrollPhysics,
                autofillHints: widget.autofillHints,
                clipBehavior: widget.clipBehavior,
                restorationId: widget.restorationId,
                scribbleEnabled: widget.scribbleEnabled,
                enableIMEPersonalizedLearning:
                widget.enableIMEPersonalizedLearning,
                onSubmitted: widget.onSubmitted,
                onChanged: (text) {
                  _refresh(text);
                },
                decoration: buildDefaultInputDecoration(),
              ),
            ))
      ],
    )
        : Container(
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      child:TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: widget.style,
        scrollController: widget.scrollController,
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
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        readOnly: widget.readOnly,
        toolbarOptions: widget.toolbarOptions,
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
        selectionControls: widget.selectionControls,
        onTap: widget.onTap,
        mouseCursor: widget.mouseCursor,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: widget.autofillHints,
        clipBehavior: widget.clipBehavior,
        restorationId: widget.restorationId,
        scribbleEnabled: widget.scribbleEnabled,
        enableIMEPersonalizedLearning:
        widget.enableIMEPersonalizedLearning,
        onSubmitted: widget.onSubmitted,
        onChanged: (text) {
          _refresh(text);
        },
        decoration: buildDefaultInputDecoration(),
      ),
    );
  }

  Widget _createInputForm() {
    return widget.width == null
        ? Row(
      children: [
        Expanded(
            child: Container(
              alignment: widget.alignment,
              padding: widget.padding,
              margin: widget.margin,
              // width: widget.width,
              child: TextFormField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                style: widget.style,
                scrollController: widget.scrollController,
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
                autocorrect: widget.autocorrect,
                enableSuggestions: widget.enableSuggestions,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                expands: widget.expands,
                readOnly: widget.readOnly,
                toolbarOptions: widget.toolbarOptions,
                showCursor: widget.showCursor,
                maxLength: widget.maxLength,
                maxLengthEnforcement: widget.maxLengthEnforcement,
                onEditingComplete: widget.onEditingComplete,
                inputFormatters: widget.inputFormatters,
                enabled: widget.enabled,
                cursorWidth: widget.cursorWidth,
                cursorHeight: widget.cursorHeight,
                cursorRadius: widget.cursorRadius,
                keyboardAppearance: widget.keyboardAppearance,
                scrollPadding: widget.scrollPadding,
                selectionControls: widget.selectionControls,
                onTap: widget.onTap,
                mouseCursor: widget.mouseCursor,
                buildCounter: widget.buildCounter,
                scrollPhysics: widget.scrollPhysics,
                autofillHints: widget.autofillHints,
                restorationId: widget.restorationId,
                enableIMEPersonalizedLearning:
                widget.enableIMEPersonalizedLearning,
                // initialValue: widget.initialValue,
                validator: (value) {
                  return widget.validator?.call(value);
                },
                onFieldSubmitted: (text) {
                  widget.onFieldSubmitted?.call(text);
                },
                onSaved: (text) {
                  widget.onSaved?.call(text);
                },
                onChanged: (text) {
                  _refresh(text);
                },
                decoration: buildDefaultInputDecoration(),
              ),
            ))
      ],
    )
        : Container(
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: widget.style,
        scrollController: widget.scrollController,
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
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        readOnly: widget.readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: widget.showCursor,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        onEditingComplete: widget.onEditingComplete,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        selectionControls: widget.selectionControls,
        onTap: widget.onTap,
        mouseCursor: widget.mouseCursor,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: widget.autofillHints,
        restorationId: widget.restorationId,
        enableIMEPersonalizedLearning:
        widget.enableIMEPersonalizedLearning,
        // initialValue: widget.initialValue,
        validator: (value) {
          return widget.validator?.call(value);
        },
        onFieldSubmitted: (text) {
          widget.onFieldSubmitted?.call(text);
        },
        onSaved: (text) {
          widget.onSaved?.call(text);
        },
        onChanged: (text) {
          _refresh(text);
        },
        decoration: buildDefaultInputDecoration(),
      ),
    );
  }

  InputBorder? _buildBorder(InputBorder? inputBorderType){
    if(widget.noBorder){
      return null;
    }
    if(inputBorderType!=null){
      return inputBorderType;
    }
    return widget.allLineBorder;
  }
  InputDecoration buildDefaultInputDecoration() {
    if (widget.decoration == null) {
      if(widget.inline == InlineStyle.clearStyle){
        return ClearStyleInput().build(
          this,
          clearIcon:widget.clearIcon ,
          enableClear: widget.enableClear,
          fillColor: widget.fillColor,
          filled: widget.filled,
          border: widget.border,
          allLineBorder: _buildBorder(widget.allLineBorder),
          focusedBorder: _buildBorder(widget.focusedBorder),
          enabledBorder:_buildBorder(widget.enabledBorder),
          disabledBorder: _buildBorder(widget.disabledBorder),
          focusedErrorBorder:_buildBorder(widget.focusedErrorBorder),
          errorBorder:_buildBorder(widget.errorBorder),

          isCollapsed: widget.isCollapsed,
          contentPadding: widget.contentPadding,
          icon: widget.icon,
          iconColor: widget.iconColor,
          label: widget.label,
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          floatingLabelStyle: widget.floatingLabelStyle,
          helperText: widget.helperText,
          helperStyle: widget.helperStyle,
          helperMaxLines: widget.helperMaxLines,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          hintTextDirection: widget.hintTextDirection,
          hintMaxLines: widget.hintMaxLines,
          errorText: widget.errorText,
          errorStyle: widget.errorStyle,
          errorMaxLines: widget.errorMaxLines,
          floatingLabelBehavior: widget.floatingLabelBehavior,
          floatingLabelAlignment: widget.floatingLabelAlignment,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: widget.prefixIconConstraints,
          prefix: widget.prefix,
          prefixText: widget.prefixText,
          prefixStyle: widget.prefixStyle,
          prefixIconColor: widget.prefixIconColor,
          suffixIcon: widget.suffixIcon,
          suffix: widget.suffix,
          suffixText: widget.suffixText,
          suffixStyle: widget.suffixStyle,
          suffixIconColor: widget.suffixIconColor,
          suffixIconConstraints: widget.suffixIconConstraints,
          counter: widget.counter,
          counterText: widget.counterText,
          counterStyle: widget.counterStyle,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          semanticCounterText: widget.semanticCounterText,
          alignLabelWithHint: widget.alignLabelWithHint,
          constraints: widget.constraints,
        );
      }

      if(widget.inline == InlineStyle.none){

      }
    }
    return widget.decoration!;
  }

  void _refresh(String text){
    if(mounted){
      setState(() {
         widget.onChanged?.call(text);
        _hasContent = text.isNotEmpty;
      });
    }
  }

  void clearContent() {
    setState(() {
      widget.controller?.text = "";
      widget.onChanged?.call("");
      // widget.onSubmitted?.call("");
      // widget.onEditingComplete?.call();
      _hasContent = false;
    });
  }

  bool getIsEnable() {
    return widget.enabled ?? true;
  }
  bool getHasContent() {
    return _hasContent;
  }

  @override
  bool get wantKeepAlive => true;
}
