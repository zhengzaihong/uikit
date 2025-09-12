import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';


class ToastExample extends StatefulWidget {

  const ToastExample({Key? key}) : super(key: key);

  @override
  State<ToastExample> createState() => _ToastExampleState();
}

class _ToastExampleState extends State<ToastExample> {
  TimeViewController controller = TimeViewController();
  OverlayEntryManger? overlayEntryManger;
  @override
  void initState() {
    super.initState();

    // Toast().initBaseStyle(
    //     globalToastDecoration: const BoxDecoration(
    //       color: Colors.lightGreen,
    //       borderRadius: BorderRadius.all(Radius.circular(30)),
    //     ),
    // );

    ///初始化Toast  可选，内部默认有样式
    // Toast()
    //   ..globalPosition = ToastPosition.center
    //   ..intervalTime = 2000
    //   ..showTime = 5000
    //   ..globalBuildToastStyle  = (context,msg){
    //     return Container(
    //         width: MediaQuery
    //             .of(context)
    //             .size
    //             .width,
    //         height: 60,
    //         margin: const EdgeInsets.only(left: 20,right: 20),
    //         alignment: Alignment.center,
    //         decoration: const BoxDecoration(
    //           color: Colors.lightBlueAccent,
    //           borderRadius: BorderRadius.all(Radius.circular(30)),
    //         ),
    //         child: Text(msg,
    //             style: const TextStyle(
    //                 decoration: TextDecoration.none,
    //                 color: Colors.white,
    //                 fontSize: 14)));
    //   };

  }


  @override
  Widget build(BuildContext  baseContext) {

    return  Scaffold(
        appBar: AppBar(
          title: const Text("Toast"),
        ),
        backgroundColor: Colors.brown,
        endDrawer: SmartDrawer(
          widthPercent: 0.8,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Toast.show("我是侧边栏~~~");
              },
              child: const Text("一个侧边页面"),
            ),
          ),
        ),
        body: LayoutBuilder(builder: (mContext,_){
          return Column(
              children: [

                FilledButton.tonal(
                    onPressed: (){
                      Toast.show("这是一条Toast");
                    },
                    child: const Text("常规Toast",style: TextStyle(color: Colors.black))),


                vGap(10),
                FilledButton.tonal(
                    onPressed: (){
                      // /自定义样式toast
                      Toast.show( "自定义样式toast",buildToastStyle: (context,msg){
                        return Container(
                            margin: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width/3,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_circle,size: 20,color: Colors.lightBlueAccent),
                                  const SizedBox(width: 5),
                                  Text(msg,style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,fontSize: 12)),
                                  const SizedBox(width: 5),
                                ]));
                      });
                    },
                    child: const Text("自定义样式toast",style: TextStyle(color: Colors.black))),


                vGap(10),
                FilledButton.tonal(
                    onPressed: (){
                      final r = Random().nextInt(2000);
                      Toast.showQueueToast(
                        "消息随机数：${r.toString()}",
                        ///内部有默认样式，可自定义设置toast的样式
                          buildStyle: (context,task){
                          return Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(task.msg,style: const TextStyle(color: Colors.black,fontSize: 16)),
                          );
                        }
                      );
                    },
                    child: const Text("支持自定义样式的队列toast",style: TextStyle(color:Colors.black))),

                vGap(10),
               LayoutBuilder(
                   builder: (context,box){
                    return   FilledButton.tonal(
                        onPressed: (){
                       ///自定义位置 任意组件同理
                       RenderBox renderBox = context.findRenderObject() as RenderBox;
                       final offset = renderBox.localToGlobal(Offset.zero);
                       Toast.showCustomPoint(
                           showTime: 3000,
                           buildToastPoint: (context,style){
                             return Positioned(
                               child:Bubble(
                                 arrowPositionPercent: 0.5,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(12),
                                   border: Border.all(color: Colors.black12, width: 1),
                                   boxShadow: const [
                                     BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
                                   ],
                                 ),
                                 child:const Text("自定义位置Toast",style: TextStyle(color: Colors.black,fontSize: 16)),
                               ),
                               left: offset.dx, top: offset.dy+60,);
                           });

                     },
                     child: const Text("根据坐标显示Toast",style: TextStyle(color: Colors.black))
                 );
                }),

                vGap(10),
                FilledButton.tonal(
                    onPressed: () async{
                     overlayEntryManger = await Toast.show("",
                          showTime: 11*1000,
                          buildToastStyle: (context,_){
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
                                    controller: controller,
                                    build: (context, time) {
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
                                        Toast.cancel(overlayEntryManger);
                                      },
                                      child: const Center(child: Text("取消",style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.black54,fontSize: 16)),)),)),
                                ]))
                          ]),
                        );
                      });
                    },
                    child: const Text("用Toast仿dialog",style: TextStyle(color: Colors.black))),
              ]
          );
        }));
  }
}
