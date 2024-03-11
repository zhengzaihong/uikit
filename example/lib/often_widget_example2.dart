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

class _OftenWidgetExampleState2 extends State<OftenWidgetExample2> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

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
                            const SizedBox(height: 20),

                            SizedBox(
                              width: 300,
                              child: ListView.separated(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  return Center(child:  TextExtend(
                                    "测试文本鼠标效果 item $index",
                                    onTap: (){

                                    },
                                    isSelectable: false,
                                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                    onHoverPadding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                    borderRadius: BorderRadius.circular(50),
                                    splashColor: Colors.purple,
                                    highlightColor: Colors.purple,
                                    onHoverPrefix: const Icon(Icons.access_alarm),
                                    onHoverSuffix:const Icon(Icons.account_circle,color: Colors.blue),
                                    suffix: const Icon(Icons.account_circle),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.purple,
                                            width: 1
                                        )
                                    ),
                                    onHoverDecoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 1
                                        )
                                    ),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                    onHoverStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),);
                                }, separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 10);
                              },),
                            ),
                            const SizedBox(height: 20),



                            GestureDetector(
                              behavior: HitTestBehavior.deferToChild,
                              child: MousePopupButton(
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.purple,
                                      )
                                  ),
                                  child: const Text("鼠标右键弹窗测试",style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  )),
                                ),
                                onSelected: (dynamic v) {
                                },
                                itemBuilder: (context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem(
                                    value: '1',
                                    child: ListTile(
                                      title: Text('查看'),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: '2',
                                    child: ListTile(
                                      title:  Text('删除'),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: '3',
                                    child: ListTile(
                                      title: Text('翻译'),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                      value: '4',
                                      child: ListTile(
                                        title:  Text('跳转'),
                                      )
                                  ),
                                ],
                              ),
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
