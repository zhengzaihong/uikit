
import 'package:flutter/material.dart';
import 'package:uikit/form/form_container.dart';
import 'package:uikit/form/form_model.dart';
import 'package:uikit/form/FormHelper.dart';

import 'async_drop_example.dart';
import 'city_picker_example.dart';
import 'expression.dart';
import 'form_example.dart';
import 'item_model.dart';
import 'package:uikit/form/uiform/form_kit_widget.dart';
import 'package:uikit/form/uiform/laybel_widget.dart';


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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple,
        resizeToAvoidBottomInset: false,

        body:Builder(builder: (context){
          return  SingleChildScrollView(child: Column(children: [
            SizedBox(height: 60),
            InkWell(
                onTap: ()  {
                  pushPage(context,CityPickerExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(30),
                  color: Colors.lightBlue,
                  child: Text("城市选择"),
                )),

            InkWell(
                onTap: ()  {
                  pushPage(context,AsyncDropExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(30),
                  child: Text("异步加载下拉框"),
                )),

            InkWell(
                onTap: ()  {
                  pushPage(context,FormExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(30),
                  child: Text("表单"),
                )),
          ]));
        }),
      ),
    );
  }


  void pushPage(context,page){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }

}




class TempWidget extends LaybelWidget {
  @override
  Widget createLabel() {
    return const Text("测试标签》》》》》》》》》《《《《《");
  }

}
