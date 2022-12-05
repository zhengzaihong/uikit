import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';
import 'package:uikit_example/utils/font_utils.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/1/4
/// create_time: 16:02
/// describe: 一些常用小组件
///
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
      fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w600);

  TextStyle textViewStyle = const TextStyle(
      fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w600);

  TextStyle textViewStyle1 = const TextStyle(
      fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600);

  Widget checkedIconWidget = FontIcon(0xe650,size: 30,color: Colors.red,);

  Widget unCheckedWidget =  FontIcon(0xe64f,size: 30,color: Colors.white);

  List<int> defaultCheckeds = [1,2];
  List<int> defaultCheckeds2 = [1];
  List<int> defaultCheckboxIds = [1,2];


  var checked = false;

  var ratingBarCount = 3.0;



  var checkBoxBg = const BoxDecoration(color: Colors.transparent);
  var checkedIcon =  Image.asset("images/sel_icon_13@2x.png",width: 20,height: 20,);
  var unCheckedIcon = Image.asset("images/nor_icon_16@2x.png",width: 20,height: 20,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("常用小组件"),
      ),
      backgroundColor: Colors.brown,
      body:Container(
        margin: const EdgeInsets.only(left: 20,top: 20,bottom: 30),
        child:  SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  title("跑马灯"),
                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: 30,
                        color: Colors.redAccent,
                        child:  TextView(
                          unCheckTextStyle:const TextStyle(color: Colors.white,fontSize: 14),
                          drawablePositon: PositionEnum.drawableLeft,
                          enableClick: false,
                          isChecked: false,
                          drawableWidget: FontIcon(0xe6be,size: 14,color: Colors.white),
                          title:  "通知：",
                        ),
                      ),

                      Expanded(child:  Container(
                        height: 30,
                        color: Colors.redAccent,
                        child:  const MarqueeView(
                            messages: [
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!",
                            ]),
                      ))
                    ],
                  ),



                  title("评分组件"),
                  RatingBar(
                    value: ratingBarCount,
                    size: 20,
                    nomalImage: "images/wjx.png",
                    selectImage: "images/wjx1.png",
                    selectAble: true,
                    half: true,
                    maxRating: 5,
                    count: 5,
                    onRatingUpdate: (double value) {
                      setState(() {
                        ratingBarCount = value;
                        Toast.show("评分：$value");
                      });
                    },
                  ),


                  title("仿Android TextView"),
                  Row(children: [

                    TextView(
                      title: "TextView",
                      drawablePositon: PositionEnum.drawableLeft,
                      checkedTextStyle: textViewStyle1,
                      unCheckTextStyle: textViewStyle,
                      drawablePressWidget: const Icon(Icons.alarm_rounded,color: Colors.red),
                      drawableWidget: const Icon(Icons.alarm_rounded,color: Colors.grey),
                    ),


                    const SizedBox(width: 10),
                    TextView(
                      title: "TextView",
                      drawablePositon: PositionEnum.drawableRight,
                      checkedTextStyle: textViewStyle1,
                      unCheckTextStyle: textViewStyle,
                      drawablePressWidget: const Icon(Icons.home,color: Colors.red),
                      drawableWidget: const Icon(Icons.home,color: Colors.grey),
                    ),

                    const SizedBox(width: 30),
                    TextView(
                      title: "TextView",
                      drawablePositon: PositionEnum.drawableTop,
                      checkedTextStyle: textViewStyle1,
                      unCheckTextStyle: textViewStyle,
                      drawablePressWidget: const Icon(Icons.home,color: Colors.red),
                      drawableWidget: const Icon(Icons.home,color: Colors.grey),
                    ),

                    const SizedBox(width: 30),
                    TextView(
                      title: "TextView",
                      drawablePositon: PositionEnum.drawableBottom,
                      checkedTextStyle: textViewStyle1,
                      unCheckTextStyle: textViewStyle,
                      drawablePressWidget: const Icon(Icons.home,color: Colors.red),
                      drawableWidget: const Icon(Icons.home,color: Colors.grey),
                    ),

                  ]),


                  title("开关按钮"),
                  CustomSwitch(
                    isOpen: checked,
                    activeTrackColor:Color(0xFFF9820E),
                    activeColor:Colors.white,
                    inactiveTrackColor: Color(0xFFB3B3B3),
                    onChange: (value) {
                      checked = value;
                      print("-----checked：$checked");
                      setState(() {

                      });
                    },
                  ),


                  title("单选button"),
                  SizedBox(height: 60,child:  FunctionContainer(
                    defaultCheck: 0,
                    singleCheckedChange: (checked) {
                      Toast.show(checked==1?"已启用":"已禁用");
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



                  title("多选button 案例1"),
                  SizedBox(height: 60,child: FunctionContainer(
                    defaultCheckeds: defaultCheckeds,
                    allowMultipleChoice: true, //多选
                    // mutualExclusionIndex: 1,
                    multipleCheckedChange: (list){
                      StringBuffer buffer  = StringBuffer();
                      for (var element in list) {
                        buffer.write(element);
                        buffer.write(",");
                      }
                      defaultCheckeds = list as List<int>;
                      setState(() {
                      });
                      Toast.show("选中的按钮Id: ${buffer.toString()}");
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


                  title("多选button 案例2"),
                  SizedBox(height: 60,child: FunctionContainer(
                    defaultCheckeds: defaultCheckeds2,
                    allowMultipleChoice: true, //多选
                    mutualExclusionIndex: 1,
                    multipleCheckedChange: (list){
                      StringBuffer buffer  = StringBuffer();
                      for (var element in list) {
                        buffer.write(element);
                        buffer.write(",");
                      }
                      defaultCheckeds2 = list as List<int>;
                      setState(() {
                      });
                      Toast.show("选中的按钮Id: ${buffer.toString()}");
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      ClickButton(
                        title: "全选",
                        index: 1,
                        checkedBoxDecoration: checkBoxBg,
                        unCheckedBoxDecoration: checkBoxBg,
                        drawablePositon: PositionEnum.drawableLeft,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        drawablePressWidget:checkedIcon,
                        drawableWidget: unCheckedIcon,
                        width: 66,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      ClickButton(
                        title: "CT",
                        index: 2,
                        checkedBoxDecoration: checkBoxBg,
                        unCheckedBoxDecoration: checkBoxBg,
                        drawablePositon: PositionEnum.drawableLeft,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        drawablePressWidget:checkedIcon,
                        drawableWidget: unCheckedIcon,
                        width: 66,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      ClickButton(
                        title: "抽血",
                        index: 3,
                        checkedBoxDecoration: checkBoxBg,
                        unCheckedBoxDecoration: checkBoxBg,
                        drawablePositon: PositionEnum.drawableLeft,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        drawablePressWidget:checkedIcon,
                        drawableWidget: unCheckedIcon,
                        width: 66,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      ClickButton(
                        title: "手术",
                        index: 4,
                        checkedBoxDecoration: checkBoxBg,
                        unCheckedBoxDecoration: checkBoxBg,
                        drawablePositon: PositionEnum.drawableLeft,
                        checkedTextStyle: checkedTextStyle,
                        unCheckTextStyle: unCheckTextStyle,
                        drawablePressWidget:checkedIcon,
                        drawableWidget: unCheckedIcon,
                        width: 66,
                        height: 30,
                      )
                    ]),
                  )),



                  title("单选Radio"),
                  SizedBox(height: 60,child:  FunctionContainer(
                    defaultCheck: 1,
                    singleCheckedChange: (id){
                      Toast.show("选中的radio: ${id.toString()}");
                    },
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start, children: [
                      FunctionRadioButton(
                        title: "无",
                        index: 0,
                        width: 85,
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
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        checkedIconWidget: checkedIconWidget,
                        unCheckedWidget: unCheckedWidget,
                      ),
                    ]),
                  )),


                  title("图标组件"),
                  SizedBox(height: 100,child:  FunctionContainer(
                    defaultCheck: 0,
                    singleCheckedChange: (id){
                      Toast.show("图标组件下标: ${id.toString()}");
                    },
                    child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      ClickButton(
                        title: "测试",
                        index: 0,
                        width: 100,
                        height: 60,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        drawablePressWidget: const Icon(Icons.call,color: Colors.red),
                        drawableWidget: const Icon(Icons.call,color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                      ClickButton(
                        title: "button1",
                        index: 1,
                        width: 100,
                        height: 60,
                        drawablePositon: PositionEnum.drawableLeft,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        drawablePressWidget: const Icon(Icons.call,color: Colors.red),
                        drawableWidget: const Icon(Icons.call,color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                      ClickButton(
                        title: "button2",
                        index: 2,
                        width: 100,
                        height: 60,
                        drawablePositon: PositionEnum.drawableTop,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        drawablePressWidget: const Icon(Icons.call,color: Colors.red),
                        drawableWidget: const Icon(Icons.call,color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                      ClickButton(
                        title: "button3",
                        index: 3,
                        width: 100,
                        height: 60,
                        drawablePositon: PositionEnum.drawableBottom,
                        padding: const EdgeInsets.only(left: 5),
                        checkedTextStyle: textBlodStyle,
                        unCheckTextStyle: textBlodStyle,
                        drawablePressWidget: const Icon(Icons.call,color: Colors.red),
                        drawableWidget: const Icon(Icons.call,color: Colors.red),
                      ),
                    ]),
                  )),

                  title("复选框"),
                  CustomCheckBox(
                    iconLeft: true,
                    isChecked: true,
                    onChange: (checked) {
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
                    checkedText: const Text("已勾选自动登录",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    text: const Text("下次自动登录",
                        style: TextStyle(
                            color: Colors.grey,
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
                      Toast.show("选中的CheckBox: ${list.toString()}");
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
                    countdown: 1000,
                    duration: const Duration(
                        milliseconds: 100
                    ),
                    child: (context, controller, time) {
                      if (!controller.isStart()) {
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
    );
  }

  Widget title(String title){

    return  Row(children: [Expanded(child: Container(
        margin: const EdgeInsets.only(top: 10,bottom: 10),
        child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 16))))]);
  }
}
