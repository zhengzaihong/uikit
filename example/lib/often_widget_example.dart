import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';
import 'package:uikit_example/utils/font_utils.dart';

import 'bean/tab_type_bean.dart';

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
  List<TabTypeBean> tabs = [
    TabTypeBean(name: "新增分类", id: 0),
    TabTypeBean(name: "修改分类", id: 1),
    TabTypeBean(name: "删除分类", id: 2),
    TabTypeBean(name: "新增套餐", id: 3),
    TabTypeBean(name: "刷新", id: 4),
    TabTypeBean(name: "更多操作", id: 5, fontIcon: 0xe669),
  ];
  final zTooltipController = ZToolTipController();

  var checked = false;
  var ratingBarCount = 3.0;

  var checkBoxBg = const BoxDecoration(color: Colors.transparent);
  var checkedIcon =  Image.asset("images/sel_icon_13@2x.png",width: 20,height: 20,);
  var unCheckedIcon = Image.asset("images/nor_icon_16@2x.png",width: 20,height: 20,);

  Widget getList(slideType,CardOrientation orientation,text){
    List<MaterialColor> colors=[Colors.blue,Colors.red,Colors.amber,Colors.blueGrey,Colors.deepPurple];
    return StackCard(
        slideType: slideType,
        orientation: orientation,
        cardSelected: (bool right,index){
          debugPrint("StackCard = $right-----$index");
        },
        children: List.generate(10, (index) => Container(
          width: 130,
          height: 130,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors[index % colors.length],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text("$index页",style:const TextStyle(fontSize: 30,color: Colors.black),),
        )));
  }

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
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: Colors.redAccent,
                        child: const Row(
                          children: [
                            FontIcon(0xe6be,size: 14,color: Colors.white),
                            Text("通知：",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        )),

                      Expanded(child: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.redAccent,
                        child: MarqueeView(
                            direction: MarqueeDirection.vertical,
                            itemExtent: 30,
                            interval: const Duration(seconds: 2),
                            animateDuration: const Duration(milliseconds: 500),
                            marqueeItems: const [
                              "这是flutter案例展示，更多内容请查看源码!1",
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

                    ]),

                  vGap(10),
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
                      Expanded(child: Container(
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
                      ))
                    ],
                  ),

                  title("堆叠卡片滑动"),
                  Row(
                   children: [
                     getList(SlideType.horizontal,CardOrientation.left,"向左"),
                     hGap(40),
                     getList(SlideType.horizontal,CardOrientation.top,"向上"),
                   ],
                 ),
                  vGap(20),

                  title("气泡组件"),
                  SizedBox(
                    width: 300,
                    height: 240,
                    child: Bubble(
                      radius: 12,
                      arrowWidth: 20,
                      arrowHeight: 12,
                      direction: BubbleArrowDirection.top,
                      arrowShape: BubbleArrowShape.triangle,
                      arrowPositionPercent: 0.1,
                      arrowAdaptive: true,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListView.separated(
                          itemCount: tabs.length,
                          itemBuilder: (context, index) {
                            final item = tabs[index];
                            return GestureDetector(
                              onTap: () {
                                 Toast.show("点击了${ item.name??""}");
                              },
                              child: Container(
                                height: 35,
                                width: 300,
                                alignment: Alignment.center,
                                child: Text(
                                  item.name??"",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                      ),
                    ),
                  ),
                  vGap(20),

                  title("进度条组件"),
                  CycleProgressBar(
                    radius: 40.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 15.0,
                    percent: 0.4,
                    center: const Text("女",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: Colors.yellow,
                    progressColor: Colors.red,
                  ),
                  vGap(10),
                  LinearProgressBar(
                    width: 200,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    leading: const Text("全栈"),
                    trailing: const Text("熟练度"),
                    percent: 0.9,
                    center: Text((0.9*100).toString()+'%'),
                    barRadius: const Radius.circular(10),
                    progressColor: Colors.red,
                  ),
                  vGap(10),
                  CycleProgressBar(
                    radius: 40.0,
                    lineWidth: 10.0,
                    percent: 0.3,
                    header: const Text("男30%"),
                    center: const Icon(
                      Icons.man_rounded,
                      size: 50.0,
                      color: Colors.blue,
                    ),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),





                  vGap(20),
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
                  vGap(20),
                  title("开关按钮"),
                  KitSwitch(
                    isOpen: checked,
                    activeTrackColor:const Color(0xFFF9820E),
                    activeColor:Colors.white,
                    inactiveTrackColor: const Color(0xFFB3B3B3),
                    onChange: (value) {
                    },
                  ),

                  vGap(20),
                  title("自定义开关按钮"),
                  ImageSwitch(
                    value: false,
                    width: 70,
                    rotate: true,
                    radius: 25,
                    height: 30,
                    activeTrackColor:const Color(0xff40D3A2),
                    inactiveTrackColor: Colors.grey,
                    duration: const Duration(milliseconds: 500),
                    inactiveImage: Image.asset('images/theme_light.png'),
                    activeImage: Image.asset('images/theme_dark.png'),
                    onChanged: (v){
                    },
                  ),


                  title("复选框"),
                  KitCheckBox(
                    iconLeft: true,
                    isChecked: true,
                    onChange: (checked) {
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

                  vGap(20),
                  title("旋转的View"),
                  RotatingView(
                      speed: const Duration(milliseconds: 2000),
                      child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text("旋转的View"))),

                  vGap(20),
                  title("多方位伸缩菜单"),
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
                      debugPrint(index.toString());
                    },
                    mainTabBeginColor: Colors.pinkAccent,
                    mainTabAfterColor: Colors.blue,
                    fabHeight: 30,
                    tabSpace: 5,
                    type: ButtonType.left,
                  ),
                  vGap(20),

                  title("自定义Tooltip提示组件"),
                  ZTooltip(
                      fixedTip: true,
                      canOnHover: false,
                      controller: zTooltipController,
                      direction: BubbleArrowDirection.top,
                      arrowShape: BubbleArrowShape.triangle,
                      arrowPositionPercent: 0.3,
                      arrowAdaptive: true,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        gradient:
                        const LinearGradient(colors: [Colors.blue, Colors.purple]),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(2, 2)),
                        ],
                      ),
                      duration: const Duration(milliseconds: 500),
                      buildTip: () => Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        child: Row(
                          children: [
                            ...['翻译', '查询', '下载', '取消']
                                .map((e) => GestureDetector(
                              onTap: () {
                                RenderBox renderBox =
                                zTooltipController.getRenderBox()!;
                                final offset =
                                renderBox.localToGlobal(Offset.zero);
                                Toast.showCustomPoint(
                                    buildToastPoint: (context, style) {
                                      return Positioned(
                                        child: style.call(context, '点击了$e'),
                                        left: offset.dx,
                                        top: offset.dy + 60,
                                      );
                                    });

                                zTooltipController.close();
                              },
                              child: Row(
                                children: [
                                  Text(e,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)),
                                  Visibility(
                                      visible: e != '取消',
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 4, right: 10),
                                        color: Colors.white,
                                        height: 15,
                                        width: 1,
                                      ))
                                ],
                              ),
                            ))
                                .toList(),
                          ],
                        ),
                      ),
                      //需要自定义位置可实现该方法。
                      layout: (offset, child, size) {
                        return Positioned(
                            left: offset.dx,
                            top: offset.dy + size.height,
                            child: child);
                      },
                      child: TextExtend(
                        text: "自定义Tooltip组件",
                        onTap: () {
                          zTooltipController.toggle();
                        },
                        mainAxisSize: MainAxisSize.min,
                        isSelectable: false,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        onHoverPadding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        borderRadius: BorderRadius.circular(50),
                        splashColor: Colors.purple,
                        highlightColor: Colors.purple,
                        prefix: const Icon(Icons.access_alarm),
                        onHoverPrefix: const Icon(Icons.access_alarm),
                        onHoverSuffix:
                        const Icon(Icons.account_circle, color: Colors.blue),
                        suffix: const Icon(Icons.account_circle),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.purple, width: 1)),
                        onHoverDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 1)),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        onHoverStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )),


                  vGap(20),
                  title("仿JS菜单按钮"),
                  TextExtend(
                    text: "有动画的TextExtend",
                    onTap: () {},
                    animation: true,
                    mainAxisSize: MainAxisSize.min,
                    isSelectable: false,
                    padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    onHoverPadding:
                    const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    borderRadius: BorderRadius.circular(50),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    prefix: const Icon(Icons.access_alarm),
                    suffix: const Icon(Icons.account_circle),
                    onHoverPrefix: const Icon(Icons.access_alarm),
                    onHoverSuffix: const Icon(Icons.account_circle, color: Colors.blue),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white, width: 1)),
                    onHoverDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white, width: 1),
                        boxShadow: [
                          ///只底部显示发光阴影
                          BoxShadow(
                            color: Colors.white.setAlpha(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 10),
                          ),
                        ]),
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    onHoverStyle: const TextStyle(
                        fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),

                  vGap(20),


                  title("仿JS菜单按钮-示例1"),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.setAlpha(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...tabs
                            .map((e) => Row(
                          children: [
                            TextExtend(
                              text: e.name ?? '',
                              height: 40,
                              width: 120,
                              onTap: () {},
                              isSelectable: false,
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              decoration: BoxDecoration(
                                borderRadius: e.id == 0
                                    ? const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft:
                                    Radius.circular(10))
                                    : e.id == 5
                                    ? const BorderRadius.only(
                                    topRight:
                                    Radius.circular(10),
                                    bottomRight:
                                    Radius.circular(10))
                                    : null,
                                color: Colors.transparent,
                              ),
                              onHoverDecoration: BoxDecoration(
                                borderRadius: e.id == 0
                                    ? const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft:
                                    Radius.circular(10))
                                    : e.id == 5
                                    ? const BorderRadius.only(
                                    topRight:
                                    Radius.circular(10),
                                    bottomRight:
                                    Radius.circular(10))
                                    : null,
                                color: Colors.lightBlue,
                              ),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              onHoverStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              alignment: Alignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              build: (context, child, hover) {
                                return e.fontIcon == null
                                    ? null
                                    : SelectionMenu(
                                    popWidth: 200,
                                    barrierColor:
                                    Colors.transparent,
                                    buttonBuilder: (show) {
                                      return Container(
                                        height: 40,
                                        width: 120,
                                        alignment:
                                        Alignment.center,
                                        child: Row(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          children: [
                                            Text(e.name!,
                                                style: TextStyle(
                                                    color: hover
                                                        ? Colors
                                                        .white
                                                        : Colors
                                                        .black,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize:
                                                    18)),
                                            Icon(show
                                                ? Icons
                                                .arrow_drop_up_rounded
                                                : Icons
                                                .arrow_drop_down_rounded),
                                          ],
                                        ),
                                      );
                                    },
                                    selectorBuilder: (context) {
                                      final items = [
                                        TabTypeBean(
                                            name: "适用机构", id: 0),
                                        TabTypeBean(
                                            name: "执行科室", id: 1),
                                        TabTypeBean(
                                            name: "收费对照", id: 2),
                                        TabTypeBean(
                                            name: "检查部位", id: 3),
                                        TabTypeBean(
                                            name: "部位选择", id: 4),
                                        TabTypeBean(
                                            name: "采集方式", id: 5),
                                      ];
                                      return Container(
                                        height: 200,
                                        width: 200,
                                        padding:
                                        const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color:
                                                Colors.grey,
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius
                                                .all(
                                              Radius.circular(5),
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color:
                                                Colors.grey,
                                                offset: Offset(
                                                    0.0, 1.0),
                                                blurRadius: 2.0,
                                                spreadRadius: 1.0,
                                              )
                                            ]),
                                        child: ListView.separated(
                                          itemCount: items.length,
                                          itemBuilder:
                                              (context, index) {
                                            final item =
                                            items[index];
                                            return Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 10,
                                                  right: 10),
                                              child:
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context);
                                                },
                                                child: Text(
                                                    item.name!,
                                                    style: const TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize:
                                                        16)),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext
                                          context,
                                              int index) {
                                            return const Divider();
                                          },
                                        ),
                                      );
                                    });
                              },
                            ),
                          ],
                        ))
                            .toList()
                      ],
                    ),
                  ),
                  vGap(20),
                  title("仿JS菜单按钮-示例2"),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.setAlpha(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ..."1234"
                            .toList()
                            .map((e) => Row(
                          children: [
                            TextExtend(
                              text: "测试文本鼠标效果 item $e",
                              onTap: () {
                                debugPrint("----------e:$e");
                              },
                              height: 40,
                              width: 220,
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              decoration: BoxDecoration(
                                borderRadius: e == '1'
                                    ? const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft:
                                    Radius.circular(10))
                                    : e == '4'
                                    ? const BorderRadius.only(
                                    topRight:
                                    Radius.circular(10),
                                    bottomRight:
                                    Radius.circular(10))
                                    : null,
                                color: Colors.transparent,
                              ),
                              onHoverDecoration: BoxDecoration(
                                borderRadius: e == '1'
                                    ? const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft:
                                    Radius.circular(10))
                                    : e == '4'
                                    ? const BorderRadius.only(
                                    topRight:
                                    Radius.circular(10),
                                    bottomRight:
                                    Radius.circular(10))
                                    : null,
                                color: Colors.lightBlue,
                              ),
                              alignment: Alignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              onHoverPrefix:
                              const Icon(Icons.access_alarm),
                              onHoverSuffix: const Icon(
                                  Icons.account_circle,
                                  color: Colors.blue),
                              suffix:
                              const Icon(Icons.account_circle),
                              customChildLayout:
                                  (context, prefix, child, suffix) {
                                ///添加自定义时，注意别忘了 return child信息
                                return Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        prefix,
                                        child,
                                        suffix,
                                      ],
                                    ));
                              },
                              build: (context, child, isHover) {
                                return e == "4"
                                    ? Container(
                                  height: 40,
                                  width: 220,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.only(
                                        topRight:
                                        Radius.circular(
                                            10),
                                        bottomRight:
                                        Radius.circular(
                                            10)),
                                    color: isHover
                                        ? Colors.red
                                        : Colors.white12,
                                  ),
                                  child: Text(
                                    'StatsD',
                                    style: TextStyle(
                                        color: isHover
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )
                                    : child;
                              },
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              onHoverStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            e == '4'
                                ? const SizedBox()
                                : Container(
                              height: 40,
                              width: 1,
                              color: Colors.white,
                            )
                          ],
                        ))
                            .toList()
                      ],
                    ),
                  ),
                  vGap(20),



                  title("鼠标右键按钮"),
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
                            )),
                        child: const Text("鼠标右键弹窗测试",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )),
                      ),
                      onSelected: (dynamic v) {},
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
                            title: Text('删除'),
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
                              title: Text('跳转'),
                            )),
                      ],
                    ),
                  ),
                  vGap(20),
                  title("倒计时控件"),
                  TimeView(
                    countdown: 1000,
                    controller: controller,
                    duration: const Duration(
                        seconds: 1
                    ),
                    build: (context, time) {
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
                          child: Text("请$time秒后再试",style: const TextStyle(color: Colors.white,fontSize: 16)));
                    },
                  ),
                ]
            )),),
    );
  }

  Widget title(String title){

    return  Row(children: [Expanded(child: Container(
        margin: const EdgeInsets.only(top: 10,bottom: 10),
        child: Text(title,style: const TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold,fontSize: 16))))]);
  }
}
