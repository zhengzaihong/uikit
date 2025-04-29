import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/card/stack_card.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025/1/16
/// create_time: 15:48
/// describe: 堆叠卡片组件
///

class StackCardDemo extends StatefulWidget {
  const StackCardDemo({Key? key}) : super(key: key);
  @override
  State<StackCardDemo> createState() => _SwipeCardDemoState();
}

class _SwipeCardDemoState extends State<StackCardDemo> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10),),
          Center(
            child: getList(SlideType.vertical,CardOrientation.top,"向上"),
          ),

          const Padding(padding: EdgeInsets.only(top: 10),),
          getList(SlideType.horizontal,CardOrientation.left,"向左"),
        ],
      ),
    );
  }
}