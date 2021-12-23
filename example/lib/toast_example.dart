

import 'package:flutter/material.dart';
import 'package:uikit/drawer/smart_drawer.dart';
import 'package:uikit/toast/toast_utils.dart';

class ToastExample extends StatelessWidget {

  const ToastExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        backgroundColor: Colors.brown,
        endDrawer: SmartDrawer(
          widthPercent: 0.3,
          child: Container(
            alignment: Alignment.center,
            child: const Text("一个侧边页面"),
          ),
        ),
        body: LayoutBuilder(builder: (mContext,_){
          return Column(
              children: [

                InkWell(
                    onTap: (){
                      Toast.show(context: context, msg: "常规Toast");
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
                      Toast.getToastConfig.buildToastWidget = (context,msg){
                        return  Container(
                            margin: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width/3,
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
                                ]));
                      };
                      Toast.show(context: context, msg: "自定义样式toast");
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
                      Toast.getToastConfig.showTime=10*1000;
                      Toast.getToastConfig.buildToastWidget = (context,msg){
                        return Material(
                          color: Colors.transparent ,
                          child: InkWell(
                            onTap: (){
                              Scaffold.of(mContext).openDrawer();
                            },
                            child:  Container(
                                margin: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width/3,
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
                      };
                      Toast.show(context: context, msg: "可响应点击事件的Toast");
                    },
                    child: Container(
                        width: 200,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withAlpha(200),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text("可响应点击事件的Toast",style: TextStyle(color: Colors.white)))),
              ]
          );
        })),);
  }
}
