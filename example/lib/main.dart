import 'package:flutter/material.dart';
import 'async_drop_example.dart';
import 'calendar_example.dart';
import 'city_picker_example.dart';
import 'input_extentd_example.dart';
import 'often_widget_example.dart';
import 'pop_window_example.dart';
import 'progressbar_example.dart';
import 'toast_example.dart';
import 'package:flutter_uikit_forzzh/uiktlib.dart';


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

            Toast.init(context);

            return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                    children: [
                  Row(children: const [Expanded(child: SizedBox(height: 60))]),

                  createMenue("进度条", context,const ProgressBarExample()),
                  createMenue("toast", context,const ToastExample()),
                  createMenue("城市选择", context,const CityPickerExample()),
                  createMenue("异步加载下拉框",context, const AsyncDropExample()),
                  createMenue("popwindow",context, const PopWindowExample()),
                  createMenue("日历",context, const CalendarExample()),
                  createMenue("输入框拓展",context, const InputExtentdExample()),
                  createMenue("常用小组件",context, const OftenWidgetExample()),
                  const SizedBox(height: 20),


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
