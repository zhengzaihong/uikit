import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uikit_forzzh/edit_text/style/inline_style.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';
import 'package:uikit_example/city_picker_example.dart';

class InputExample extends StatefulWidget {
  const InputExample({Key? key}) : super(key: key);

  @override
  _InputExampleState createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {

  final _formKey = GlobalKey<FormState>();

  ///基础提示样式
  OutlineInputTextBorder allBorder = const OutlineInputTextBorder(
      childBorderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
          color: Colors.transparent,
          width: 1
      )
  );
  late OutlineInputBorder errorBorder;
  late OutlineInputBorder focusedErrorBorder;
  late OutlineInputBorder focusedBorder;
  @override
  void initState() {
    super.initState();
    focusedBorder = allBorder.copyWith(borderColor: Colors.lightBlue);
    focusedErrorBorder =  allBorder.copyWith(borderColor: Colors.lightBlue);
    errorBorder = allBorder.copyWith(borderColor: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            RouteUtils.push(context, const CityPickerExample(),hide: false);
          },
          child: const Text("输入框"),
        ),
      ),
      body: Column(
        children: [


          InputText(
            width: 300,
            margin: const EdgeInsets.only(top: 30),
            labelText: "常规输入框,此输入框不参与校验",
            hintText: "请输入昵称",
            inline: InlineStyle.normalStyle,
            fillColor: Colors.grey.withAlpha(40),
            cursorEnd: true,
            suffixIcon: const Icon(Icons.remove_red_eye_outlined, size: 20, color: Colors.grey),
            onChanged: (msg){
              print("----------msg:$msg");
            },
            controller: TextEditingController(),
          ),


          Form(
              key: _formKey,
              onChanged: () {
                _formKey.currentState!.validate();
              },
              child: Column(
                children: [

                  InputText(
                    width: 300,
                    margin: const EdgeInsets.only(top: 30),
                    enableForm: true,
                    obscureText: true,
                    noBorder: true,
                    hintText: "请输入手机号",
                    showCursor: true,
                    cursorColor: Colors.red,
                    fillColor: Colors.grey.withAlpha(40),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    onChanged: (msg){

                      print("----------msg1111:$msg");
                    },
                    controller: TextEditingController(),
                    validator: const InputValidation(
                        mustFill: true,
                        mobilePhone: true,
                        errorMsg: "输入长度不合法").validate,
                    prefixIcon: const Icon(Icons.phone, size: 20, color: Colors.grey),
                    bgRadius: 10,
                    allLineBorder: allBorder,
                    focusedBorder: focusedBorder,
                    focusedErrorBorder: focusedErrorBorder,
                    errorBorder: errorBorder,
                  ),


                  const SizedBox(height: 30),

                  InputText(
                    width: 300,
                    enableForm: true,
                    hintText: "请输入密码",
                    obscureText: true,
                    inline: InlineStyle.normalStyle,
                    controller: TextEditingController(),
                    fillColor: Colors.grey.withAlpha(40),
                    validator: const InputValidation(
                        mustFill: true,
                        minLength: 6,
                        maxLength: 12,
                        errorMsg: "密码长度为6-12位").validate,
                    prefixIcon: const Icon(
                        Icons.local_offer, size: 20, color: Colors.grey),
                    bgRadius: 10,
                    allLineBorder: allBorder,
                    focusedBorder: focusedBorder,
                    focusedErrorBorder: focusedErrorBorder,
                    errorBorder: errorBorder,
                  ),



                  InputText(
                    margin: const EdgeInsets.only(left: 50,right: 50,top: 50),
                    enableForm: true,
                    hintText: "请输入描述",
                    controller: TextEditingController(),
                    fillColor: Colors.grey.withAlpha(40),
                    validator: const InputValidation(
                        mustFill: true,
                        emptyTip: "描述不能为空",
                        ).validate,
                    maxLength: 400,
                    maxLines: 5,
                    bgRadius: 10,
                    allLineBorder: allBorder,
                    focusedBorder: focusedBorder,
                    focusedErrorBorder: focusedErrorBorder,
                    errorBorder: errorBorder,
                  )
                ],
              )),

          Container(
            padding: const EdgeInsets.only(top: 32.0),
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("验证通过");
                } else {
                  print("验证失败");
                }
              },
              child: const Text('提交'),
            ),
          )
        ],
      ),
    );
  }

}
