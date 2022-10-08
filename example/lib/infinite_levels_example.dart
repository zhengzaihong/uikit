

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/Infinite/infinite_levels_menues.dart';
class InfiniteLevelsExample extends StatefulWidget {
  const InfiniteLevelsExample({Key? key}) : super(key: key);

  @override
  State<InfiniteLevelsExample> createState() => _InfiniteLevelsExampleState();
}

class _InfiniteLevelsExampleState extends State<InfiniteLevelsExample> {


  List<InfiniteLevelsBean> menues = [];


  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Future.delayed(const Duration(seconds: 3),(){
        menues = [

          InfiniteLevelsBean("标题1","1",[
            InfiniteLevelsBean("子标题1","2",[
              InfiniteLevelsBean("子子标题1","3",[
                InfiniteLevelsBean("子子子标题1","4",[]),
                InfiniteLevelsBean("子子子标题2","4",[])
              ])
            ]),

            InfiniteLevelsBean("子标题2","2",[
              InfiniteLevelsBean("子子标题2","3",[])
            ]),
          ]),

          InfiniteLevelsBean("标题2","1",[
            InfiniteLevelsBean("子标题2","2",[
              InfiniteLevelsBean("子子标题2","3",[])
            ]) ]),

          InfiniteLevelsBean("标题3","1",[]),
        ];

        setState((){});
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(child:  Scaffold(
      body: Column(
        children: [
          Center(
            child:  InfiniteLevelsMenues(
              level: 100,
              datas: menues,
              buildMenueItem:(state,expand,isCurrent,data,lv){
                if(data is InfiniteLevelsBean){
                  return  GestureDetector(
                      onTap: (){
                        state.setCurrentExpand(data);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 4,right: 4,top: 5,bottom: 5),
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: isCurrent?Colors.red:Colors.grey),
                            color: isCurrent?Colors.lightBlue:Colors.grey
                        ),
                        child: Text(data.name.toString(),
                        ),
                      ));
                }
                return const SizedBox();
              },
              buildChildContainer: (data,lv){
                return (data as InfiniteLevelsBean).childs??[];
              },
            ),
          )
        ],
      ),
    ));
  }

}




class InfiniteLevelsBean{

  String? name;
  String? code;

  List<InfiniteLevelsBean>? childs;

  InfiniteLevelsBean(this.name,this.code,this.childs);


}
