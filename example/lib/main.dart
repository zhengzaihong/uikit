import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/utils/string_utils.dart';
import 'package:uikit_example/infinite_levels_example.dart';
import 'package:uikit_example/infinite_levels_example2.dart';
import 'package:uikit_example/tableview_example.dart';
import 'async_drop_example.dart';
import 'calendar_example.dart';
import 'city_picker_example.dart';
import 'input_extentd_example.dart';
import 'often_widget_example.dart';
import 'pop_window_example.dart';
import 'progressbar_example.dart';
import 'toast_example.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> funList = [];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: Toast.navigatorState,
      home: Scaffold(
        backgroundColor: Colors.purple,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder:(context,_){

            _createMenues(context);

            return GridView.builder(
              itemCount: funList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3/1
            ), itemBuilder: (context,index){

              return  funList[index];
            });
          } ,
        ),
      ),
    );
  }

  void _createMenues(BuildContext context){

    funList = [
      createMenue("进度条", context,const ProgressBarExample()),
      createMenue("toast", context,const ToastExample()),
      createMenue("城市选择", context,const CityPickerExample()),
      createMenue("异步加载下拉框",context, const AsyncDropExample()),
      createMenue("popwindow",context, const PopWindowExample()),
      createMenue("日历",context, const CalendarExample()),
      createMenue("输入框拓展",context, const InputExtentdExample()),
      createMenue("表格布局",context, const TableViewExample()),
      createMenue("无限层级菜单",context, const InfiniteLevelsExample()),
      createMenue("无限层级菜单2",context, const InfiniteLevelsExample2()),
      createMenue("常用小组件",context, const OftenWidgetExample()),
    ];
  }



  Widget createMenue(String title,BuildContext context,dynamic page){

    return InkWell(
        onTap: () {
          pushPage(context, page);
        },
        child: Container(
          alignment: Alignment.center,
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
