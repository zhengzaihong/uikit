import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';
import 'input_example.dart';
import 'stack_card_demo.dart';
import 'infinite_levels_example.dart';
import 'often_widget_example2.dart';
import 'pager_example.dart';
import 'shimmer_example.dart';
import 'tableview_example.dart';
import 'calendar_example.dart';
import 'city_picker_example.dart';
import 'input_extend_example.dart';
import 'often_widget_example.dart';
import 'progressbar_example.dart';
import 'selection_menu_example.dart';
import 'toast_example.dart';


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
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.purple,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder:(context,_){

            _createMenus(context);

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

  void _createMenus(BuildContext context){
    funList = [
      createMenu("进度条", context,const ProgressBarExample()),
      createMenu("toast", context,const ToastExample()),
      createMenu("城市选择", context,const CityPickerExample()),
      createMenu("日历",context, const CalendarExample()),
      createMenu("输入框",context,  const InputExample()),
      createMenu("输入框拓展",context, const InputExtendExample()),
      createMenu("表格布局",context, const TableViewExample()),
      createMenu("无限层级菜单",context, const InfiniteLevelsExample()),
      createMenu("仿系统下拉框",context, const SelectionMenuExample()),
      createMenu("分页组件",context, const PagerExample()),
      createMenu("微光加载效果",context, const ShimmerLoadingExample()),
      createMenu("堆叠卡片", context,const StackCardDemo()),
      createMenu("常用小组件",context, const OftenWidgetExample()),
      createMenu("常用小组件2",context, const OftenWidgetExample2()),
    ];
  }



  Widget createMenu(String title,BuildContext context,dynamic page){

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
