import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

import 'bean/tab_type_bean.dart';

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

  List<TabTypeBean> tabs = [
    TabTypeBean(name: "新增分类",id: 0),
    TabTypeBean(name: "修改分类",id: 1),
    TabTypeBean(name: "删除分类",id: 2),
    TabTypeBean(name: "新增套餐",id: 3),
    TabTypeBean(name: "刷新",id: 4),
    TabTypeBean(name: "更多操作",id: 5,fontIcon: 0xe669),
  ];



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
                  const SizedBox(height: 200),

                 Center(child:SizedBox(
                   width: 100,
                   height: 100,
                   child: RadarNDimensionsChart(
                     cycleRadius: 22,
                     data:[
                       RadarBean(20, '认知', bgColor:Colors.blue,textStyle: const TextStyle(color: Colors.white,fontSize: 13)),
                       RadarBean(30, '心理', bgColor:Colors.green,textStyle: const TextStyle(color: Colors.white,fontSize: 13)),
                       RadarBean(40, '运动', bgColor:Colors.red,textStyle: const TextStyle(color: Colors.white,fontSize: 13)),
                       RadarBean(50, '活力', bgColor:Colors.yellow,textStyle: const TextStyle(color: Colors.white,fontSize: 13)),
                       RadarBean(60, '感官', bgColor:Colors.purple,textStyle: const TextStyle(color: Colors.white,fontSize: 13)),
                     ],
                   ),
                 ),),

                  const SizedBox(height: 200),

                  Center(child: SizedBox(
                    width: 400,
                    height: 400,
                    child:  Radar5DimensionsChart(
                        radius: 70,
                        padding: 20,
                        cycleRadius: 20,
                        radarType: RadarType.normal,
                        zeroToPointPaint: Paint()
                          ..style = PaintingStyle.stroke
                          ..color = Colors.purpleAccent.withOpacity(0.3)
                          ..strokeWidth = 0.5,
                        contentPaint: Paint()
                          ..color = Colors.redAccent.withAlpha(100)
                          ..strokeWidth = 2
                          ..style = PaintingStyle.fill,
                        pentagonPaint: Paint()
                          ..color = Colors.cyanAccent.withOpacity(0.1)
                          ..strokeWidth = 1
                          ..style = PaintingStyle.fill,
                        data:[
                          RadarBean(40, '认知', bgColor:Colors.blue,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(55, '心理', bgColor:Colors.green,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(30, '运动', bgColor:Colors.red,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(20, '活力', bgColor:Colors.yellow,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(10, '感官', bgColor:Colors.purple,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                        ]
                    ),
                  ),),
                  Center(child: SizedBox(
                    width: 400,
                    height: 400,
                    child:  Radar5DimensionsChart(
                        radius: 70,
                        padding: 20,
                        cycleRadius: 30,
                        radarType: RadarType.inner,
                        data:[
                          RadarBean(40, '认知', bgColor:Colors.blue,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(55, '心理', bgColor:Colors.green,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(30, '运动', bgColor:Colors.red,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(20, '活力', bgColor:Colors.yellow,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                          RadarBean(10, '感官', bgColor:Colors.purple,textStyle: const TextStyle(color: Colors.white,fontSize: 14)),
                        ]
                    ),
                  ),),


                  RotatingView(
                      speed: const Duration(milliseconds: 2000),
                      child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child:const Text("旋转的View"))),
                  const SizedBox(height: 20),

                  TextExtend(
                    text: "有动画的TextExtend",
                    onTap: (){

                    },
                    animation: true,
                    mainAxisSize: MainAxisSize.min,
                    isSelectable: false,
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    onHoverPadding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    borderRadius: BorderRadius.circular(50),
                    splashColor: Colors.purple,
                    highlightColor: Colors.purple,
                    prefix:const Icon(Icons.access_alarm) ,
                    onHoverPrefix: const Icon(Icons.access_alarm),
                    onHoverSuffix:const Icon(Icons.account_circle,color: Colors.blue),
                    suffix: const Icon(Icons.account_circle),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.white,
                            width: 1
                        )
                    ),
                    onHoverDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.white,
                            width: 1
                        ),
                       boxShadow: [
                         ///只底部显示发光阴影
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 10),
                        ),
                       ]
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
                  ),


                  const SizedBox(height: 20),

                  ZTooltip(
                      color: Colors.black54,
                      width: 220,
                      height: 60,
                      fixedTip: true,
                      duration: const Duration(
                          milliseconds: 500
                      ),
                      length: 100,
                      buildTip: (tip) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                        child: Row(
                          children: [
                            ...['翻译','查询','下载','取消']
                                .map((e) =>GestureDetector(
                              onTap: (){

                                RenderBox renderBox = tip.context.findRenderObject() as RenderBox;
                                final offset = renderBox.localToGlobal(Offset.zero);
                                Toast.showCustomPoint(
                                buildToastPoint: (context,style){
                                  return Positioned(
                                    child:style.call(context,'点击了$e'),
                                    left: offset.dx, top: offset.dy+60,);
                                });

                                tip.close();
                              },
                              child:  Row(
                                children: [
                                  Text(e,style: const TextStyle(color: Colors.white,fontSize: 16)),
                                  Visibility(
                                      visible: e != '取消',
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10,top: 4,right: 10),
                                        color: Colors.white,
                                        height: 15,
                                        width: 1,
                                      ))
                                ],
                              ),
                            )).toList(),
                          ],
                        ),
                      ),
                      //需要自定义位置可实现该方法。
                      layout: (zTooltip,offset,child,size){
                        return Positioned(
                            left: offset.dx,
                            top: offset.dy+size.height,
                            child: child);
                      },
                      child: TextExtend(
                        text: "自定义Tooltip组件",
                        onTap: (){

                        },
                        mainAxisSize: MainAxisSize.min,
                        isSelectable: false,
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        onHoverPadding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        borderRadius: BorderRadius.circular(50),
                        splashColor: Colors.purple,
                        highlightColor: Colors.purple,
                        prefix:const Icon(Icons.access_alarm) ,
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
                      )
                    // child: const Text('自定义Tooltip组件')
                  ),

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


                            DecoratedBox(decoration: BoxDecoration(
                              color: Colors.lightBlue.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...tabs.map((e) => Row(
                                    children: [
                                      TextExtend(
                                        text:e.name??'',
                                        height: 40,
                                        width: 120,
                                        onTap: (){
                                        },
                                        isSelectable: false,
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        decoration: BoxDecoration(
                                          borderRadius: e.id==0?const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                                              : e.id==5?const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)):null,
                                          color: Colors.transparent,
                                        ),
                                        onHoverDecoration: BoxDecoration(
                                          borderRadius: e.id==0?const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                                              : e.id==5?const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)):null,
                                          color: Colors.lightBlue,
                                        ),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        onHoverStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                        alignment: Alignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        builder: (context,child, hover){
                                          return e.fontIcon==null?null:SelectionMenu(
                                              popWidth: 200,
                                              barrierColor: Colors.transparent,
                                              buttonBuilder: (isShow) {
                                                return Container(
                                                  height: 40,
                                                  width: 120,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(e.name!,
                                                          style: TextStyle(
                                                              color: hover?Colors.white:Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18)),
                                                      Icon(isShow
                                                          ? Icons.arrow_drop_up_rounded
                                                          : Icons.arrow_drop_down_rounded),
                                                    ],
                                                  ),
                                                );
                                              },
                                              selectorBuilder: (context) {
                                                final items = [
                                                  TabTypeBean(name: "适用机构", id: 0),
                                                  TabTypeBean(name: "执行科室", id: 1),
                                                  TabTypeBean(name: "收费对照", id: 2),
                                                  TabTypeBean(name: "检查部位", id: 3),
                                                  TabTypeBean(name: "部位选择", id: 4),
                                                  TabTypeBean(name: "采集方式", id: 5),
                                                ];
                                                return Container(
                                                  height: 200,
                                                  width: 200,
                                                  padding:
                                                  const EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border:
                                                      Border.all(color: Colors.grey, width: 1),
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(0.0, 1.0),
                                                          blurRadius: 2.0,
                                                          spreadRadius: 1.0,
                                                        )
                                                      ]),
                                                  child: ListView.separated(
                                                    itemCount: items.length,
                                                    itemBuilder: (context, index) {
                                                      final item = items[index];
                                                      return Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 10, right: 10),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(item.name!,
                                                              style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 16)),
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (BuildContext context, int index) {
                                                      return const Divider();
                                                    },
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    ],
                                  )).toList()
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 300,
                              child: ListView.separated(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  return Center(child:  TextExtend(
                                    text: "测试文本鼠标效果 item $index",
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


                            DecoratedBox(decoration: BoxDecoration(
                              color: Colors.lightBlue.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ..."1234".toList().map((e) => Row(
                                    children: [
                                      TextExtend(
                                        text:"测试文本鼠标效果 item $e",
                                        onTap: (){

                                          print("----------e:$e");

                                        },
                                        height: 40,
                                        width: 220,
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        decoration: BoxDecoration(
                                           borderRadius: e=='1'?const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                                               :e=='4'?const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)):null,
                                            color: Colors.transparent,
                                        ),
                                        onHoverDecoration: BoxDecoration(
                                          borderRadius: e=='1'?const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                                              :e=='4'?const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)):null,
                                            color: Colors.lightBlue,
                                        ),
                                        alignment: Alignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        onHoverPrefix: const Icon(Icons.access_alarm),
                                        onHoverSuffix:const Icon(Icons.account_circle,color: Colors.blue),
                                        suffix: const Icon(Icons.account_circle),
                                        customChildLayout: (context,prefix,child,suffix){
                                          ///添加自定义时，注意别忘了 return child信息
                                          return Center(child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              prefix,
                                              child,
                                              suffix,
                                            ],
                                          ));
                                        },
                                        builder: (context,child,isHover){
                                          return  e=="4"? Container(
                                            height: 40,
                                            width: 220,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                              color: isHover?Colors.red:Colors.white12,
                                            ),
                                            child: Text('StatsD',style: TextStyle(color: isHover?Colors.white:Colors.black),),

                                          ):child;
                                        },
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        onHoverStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                      e=='4'?const SizedBox(): Container(
                                        height: 40,
                                        width: 1,
                                        color: Colors.white,
                                      )
                                    ],
                                  )).toList()
                                ],
                              ),
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

