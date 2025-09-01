
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/11/18
/// create_time: 10:29
/// describe: 复选框
///eg:
//
//    KitCheckBox(
//       activeColor: Colors.purple,
//       checkColor: Colors.red,
//       isChecked: true,
//       useDefaultStyle: false,
//       iconLeft: false,
//       text: const Text("复选框"),
//       checkIcon: const Icon(Icons.check_box,color: Colors.red),
//       uncheckedIcon: const Icon(Icons.check_box_outline_blank,color: Colors.grey,),
//       onChange: (v){
//         print("----->$v");
//    }),


class KitCheckBox extends StatefulWidget {

  final Widget? text;
  final Widget? checkedText;
  final Widget? checkIcon;
  final Widget? uncheckedIcon;
  final bool? iconLeft;
  final bool? isChecked;
  final Function(bool value)? onChange;
  final bool enableFirstCallBack;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  /// useDefaultStyle 为true 走系统默认样式，否则走自定义样式，外部传入
  final bool? useDefaultStyle;
  ///useDefaultStyle 为true时scale 生效
  final double? scale;
  ///这色值针对 useDefaultStyle true 时生效
  final Color? activeColor;
  final Color? checkColor;

  final WidgetStateProperty<Color?>? fillColor;
  final BorderSide? side;
  final double? splashRadius;

  const KitCheckBox({
    this.text,
    this.checkedText,
    this.uncheckedIcon,
    this.checkIcon,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.useDefaultStyle = true,
    this.iconLeft = false,
    this.isChecked = false,
    this.onChange,
    this.enableFirstCallBack=false,
    this.activeColor,
    this.checkColor,
    this.scale=1,
    this.fillColor,
    this.side,
    this.splashRadius,
    Key? key}) : super(key: key);

  @override
  State<KitCheckBox> createState() => _KitCheckBoxState();

}

class _KitCheckBoxState extends State<KitCheckBox> {

  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked!;
    if(widget.enableFirstCallBack){
      callBack(false);
    }
  }

  void callBack(bool click) {
    if (widget.onChange!=null) {
      if (click) {
        isChecked = !isChecked;
      }
      widget.onChange?.call(isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildCheckBoxStyle();
  }

  Widget buildCheckBoxStyle(){
    if(widget.useDefaultStyle!){
      return GestureDetector(
        onTap: (){
          isChecked = !isChecked;
          widget.onChange?.call(isChecked);
          setState(() {});
        },
        child: widget.iconLeft! ?Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          children: [
            Transform.scale(
              scale: widget.scale,
              child: Checkbox(
                  activeColor: widget.activeColor,
                  checkColor: widget.checkColor,
                  value: isChecked,
                  side: widget.side,
                  fillColor: widget.fillColor,
                  splashRadius: widget.splashRadius,
                  onChanged: (val) {
                    isChecked = val??isChecked;
                    widget.onChange?.call(isChecked);
                    setState(() {});

                  }),
            ),
            _buildTitle()??const SizedBox(),
          ],
        ):
        Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          children: [
            _buildTitle()??const SizedBox(),
            Transform.scale(
              scale: widget.scale,
              child: Checkbox(
                  activeColor: widget.activeColor,
                  checkColor: widget.checkColor,
                  value: isChecked,
                  side: widget.side,
                  fillColor: widget.fillColor,
                  splashRadius: widget.splashRadius,
                  onChanged: (val) {
                    isChecked = val??isChecked;
                    widget.onChange?.call(isChecked);
                    setState(() {});

                  }),
            )
          ],
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              callBack(true);
            });
          }
        },
        child: widget.iconLeft! ?
        Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            children: [
              (isChecked ? widget.checkIcon : widget.uncheckedIcon)??const SizedBox(),
              _buildTitle()??const SizedBox(),
            ]) : Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            children: [
              _buildTitle()??const SizedBox(),
              (isChecked ? widget.checkIcon : widget.uncheckedIcon)??const SizedBox(),
            ]));
  }

  Widget? _buildTitle(){
    if(widget.checkedText==null){
      return widget.text;
    }
    if(isChecked){
      return widget.checkedText;
    }
    return widget.text;
  }
}
