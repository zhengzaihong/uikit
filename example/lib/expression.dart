import 'package:flutter/material.dart';
import 'package:uikit/form/datamode.dart';
import 'package:uikit/form/form_model.dart';
import 'package:uikit/form/viewhelper.dart';
import 'package:uikit/functionbutton/function_container.dart';
import 'package:uikit/functionbutton/function_radiobutton.dart';
import 'package:uikit/res/color_res.dart';


OutlineInputBorder _outlineInputBorder =  OutlineInputBorder(
  gapPadding: 0,
  borderSide: const BorderSide(
    color: Colors.white,
  ),
  borderRadius: BorderRadius.circular(10.0)
);

//创建输入框
Widget buildInput(
    {dynamic tag = "--",
    String hintText = "请填写",
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text}) {
  var controller = TextEditingController();

  DataMode dataMode = DataMode(tag, "", controller: controller);
  ViewHelper.getDataModes().add(dataMode);

  return Container(
      height: 80,
      child: TextFormField(
          autofocus: false,
          obscureText: false,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            isCollapsed:true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            enabledBorder: _outlineInputBorder,
            border:_outlineInputBorder,
            disabledBorder: _outlineInputBorder,
            focusedErrorBorder: _outlineInputBorder,
            errorBorder: _outlineInputBorder,
          )));
}

Widget buildRadioButton({
  dynamic tag = "--",
  int defaultCheck = 0,
  required List<String> labers,
}) {
  DataMode dataMode = DataMode(tag, "");
  ViewHelper.getDataModes().add(dataMode);
   var index = 0;
  return Container(
    height: 80,
    child:  FunctionContainer(
    defaultCheck: defaultCheck,
    singleCheckedChange: (checkid) {
      dataMode.value = labers[checkid];
    },
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: labers.map((e) => Row(children: [
      FunctionRadioButton(
        title: labers[index],
        index: index++,
        width: 100,
        padding: const EdgeInsets.only(left: 5),
        checkedTextStyle: const TextStyle(
            color: ColorRes.black,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        unCheckTextStyle: const TextStyle(
            color: ColorRes.black,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        checkedIconWidget: Image.asset(findAssetImage("单选选中.png"),
            width: 15, height: 15),
        unCheckedWidget: Image.asset(findAssetImage("单选未选中_o.png"),
            width: 15, height: 15),
      ),
      index!=labers.length?
      Container(height: 30,
        width:10,color: Colors.red,):const SizedBox()
    ])).toList()),

  ));
}





//创建下拉框和输入框
Widget buildSelectAndEditText(
    {dynamic tag = "--",
      String hintText = "请填写",
      required Function(TextEditingController controller) selectClickCallBack,
      FormFieldValidator<String>? validator,
      TextInputType keyboardType = TextInputType.text}) {
  var controller = TextEditingController();
  var controller1 = TextEditingController();

  DataMode dataMode = DataMode(tag, "", controller: controller);
  DataMode dataMode1 = DataMode(tag, "", controller: controller1);
  ViewHelper.getDataModes().add(dataMode);
  ViewHelper.getDataModes().add(dataMode1);

  return Container(
      height: 80,
      width: 200,
      child:Row(children: [
       Expanded(child:  TextFormField(
           autofocus: false,
           obscureText: false,
           validator: validator,
           controller: controller,
           decoration: InputDecoration(
             hintText: hintText,
             contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
             enabledBorder: const OutlineInputBorder(
               borderSide: BorderSide(color: Colors.grey, width: 0.0),
             ),
             border: OutlineInputBorder(
                 borderSide: const BorderSide(color: Colors.black26, width: 1),
                 borderRadius: BorderRadius.circular(10.0)),
             suffixIcon: IconButton(
                 icon: const Icon(
                   Icons.remove_red_eye,
                   color: Colors.yellow,
                 ),
                 onPressed: () {
                   selectClickCallBack.call(controller);
                 }),
           ))),

        const SizedBox(width: 10),

        Expanded(child: TextFormField(
            autofocus: false,
            obscureText: false,
            validator: validator,
            controller: controller1,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.circular(10.0)),
            )))

      ]));
}





//创建下拉框
Widget buildSelect(
    {dynamic tag = "--",
    String text = "请填写",
      String? value,
    required List<String> contents,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text}) {


  return Container(
    height: 80,
    child:  DropdownButton(
        icon: const Icon(Icons.arrow_drop_down_rounded),
        iconSize: 40,
        value: value,
        iconEnabledColor: Colors.green.withOpacity(0.7),
        hint: Text(text),
        isExpanded: true,
        underline: Container(),
        items: contents.map((e) =>  DropdownMenuItem(
            child: Row(children: [

              Text(e),
            ]),
            value: 1)).toList(),
        onChanged: (value) {


        }));
}

//创建一行信息
Widget createLine(List<FormModel> formModes) {
  return Column(children: [
    Row(
        children: formModes
            .map((e) => Expanded(
                flex: e.flex,
                child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(e.name,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black26)))))
            .toList()),
    const SizedBox(height: 10),
    Row(
        children: formModes
            .map((e) => Expanded(flex: e.flex, child: Container(
          margin: const EdgeInsets.only(right: 20),
          child: e.child,)))
            .toList()),
  ]);
}

String findAssetImage(String path) {
  return "images/$path".replaceAll("//", "/");
}
