import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class InfiniteLevelsExample extends StatefulWidget {
  const InfiniteLevelsExample({Key? key}) : super(key: key);

  @override
  State<InfiniteLevelsExample> createState() => _InfiniteLevelsExampleState();
}

class _InfiniteLevelsExampleState extends State<InfiniteLevelsExample> {


  List<InfiniteLevelsBean>   menues = [

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


  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title: const Text("无限层级菜单"),
      ),
      backgroundColor: Colors.white,
      body:  Row(children: [

        SizedBox(width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(
                  margin: const EdgeInsets.only(left: 10,top: 10),
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
                                  border: Border.all(color: isCurrent?Colors.red:Colors.white),
                                  color: isCurrent?Colors.lightBlue:Colors.white
                              ),
                              child: Text(data.name.toString(),style: TextStyle(fontSize: lv==1?18:lv==2?16:12)),
                            ));
                      }
                      return const SizedBox();
                    },
                    buildChildContainer: (data,lv){
                      return (data as InfiniteLevelsBean).childs??[];
                    },
                  ),
                ))
              ],
            )),

        SizedBox(width: 1,child: Container(color: Colors.grey,width: 1)),

        Expanded(child: Container(
          alignment: Alignment.center,
          child: const Text("假装是右边内容~"),))
      ]),
    ));
  }

}




class InfiniteLevelsBean{

  String? name;
  String? code;

  List<dynamic>? childs;

  InfiniteLevelsBean(this.name,this.code,this.childs);


}
