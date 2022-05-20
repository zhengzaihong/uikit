import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/button/function_button.dart';
import 'package:flutter_uikit_forzzh/button/function_container.dart';
import 'package:flutter_uikit_forzzh/button/function_radiobutton.dart';
import 'package:flutter_uikit_forzzh/checkbox/custom_checkbox.dart';
import 'package:flutter_uikit_forzzh/button/function_checkbox.dart';
import 'package:flutter_uikit_forzzh/often/time_view.dart';
import 'package:flutter_uikit_forzzh/toast/toast_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/1/4
/// create_time: 16:02
/// describe: 一些常用小组件
///z
class OftenWidgetExample extends StatefulWidget {
  const OftenWidgetExample({Key? key}) : super(key: key);

  @override
  _OftenWidgetExampleState createState() => _OftenWidgetExampleState();
}

class _OftenWidgetExampleState extends State<OftenWidgetExample> {

  BoxDecoration checkedBoxDecoration = const BoxDecoration(
      color:Colors.lightBlue,
      borderRadius: BorderRadius.all(Radius.circular(5)));

  BoxDecoration unCheckedBoxDecoration = const BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(5)));

  TextStyle checkedTextStyle =
  const TextStyle(color: Colors.white, fontSize: 15);
  TextStyle unCheckTextStyle =
  const TextStyle(color: Colors.black45, fontSize: 15);


  TextStyle textBlodStyle = const TextStyle(
      fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w600);

  Widget checkedIconWidget = Image.asset("images/checked2.png", width: 30, height: 30);

  Widget unCheckedWidget = Image.asset("images/checked1.png", width: 30, height: 30);

  List<int> defaultCheckeds = [1,2];
  List<int> defaultCheckboxIds = [1,2];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.brown,
      body:Container(
        margin: const EdgeInsets.only(left: 20),
        child:  SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  title("单选button"),
                  SizedBox(height: 60,child:  FunctionContainer(
                    defaultCheck: 0,
                    singleCheckedChange: (checked) {
                      Toast.show(context: context, msg: checked==1?"已启用":"已禁用");
                    },
                    child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      FunctionButton(
                        "启用",
                        1,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        checkedBoxDecoration: checkedBoxDecoration,
                        unCheckedBoxDecoration: unCheckedBoxDecoration,
                        width: 50,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      FunctionButton(
                        "禁用",
                        2,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        checkedBoxDecoration: checkedBoxDecoration,
                        unCheckedBoxDecoration: unCheckedBoxDecoration,
                        width: 50,
                        height: 30,
                      )
                    ]),
                  )),



                  title("多选button"),
                  SizedBox(height: 60,child: FunctionContainer(
                    defaultCheckeds: defaultCheckeds,
                    allowMultipleChoice: true, //多选
                    multipleCheckedChange: (list){
                      StringBuffer buffer  = StringBuffer();
                      for (var element in list) {
                        buffer.write(element);
                        buffer.write(",");
                      }
                      defaultCheckeds = list as List<int>;
                      setState(() {
                      });
                      Toast.show(context: context, msg: "选中的按钮Id: ${buffer.toString()}");
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      FunctionButton(
                        "按钮1",
                        1,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        checkedBoxDecoration: checkedBoxDecoration,
                        unCheckedBoxDecoration: unCheckedBoxDecoration,
                        width: 50,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      FunctionButton(
                        "按钮2",
                        2,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        checkedBoxDecoration: checkedBoxDecoration,
                        unCheckedBoxDecoration: unCheckedBoxDecoration,
                        width: 50,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      FunctionButton(
                        "按钮3",
                        3,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        checkedBoxDecoration: checkedBoxDecoration,
                        unCheckedBoxDecoration: unCheckedBoxDecoration,
                        width: 50,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      FunctionButton(
                        "按钮4",
                        4,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        checkedBoxDecoration: checkedBoxDecoration,
                        unCheckedBoxDecoration: unCheckedBoxDecoration,
                        width: 50,
                        height: 30,
                      )
                    ]),
                  )),



                  title("单选Radio"),
                  SizedBox(height: 60,child:  FunctionContainer(
                    defaultCheck: 1,
                    singleCheckedChange: (id){
                      Toast.show(context: context, msg: "选中的radio: ${id.toString()}");
                    },
                    child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      FunctionRadioButton(
                        title: "无",
                        index: 0,
                        width: 85,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        checkedIconWidget: checkedIconWidget,
                        unCheckedWidget: unCheckedWidget,
                      ),
                      const SizedBox(width: 10),
                      FunctionRadioButton(
                        title: "化学品",
                        index: 1,
                        width: 85,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        checkedIconWidget: checkedIconWidget,
                        unCheckedWidget: unCheckedWidget,
                      ),
                      const SizedBox(width: 10),
                      FunctionRadioButton(
                        title: "毒物",
                        index: 2,
                        width: 85,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        checkedIconWidget: checkedIconWidget,
                        unCheckedWidget: unCheckedWidget,
                      ),
                      const SizedBox(width: 10),
                      FunctionRadioButton(
                        title: "射线",
                        index: 3,
                        width: 85,
                        padding: EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        checkedIconWidget: checkedIconWidget,
                        unCheckedWidget: unCheckedWidget,
                      ),
                    ]),
                  )),


                  title("常规checkbox"),
                  const SizedBox(height: 30),
                  CustomCheckBox(
                    iconLeft: true,
                    checked: true,
                    checkedCallBack: (checked) {
                      print("------------>${checked}");
                    },
                    uncheckedIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "images/nor_icon_16@2x.png",
                          width: 25,
                          height: 25,
                        )),
                    checkIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "images/sel_icon_13@2x.png",
                          width: 25,
                          height: 25,
                        )),
                    checkedText: const Text("已经勾选自动登录",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    unCheckedText: const Text("下次自动登录",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),

                  ),


                  title("多选的复选框"),
                  SizedBox(height: 60,child:  FunctionContainer(
                    defaultCheckeds: defaultCheckboxIds,
                    allowMultipleChoice: true,
                    multipleCheckedChange: (list){
                      defaultCheckboxIds = list as List<int>;
                      setState(() {

                      });
                      Toast.show(context: context, msg: "选中的CheckBox: ${list.toString()}");
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      FunctionCheckbox(
                          index: 0,
                          iconLeft: true,
                          uncheckedIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/nor_icon_16@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/sel_icon_13@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkedText: const Text("item1",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          unCheckedText: const Text("item1",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)
                          )),

                      const SizedBox(width: 10),
                      FunctionCheckbox(
                          index: 1,
                          iconLeft: true,
                          uncheckedIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/nor_icon_16@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/sel_icon_13@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkedText: const Text("item2",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          unCheckedText: const Text("item2",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)
                          )),
                      const SizedBox(width: 10),
                      FunctionCheckbox(
                          index: 2,
                          iconLeft: true,
                          uncheckedIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/nor_icon_16@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/sel_icon_13@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkedText: const Text("item3",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          unCheckedText: const Text("item3",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)
                          )),
                      const SizedBox(width: 10),
                      FunctionCheckbox(
                          index: 3,
                          iconLeft: true,
                          uncheckedIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/nor_icon_16@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkIcon: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "images/sel_icon_13@2x.png",
                                width: 25,
                                height: 25,
                              )),
                          checkedText: const Text("item4",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          unCheckedText: const Text("item4",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)
                          )),
                    ]),
                  )),


                  title("倒计时控件"),
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
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: const Text("获取验证码",style: TextStyle(color: Colors.white,fontSize: 16))));
                      } else {
                        print("--------请$time秒后再试");
                      }

                      return Container(
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Text("请$time秒后再试",style: const TextStyle(color: Colors.red,fontSize: 16)));
                    },
                  ),
                ]
            )),),
    ));
  }

  Widget title(String title){

    return  Row(children: [Expanded(child: Container(
        margin: const EdgeInsets.only(top: 10,bottom: 10),
        child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 16))))]);
  }
}
