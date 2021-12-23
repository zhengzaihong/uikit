import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uikit_example/pop_window_example.dart';
import 'package:uikit_example/toast_example.dart';
import 'package:uikit/toast/toast_utils.dart';

import 'async_drop_example.dart';
import 'calendar_example.dart';
import 'city_picker_example.dart';
import 'form_example.dart';
import 'package:uikit/often/time_view.dart';

import 'input_extentd_example.dart';

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
        body: LayoutBuilder(
          builder:(context,_){


            ///全局配置
            Toast.getToastConfig.buildToastWidget = (context,msg){
              return  Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(200),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(msg,style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,fontSize: 12)));
            };



            return SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 60),
                  createMenue("toast", context,const ToastExample()),
                  createMenue("城市选择", context,const CityPickerExample()),
                  createMenue("异步加载下拉框",context, const AsyncDropExample()),
                  createMenue("表单", context, FormExample()),
                  createMenue("popwindow",context, const PopWindowExample()),
                  createMenue("日历",context, const CalendarExample()),
                  createMenue("输入框拓展",context, const InputExtentdExample()),
                  SizedBox(height: 20),
                  TimeView(
                    countdown: 10,
                    child: (context, controller, time) {
                      if (controller.isAvailable) {
                        return InkWell(
                            onTap: () {
                              ///todo  request
                              controller.startTimer();
                            },
                            child: Container(
                                width: 120,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: Text("获取验证码")));
                      } else {
                        print("--------请$time秒后再试");
                      }

                      return Container(
                          width: 120,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("请$time秒后再试"));
                    },
                  ),

                ]));
          } ,
        ),
      ),
    );
  }


  Widget createMenue(String title,BuildContext context,dynamic page){

    return InkWell(
        onTap: () {
          pushPage(context, page);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(30),
          color: Colors.lightBlue,
          child: Text(title),
        ));
  }

  void pushPage(context, page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }
}
