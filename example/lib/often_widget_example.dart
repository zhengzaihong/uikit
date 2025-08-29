import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/button/function_inheritedwidget.dart';
import 'package:flutter_uikit_forzzh/uikit_lib.dart';
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

  Widget checkedIconWidget = const FontIcon(0xe650,size: 30,color: Colors.red,);

  Widget unCheckedWidget =  const FontIcon(0xe64f,size: 30,color: Colors.white);

  List<int> defaultCheckeds = [1,2];
  List<int> defaultCheckeds2 = [1];
  List<int> defaultCheckboxIds = [1,2];


  var checked = false;

  var ratingBarCount = 3.0;



  var checkBoxBg = const BoxDecoration(color: Colors.transparent);
  var checkedIcon =  Image.asset("images/sel_icon_13@2x.png",width: 20,height: 20,);
  var unCheckedIcon = Image.asset("images/nor_icon_16@2x.png",width: 20,height: 20,);


  TimeViewController controller = TimeViewController();

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
                        child: const Row(
                          children: [
                            FontIcon(0xe6be,size: 14,color: Colors.white),
                            Text("通知：",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        )),

                      Expanded(child:  Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.redAccent,
                        child: MarqueeView(
                            direction: MarqueeDirection.vertical,
                            itemExtent: 30,
                            interval: const Duration(seconds: 2),
                            animateDuration: const Duration(milliseconds: 500),
                            marqueeItems: const [
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!1",
                              "测试代码2",
                              "垂直翻滚效果",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!1",
                              "测试代码2",
                              "垂直翻滚效果",
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!1",
                              "测试代码2",
                              "垂直翻滚效果",
                            ],
                            buildItem: (context, data) {
                              return Text(data);
                         }),
                      )),

                    ],
                  ),

                  Row(
                    children: [
                      Container(
                        width: 400,
                        alignment: Alignment.centerLeft,
                        color: Colors.redAccent,
                        child: MarqueeView(
                            direction: MarqueeDirection.horizontal,
                            itemExtent: 30,
                            interval: const Duration(seconds: 2),
                            animateDuration: const Duration(milliseconds: 800),
                            marqueeItems: const [
                              "这是flutter 基础 widget 案例展示，更多内容请查看源码!1,这是flutter 基础 widget 案例展示，更多内容请查看源码!1这是flutter 基础 widget 案例展示，更多内容请查看源码!1这是flutter 基础 widget 案例展示，更多内容请查看源码!1",
                            ],
                            buildItem: (context, data) {
                              return Text(data);
                            }),
                      )
                    ],
                  ),



                  title("评分组件"),
                  RatingBar(
                    value: ratingBarCount,
                    size: 20,
                    normalImage: Image.asset("images/wjx.png",width: 20,height: 20,),
                    selectImage: Image.asset("images/wjx1.png",width: 20,height: 20,),
                    selectAble: true,
                    readOnly: false,
                    step: 0.5,
                    maxRating: 10,
                    count: 10,
                    onRatingUpdate: (double value) {
                      setState(() {
                        ratingBarCount = value;
                        Toast.show("评分：$value");
                      });
                    },
                  ),



                  title("开关按钮"),
                  CustomSwitch(
                    isOpen: checked,
                    activeTrackColor:const Color(0xFFF9820E),
                    activeColor:Colors.white,
                    inactiveTrackColor: const Color(0xFFB3B3B3),
                    onChange: (value) {
                      checked = value;
                      debugPrint("-----checked：$checked");
                      setState(() {

                      });
                    },
                  ),

                  title("多选button 案例"),
                  SizedBox(height: 60,child: FunctionContainer(
                    defaultChecks: defaultCheckeds2,
                    allowMultipleChoice: true, //多选
                    mutualExclusionIndex: 1,
                    multipleCheckedChange: (list){
                      StringBuffer buffer  = StringBuffer();
                      for (var element in list) {
                        buffer.write(element);
                        buffer.write(",");
                      }
                      defaultCheckeds2 = list as List<int>;
                      debugPrint("------$defaultCheckeds2");
                      setState(() {
                      });
                      Toast.show("选中的按钮Id: ${buffer.toString()}");
                    },
                    child: LayoutBuilder(
                      builder: (context,boxConstraints){
                        int index = 0;
                        return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          ...["全选","CT","抽血","检查",'手术'].map((e){
                            index++;
                            return FunButtonBox(
                              index: index,
                              builderBox: (context,state, isCheck) {
                                return CustomCheckBox(
                                    key: ValueKey(isCheck),
                                    text: Text(e,style: isCheck?checkedTextStyle:unCheckTextStyle),
                                    activeColor: Colors.purple,
                                    checkColor: Colors.red,
                                    isChecked: isCheck,
                                    useDefaultStyle: false,
                                    iconLeft: true,
                                    checkIcon: const Icon(
                                        Icons.check_box, color: Colors.red),
                                    uncheckedIcon: const Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,),
                                    onChange: (v) {
                                      state.updateChange();
                                    });
                              },
                            );
                          }).toList(),
                        ]);
                      },
                    ),
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
                      FunButtonBox(
                        index: 0,
                        builderBox: (context,state, isCheck) {
                          return CustomCheckBox(
                              key: ValueKey(isCheck),
                              text: Text('化学品',style: textBlodStyle),
                              activeColor: Colors.purple,
                              checkColor: Colors.red,
                              isChecked: isCheck,
                              useDefaultStyle: false,
                              iconLeft: true,
                              checkIcon: checkedIconWidget,
                              uncheckedIcon:unCheckedWidget,
                              onChange: (v) {
                                state.updateChange();
                              });
                        },
                      ),
                      const SizedBox(width: 10),
                      FunButtonBox(
                        index: 1,
                        builderBox: (context,state, isCheck) {
                          return CustomCheckBox(
                              key: ValueKey(isCheck),
                              text: Text('毒物',style: textBlodStyle),
                              activeColor: Colors.purple,
                              checkColor: Colors.red,
                              isChecked: isCheck,
                              useDefaultStyle: false,
                              iconLeft: true,
                              checkIcon: checkedIconWidget,
                              uncheckedIcon:unCheckedWidget,
                              onChange: (v) {
                                state.updateChange();
                              });
                        },
                      ),
                      const SizedBox(width: 10),
                      FunButtonBox(
                        index: 2,
                        builderBox: (context,state, isCheck) {
                          return CustomCheckBox(
                              key: ValueKey(isCheck),
                              text: Text('射线',style: textBlodStyle),
                              activeColor: Colors.purple,
                              checkColor: Colors.red,
                              isChecked: isCheck,
                              useDefaultStyle: false,
                              iconLeft: true,
                              checkIcon: checkedIconWidget,
                              uncheckedIcon:unCheckedWidget,
                              onChange: (v) {
                                state.updateChange();
                              });
                        },
                      ),
                      const SizedBox(width: 10),
                    ]),
                  )),


                  title("复选框"),
                  CustomCheckBox(
                    iconLeft: true,
                    isChecked: true,
                    onChange: (checked) {
                      debugPrint("------------>$checked");
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



                  title("倒计时控件"),
                  TimeView(
                    countdown: 1000,
                    controller: controller,
                    duration: const Duration(
                        seconds: 1
                    ),
                    builder: (context, time) {
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
                        debugPrint("--------请$time秒后再试");
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
