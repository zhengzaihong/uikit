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
class OftenWidgetExample2 extends StatefulWidget {
  const OftenWidgetExample2({Key? key}) : super(key: key);

  @override
  _OftenWidgetExampleState2 createState() => _OftenWidgetExampleState2();

}

class _OftenWidgetExampleState2 extends State<OftenWidgetExample2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("常用小组件2"),
      ),
      backgroundColor: Colors.brown,
      body:Container(
        margin: const EdgeInsets.only(left: 20,top: 20,bottom: 30),
        child:  SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            FloatExpendButton(
                              //菜单图标组 可以是其他组件
                              iconList: [
                                FloatButtonStyle(
                                  icon: const Icon(
                                    Icons.add,
                                    size: 10,
                                  ),
                                  tabColor: Colors.red,
                                ),
                                FloatButtonStyle(
                                  icon: const Icon(
                                    Icons.share,
                                    size: 10,
                                  ),
                                  tabColor: Colors.yellow,
                                ),

                                FloatButtonStyle(
                                  icon: const Icon(
                                    Icons.add_a_photo_sharp,
                                    size: 10,
                                  ),
                                  tabColor: Colors.purple,
                                ),
                              ],
                              callback: (int index) {
                                print(index);
                              },
                              mainTabBeginColor: Colors.pinkAccent,
                              mainTabAfterColor: Colors.blue,
                              fabHeight: 30,
                              tabSpace: 5,
                              type: ButtonType.right,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]
            )),),
    );
  }

}
