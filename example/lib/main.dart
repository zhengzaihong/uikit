
import 'package:flutter/material.dart';
import 'package:uikit/form/form_container.dart';
import 'package:uikit/form/form_model.dart';
import 'package:uikit/form/viewhelper.dart';

import 'expression.dart';
import 'item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void reassemble() {
    super.reassemble();
    ViewHelper.getDataModes().clear();
  }

  List<ItemModel> itemModes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: [
            InkWell(
              onTap: () {

                ViewHelper.validate(callBack: (datas,status){
                  print("-------->${status.toString()}");

                  datas.forEach((element) {
                    print("-------->${element.toString()}");
                  });
                });
              },
              child: Container(
                  color: Colors.red, width: 100, height: 50, child: Text("收集")),
            ),

            InkWell(
              onTap: () {
                ViewHelper.clear();
              },
              child: Container(
                  color: Colors.red, width: 100, height: 50, child: Text("清空")),
            )
          ],
        ),
        body: FormContainer(
          childWidget: () {
            return SingleChildScrollView(child: Column(
                children: [
                  //第一行
                  createLine([
                    FormModel("姓名", 1, buildInput(validator: (value) {
                      if (value == null || value.length < 6 || value.length > 16) {
                        return '密码在6-16位数之间哦';
                      } else {
                        return null;
                      }
                    })),
                    FormModel("性别", 1, buildInput()),
                  ]),


                  SizedBox(height: 30),
                  createLine([
                    FormModel("相间的", 1, buildRadioButton(labers: ["hhhhkkk","oooooo"])),
                  ]),

                  SizedBox(height: 30),
                  createLine([
                    FormModel("下拉框", 1, buildSelectAndEditText(tag: "select",
                        selectClickCallBack: (controller){
                      print("-----------?下拉框${controller.text}");


                    })),
                  ]),


                  InkWell(child: Text("  新增加   "),
                    onTap: (){
                     itemModes.add( ItemModel());
                     setState(() {

                     });
                    },
                  ),

                  ListView.builder(
                    itemCount:itemModes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return itemModes[index].widget??Container();
                    },
                  )


                ]));
          },
        ),
      ),
    );
  }
}
