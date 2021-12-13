import 'package:flutter/material.dart';
import 'package:uikit/calendar/calendar_helper.dart';
import 'package:uikit_example/pop_window_example.dart';

import 'async_drop_example.dart';
import 'city_picker_example.dart';
import 'form_example.dart';
import 'package:uikit/often/time_view.dart';

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
        body: Builder(builder: (context) {
          return SingleChildScrollView(
              child: Column(children: [
            SizedBox(height: 60),
            InkWell(
                onTap: () {
                  pushPage(context, CityPickerExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(30),
                  color: Colors.lightBlue,
                  child: Text("城市选择"),
                )),
            InkWell(
                onTap: () {
                  pushPage(context, AsyncDropExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(30),
                  child: Text("异步加载下拉框"),
                )),
            InkWell(
                onTap: () {
                  pushPage(context, FormExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(30),
                  child: Text("表单"),
                )),
            InkWell(
                onTap: () {
                  var config = CalendarHelper.getConfig();
                  config.sureButtonWidth = 200;
                  var checkedText = const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  );

                  config.checkedEndTimeStyle = checkedText;
                  config.checkedStartTimeStyle = checkedText;

                  CalendarHelper.showDateDialog(context,
                      callBack: (startTime, endTime) {
                    print(
                        "---${startTime.year}--${startTime.month}--${startTime.day}->");
                    print(
                        "---${endTime.year}--${endTime.month}--${endTime.day}->");
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(30),
                  child: Text("日历"),
                )),
            InkWell(
                onTap: () {
                  pushPage(context, PopWindowExample());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(30),
                  child: Text("popwindow"),
                )),


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
            )
          ]));
        }),
      ),
    );
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
