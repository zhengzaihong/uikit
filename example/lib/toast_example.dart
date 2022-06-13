import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/drawer/smart_drawer.dart';
import 'package:flutter_uikit_forzzh/often/time_view.dart';
import 'package:flutter_uikit_forzzh/toast/toast_config.dart';
import 'package:flutter_uikit_forzzh/toast/toast_utils.dart';


/// 动态的会替换 全局的,尽量全局统一格式，Toast.show(...tempConfig) 支持
class ToastExample extends StatelessWidget {

  const ToastExample({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext  baseContext) {

    return MaterialApp(home: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.brown,
        endDrawer: SmartDrawer(
          widthPercent: 0.3,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text("一个侧边页面"),
          ),
        ),
        body: LayoutBuilder(builder: (mContext,_){
          return Column(
              children: [

                InkWell(
                    onTap: (){
                      Toast.show("常规Toast");
                    }, child: Container(
                    width: 200,
                    height: 40,
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.withAlpha(200),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const Text("常规Toast",style: TextStyle(color: Colors.white)))),



                InkWell(
                    onTap: (){

                      ///自定义样式toast
                      ToastConfig config1 = ToastConfig(
                          intervalTime: 2000,
                          buildToastWidget: (context,msg){
                            return  Container(
                                margin: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width/3,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent.withAlpha(200),
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.ac_unit_rounded,size: 20,color: Colors.deepPurple),
                                      const SizedBox(width: 5),
                                      Text(msg,style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,fontSize: 12)),
                                      const SizedBox(width: 5),
                                    ]));
                          });

                      Toast.show( "自定义样式toast",tempConfig: config1);
                    },
                    child: Container(
                        width: 200,
                        height: 40,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withAlpha(200),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text("自定义样式toast",style: TextStyle(color: Colors.white)))),


                InkWell(
                    onTap: (){
                      ///事件toast
                      ToastConfig config2 = ToastConfig(
                          intervalTime: 2000,
                          showTime: 5000,
                          buildToastWidget: (_,msg){
                            return Material(
                              color: Colors.transparent ,
                              child: InkWell(
                                  onTap: (){
                                    Scaffold.of(mContext).openEndDrawer();
                                  },
                                  child:  Container(
                                      width: MediaQuery.of(mContext).size.width/3,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red.withAlpha(200),
                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.ac_unit_rounded,size: 20,color: Colors.deepPurple),
                                            const SizedBox(width: 5),
                                            Text(msg,style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,fontSize: 12)),
                                            const SizedBox(width: 5),
                                          ]))),);
                          });

                      Toast.show( "点我打开侧边栏",tempConfig: config2);
                    },
                    child: Container(
                        width: 200,
                        height: 40,
                        margin: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withAlpha(200),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text("可响应点击事件的Toast",style: TextStyle(color: Colors.white)))),




                InkWell(
                    onTap: (){

                      ToastConfig config3 = ToastConfig(
                          showTime: 11*1000,
                          buildToastWidget: (_,msg){
                        return Container(
                          width: MediaQuery.of(mContext).size.width/3,
                          height: 300,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(children: [

                            Expanded(child: Stack(children: [
                              const Align(
                                  alignment: Alignment.center,
                                  child: Text("温馨提示",style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black45,fontSize: 20))),

                              Positioned(
                                  right: 0,
                                  width: 50 ,
                                  top: 25,
                                  child: TimeView(
                                 countdown: 10,
                                child: (context, controller, time) {
                                  if (!controller.isStart()) {
                                    controller.startTimer();
                                  }
                                  return Text("($time秒)",style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black45,fontSize: 14));
                                },
                              )),
                            ])),

                            Container(
                                height: 1,
                                width:MediaQuery.of(mContext).size.width/3,
                                color: Colors.grey.withAlpha(80)),


                            Expanded(flex: 2,child:Container(
                                margin: const EdgeInsets.only(top: 30,left: 20,right: 20),
                                child: RichText(
                              text: TextSpan(
                                text: '  请你务必审慎阅读、充分理解服务协议和和隐私政策各条款，包括但不限于：为了向你提供房屋信息等服务，我们需要收集你的设备信息，错误日志，定位，摄像头，通话等个人信息。你可阅读',
                                style: const TextStyle(color: Colors.black45, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '《隐私政策》 ',
                                      style: const TextStyle(color: Color(0xff4F7CAE),fontSize: 14),
                                      recognizer: TapGestureRecognizer()..onTap = (){

                                      }
                                  ),

                                  const TextSpan(
                                    text: '以及 ',
                                    style: TextStyle(color: Colors.black45,fontSize: 14),
                                  ),
                                  TextSpan(
                                      text: '《服务协议》 ',
                                      style: const TextStyle(color: Colors.lightBlue,fontSize: 14),
                                      recognizer: TapGestureRecognizer()..onTap = (){

                                      }
                                  ),

                                  const TextSpan(
                                    text: '如您同意以上协议内容，请点击“确定”，开始使用我们的产品和服务! ',
                                    style: TextStyle(color: Colors.black45,fontSize: 14),
                                  ),
                                ],
                              ),
                            ))),

                            Container(
                                height: 1,
                                width:MediaQuery.of(mContext).size.width/3,
                                color: Colors.grey.withAlpha(80)),
                            Expanded(child: Row(
                                children:  [
                                  const Expanded(child: Center(child: Text("确定",style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.lightBlue,fontSize: 16)),)),
                                  Container(
                                      height:  40,
                                      width: 1,
                                      color: Colors.grey.withAlpha(100)),

                                   Expanded(child: Material(child: InkWell(
                                       onTap: (){
                                         Toast.cancle();
                                       },
                                       child: const Center(child: Text("取消",style: TextStyle(
                                           decoration: TextDecoration.none,
                                           color: Colors.black54,fontSize: 16)),)),)),
                                ]))
                          ]),
                        );
                      });

                      Toast.show("",tempConfig: config3);

                    },
                    child: Container(
                        width: 200,
                        height: 40,
                        margin: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withAlpha(200),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text("用Toast仿dialog",style: TextStyle(color: Colors.white)))),
              ]
          );
        })),);
  }
}
