import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/10
/// create_time: 9:44
/// describe: 真正的无限层级菜单，
/// 服用时，请严格按照该 demo 模型进行数据转换。 必配参数：pid,isRoot,说明详见实体类。
///
class InfiniteLevelsExample extends StatefulWidget {
  const InfiniteLevelsExample({Key? key}) : super(key: key);

  @override
  State<InfiniteLevelsExample> createState() => _InfiniteLevelsExampleState();
}

class _InfiniteLevelsExampleState extends State<InfiniteLevelsExample> {


  List<InfiniteWrapper> menues = [

    InfiniteWrapper(
      pid: "0001",
      title: "一级标题A",
      isRoot: true,
      childs: [
        InfiniteWrapper(
            pid: "0001",
            title: "二级标题1",
            childs: [

              InfiniteWrapper(
                  pid: "0001",
                  title: "三级标题1",
                  childs: [
                    InfiniteWrapper(
                        pid: "0001",
                        title: "四级标题1",
                        childs: [
                          InfiniteWrapper(
                              pid: "0001",
                              title: "五级标题1",
                              childs: [
                                InfiniteWrapper(
                                    pid: "0001",
                                    title: "六级标题1",
                                    childs: [

                                    ]
                                ),
                                InfiniteWrapper(
                                    pid: "0001",
                                    title: "六级标题2",
                                    childs: [

                                    ]
                                ),
                              ]
                          ),
                        ]
                    ),
                  ]
              ),
              InfiniteWrapper(
                  pid: "0001",
                  title: "三级标题2",
                  childs: [

                  ]
              ),
            ]
        ),
        InfiniteWrapper(
            pid: "0001",
            title: "二级标题2",
            childs: [
              InfiniteWrapper(
                  pid: "0001",
                  title: "二级标题3",
                  childs: [

                    InfiniteWrapper(
                        pid: "0001",
                        title: "二级标题4",
                        childs: [

                        ]
                    ),
                  ]
              ),
            ]
        ),
        InfiniteWrapper(
            pid: "0001",
            title: "二级标题3",
            childs: [

            ]
        ),
        InfiniteWrapper(
            pid: "0001",
            title: "二级标题4",
            childs: [

            ]
        ),
      ]
    ),

    InfiniteWrapper(
        pid: "0002",
        title: "一级标题B",
        isRoot: true,
        childs: [
          InfiniteWrapper(
              pid: "0002",
              title: "二级标题1",
              childs: [

                InfiniteWrapper(
                    pid: "0002",
                    title: "三级标题1",
                    childs: [

                    ]
                ),
                InfiniteWrapper(
                    pid: "0002",
                    title: "三级标题2",
                    childs: [

                    ]
                ),
              ]
          ),
        ]),

  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title: const Text("无限层级菜单"),
      ),
      backgroundColor: Colors.white,
      body: Row(children: [

        SizedBox(
            width: 200,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(
                  margin: const EdgeInsets.only(left: 10,top: 10),
                  child:  InfiniteLevelsMenues(
                    datas: menues,
                    oneExpand: true,
                    buildMenueItem:(state,isCurrent,data,lv){
                      if(data is InfiniteWrapper){
                        return  GestureDetector(
                            onTap: (){
                              print("---点击:${data.title}--层级：$lv");
                              state.setItem(data);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 4,right: 4,top: 5,bottom: 5),
                              margin: const EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: isCurrent?Colors.red:Colors.white),
                                  color: isCurrent?Colors.lightBlue:Colors.white
                              ),
                              child: Text(data.title.toString(),style: TextStyle(fontSize: lv==1?18:lv==2?16:12)),
                            ));
                      }
                      return const SizedBox();
                    },
                    callBackChildData: (data,lv){
                      return (data as InfiniteWrapper).childs??[];
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
