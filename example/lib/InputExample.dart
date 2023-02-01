import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class InputExample extends StatefulWidget {
  const InputExample({Key? key}) : super(key: key);

  @override
  _InputExampleState createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {

  final _formKey = GlobalKey<FormState>();

  var allBorder = const OutlineInputTextBorder(
      childBorderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
          color: Colors.transparent,
          width: 1
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("输入框"),
      ),
      body: Center(
        child: Column(
          children: [

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
                      hintText: "请输入手机号",
                      controller: TextEditingController(),
                      validator: const InputValidation(
                          mustFill: true,
                          mobilePhone: true,
                          errorMsg: "输入长度为不合法").validate,
                      prefixIcon: const Icon(Icons.phone, size: 20, color: Colors.grey),
                      bgRadius: 10,
                      allLineBorder: allBorder,
                      focusedBorder: allBorder.copyWith(
                          borderColor: Colors.lightBlue),
                      focusedErrorBorder: allBorder.copyWith(
                          borderColor: Colors.lightBlue),
                      errorBorder: allBorder.copyWith(borderColor: Colors.red),
                    ),


                    const SizedBox(height: 30),

                    InputText(
                      width: 300,
                      enableForm: true,
                      hintText: "请输入信息",
                      obscureText: true,
                      controller: TextEditingController(),
                      validator: const InputValidation(
                          mustFill: true,
                          minLength: 6,
                          maxLength: 12,
                          errorMsg: "密码长度为6-12位").validate,
                      prefixIcon: const Icon(
                          Icons.local_offer, size: 20, color: Colors.grey),
                      bgRadius: 10,
                      allLineBorder: allBorder,
                      focusedBorder: allBorder.copyWith(
                          borderColor: Colors.lightBlue),
                      focusedErrorBorder: allBorder.copyWith(
                          borderColor: Colors.lightBlue),
                      errorBorder: allBorder.copyWith(borderColor: Colors.red),
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
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

}
