import 'package:flutter/material.dart';

Widget buildInput(
    {String hintText = "请填写",
    String errorText = "请输入信息",
    TextInputType keyboardType = TextInputType.text}) {

  return TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: false,
      validator: (value) {},
      decoration: InputDecoration(
        hintText: '密码',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        suffixIcon: IconButton(
            icon: const Icon(
              Icons.remove_red_eye,
              color: Colors.amber,
            ),
            onPressed: () {

            }),
      ));
}
