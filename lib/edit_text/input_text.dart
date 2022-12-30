import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/12/30
/// create_time: 16:28
/// describe: 通用文本输入框
///

class InputText extends StatefulWidget {
  final bool showClear;
  final Widget? title;

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

  const InputText(
      {this.title,
      this.showClear = true,
      this.controller,
      this.focusNode,
      this.decoration,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.style,
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
      this.enabled,
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
      this.hintStyle,
      this.hintTextDirection,
      this.hintMaxLines,
      this.errorText,
      this.errorStyle,
      this.errorMaxLines,
      this.floatingLabelBehavior,
      this.floatingLabelAlignment,
      this.isCollapsed = false,
      this.isDense,
      this.contentPadding,
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
      this.filled,
      this.fillColor,
      this.focusColor,
      this.hoverColor,
      this.errorBorder,
      this.focusedBorder,
      this.focusedErrorBorder,
      this.disabledBorder,
      this.enabledBorder,
      this.border,
      this.semanticCounterText,
      this.alignLabelWithHint,
      this.constraints,
      Key? key})
      : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.title ?? const SizedBox.shrink(),
        TextField(
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
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          onSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          decoration: widget.decoration ??
              InputDecoration(
                fillColor: widget.fillColor,
                filled: widget.filled,
                isCollapsed: widget.isCollapsed,
                contentPadding: widget.contentPadding,
                border: widget.border,
                focusedBorder: widget.focusedBorder,
                enabledBorder: widget.enabledBorder,
                disabledBorder: widget.disabledBorder,
                focusedErrorBorder: widget.focusedErrorBorder,
                errorBorder: widget.enabledBorder,
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
              ),
        ),
      ],
    );
  }
}
