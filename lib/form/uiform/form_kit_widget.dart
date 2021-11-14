import 'package:flutter/material.dart';

class FormKitWidget extends StatelessWidget {
  ///LaybelWidget
  final Widget? laybelWidget;

  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;

  final Widget? textFormField;
  ///ArrowsWidget
  final Widget? arrowsWidget;

  ///子组件分布的权重
  final List<int>? weights;
  ///SplitWidget
  final Widget? splitWidget;
  final List<Widget>? formFields;

  const FormKitWidget({
    Key? key,
    this.laybelWidget,
    this.decoration,
    this.alignment,
    this.margin,
    this.padding,
    this.weights,
    this.textFormField,
    this.arrowsWidget,
    this.splitWidget,
    this.formFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      laybelWidget ?? const SizedBox(),
      Container(
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: decoration,
        child: weights == null || weights!.isEmpty
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: textFormField!),
                arrowsWidget ?? const SizedBox(),
              ])
            : buildLineWidget(),
      )
    ]);
  }

  Widget buildLineWidget() {
    if (formFields == null) {
      print("子组件列表不能为空，否则不显示");
      return Container();
    }
    List<Widget> lineWidget = [];
    for (int i = 0; i < weights!.length; i++) {
      lineWidget.add(Expanded(flex: weights![i], child: formFields![i]));
    }
    return Row(children: lineWidget);
  }
}
