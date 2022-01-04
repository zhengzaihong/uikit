import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/2
/// create_time: 10:35
/// describe: 自定义复选框
///
class CustomCheckBox extends StatefulWidget {

  final Text checkedText;
  final Text unCheckedText;
  final Widget checkIcon;
  final Widget uncheckedIcon;
  final bool iconLeft;
  final bool checked;

  final Function(bool checked)? checkedCallBack;

  const CustomCheckBox(
      {Key? key,
      required this.checkedText,
      required this.unCheckedText,
      required this.uncheckedIcon,
      required this.checkIcon,
       this.iconLeft = true,
        this.checked =false,
        this.checkedCallBack,
      })
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {

  late Text checkedText;
  late Text unCheckedText;
  late Widget checkIcon;
  late Widget uncheckedIcon;
  late bool iconLeft;
  late bool checked;
  Function(bool checked)? checkedCallBack;
  bool isFirst = true;


  @override
  void initState() {
    super.initState();
    checkedText = widget.checkedText;
    unCheckedText = widget.unCheckedText;
    checkIcon = widget.checkIcon;
    uncheckedIcon = widget.uncheckedIcon;
    iconLeft = widget.iconLeft;
    checked = widget.checked;
    checkedCallBack = widget.checkedCallBack;
    callBack(false);
  }

  void callBack(bool click){
    if(null!=checkedCallBack){
      if(isFirst){
        checkedCallBack?.call(checked);
        isFirst = false;
      }else{
        checkedCallBack?.call(!checked);
      }
      if(click){
        checked = !checked;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
       onTap: (){
         setState(() {
             callBack(true);
         });
       },
        child: iconLeft ?
        Row(children: [
          checked?checkIcon:uncheckedIcon,
          checked?checkedText:unCheckedText,
        ]) : Row(children: [
          checked?checkedText:unCheckedText,
          checked?checkIcon:uncheckedIcon,
        ]));
  }
}
