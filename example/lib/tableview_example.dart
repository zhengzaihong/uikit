import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class TableViewExample extends StatefulWidget {
  const TableViewExample({Key? key}) : super(key: key);

  @override
  _TableViewExampleeState createState() => _TableViewExampleeState();
}

class _TableViewExampleeState extends State<TableViewExample> {


  var list = [
    RowBean(cells: [
      CellBean(name: "姓名",),
      CellBean(name: "张三"),
      CellBean(name: "性别"),
      CellBean(name: "男"),
      CellBean(name: "年龄"),
      CellBean(name: "42岁"),
      CellBean(name: "病人号： 2434393458u")
    ]),
    RowBean(cells: [
      CellBean(name: "姓名",),
      CellBean(name: "张三"),
      CellBean(name: "性别"),
      CellBean(name: "男"),
      CellBean(name: "年龄"),
      CellBean(name: "42岁"),
      CellBean(name: "病人号： 2434393458u")
    ])
  ];
  List<RowBean> checkedBeans = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("表格"),
      ),
      body:   Column(children: [
        Expanded(child: Container(
          padding:  const EdgeInsets.only(top: 30,left: 100,right: 100),
          color: Colors.white,
          child:SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.lightBlue,
                    child: TableView<RowBean>(
                  // enableDivider: true,
                  // enableTopDivider: true,
                  // enableBottomDivider: true,
                  doubleScroll: true,
                  tableDatas: list,
                  buildTableHeaderStyle: (context){
                    return Row(
                      children: [
                        Container(
                          width:50,
                          child: Text("姓名"),
                        ),
                        Container(
                          width:60,
                          child: Text("姓名"),
                        ),
                      ],
                    );
                  },
                  buildRowStyle: (data,index){

                    print("--------------${data.toString()})");
                    List<Widget> rows = [];
                    var cellBean =  (data as RowBean).cells;
                    int it = 0;
                    cellBean.forEach((element) {
                      it++;
                      rows.add(Container(
                        width: it*10 +50,
                        child: Text(element.name.str()),
                      ));
                      rows.add(Container(
                        color: Colors.red,
                        height: 10,
                        width: 3,
                      ));
                      print("--------------${element.name.toString()})");
                    });

                    return GestureDetector(
                      onTap: (){
                        if(checkedBeans.contains(data)){
                          checkedBeans.remove(data);
                        }else{
                          checkedBeans.add(data);
                        }
                        setState(() {

                        });
                      },
                      child: Container(
                        color: checkedBeans.contains(data)?Colors.yellow:Colors.green,
                        child: Row(children: [
                          ...rows
                        ]),
                      ),
                    );

                  },
                )),

                const SizedBox(height: 10),
                Row(children: const [
                  Expanded(child:  Center(child:  Text("放射科检查报告单",style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500))))
                ]),

                const SizedBox(height: 10),
                TableView<int>(
                  enableDivider: true,
                  enableTopDivider: true,
                  enableBottomDivider: true,
                  physics: const NeverScrollableScrollPhysics(),
                  preDealData: (){

                    List<RowBean> rowDatas = [
                      RowBean(cells: [
                        CellBean(name: "姓名",isTitle: true),
                        CellBean(name: "张三"),
                        CellBean(name: "性别"),
                        CellBean(name: "男"),
                        CellBean(name: "年龄"),
                        CellBean(name: "42岁"),
                        CellBean(name: "病人号： 2434393458u")
                      ]),

                      RowBean(cells: [
                        CellBean(name: "医嘱号",isTitle: true),
                        CellBean(name: "1472923243"),
                        CellBean(name: "就诊号",isTitle: true),
                        CellBean(name: ""),
                      ]),

                      RowBean(cells: [
                        CellBean(name: "病区",isTitle: true),
                        CellBean(name: "中西医结合科医疗单位,中西医结合科医疗单位,中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位中西医结合科医疗单位11111"),
                        CellBean(name: "床位号",isTitle: true),
                        CellBean(name: "中西医结合科医疗单位,中西医结合科医疗单位,中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，"
                            "中西医结合科医疗单位中西医结合科医疗单位11111中西医结合科医疗单位,中西医结合科医疗单位,中西医结合科医疗单位，中西医结合科医疗单位，"
                            "中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，888888888888888888888888888888888888"),
                      ]),

                      RowBean(cells: [
                        CellBean(name: "检查日期",isTitle: true),
                        CellBean(name: "2020.08.23"),
                        CellBean(name: "报告日期",isTitle: true),
                        CellBean(name: "2020.08.23"),
                      ]),

                      RowBean(cells: [
                        CellBean(name: "检查部位",isTitle: true),
                        CellBean(name: "CT上腹部平扫，CT上腹部平扫，CT上腹部平扫CT上腹部平扫，CT上腹部平扫，CT上腹部平扫，CT上腹部平扫，CT上腹部平扫，CT上腹部平扫，CT上腹部平扫，CT上腹部平扫11"),
                        CellBean(name: "床位号",isTitle: true),
                        CellBean(name: "2020.08.23"),
                      ]),
                    ];
                    return rowDatas;
                  },
                  buildRowStyle: (data,index){
                    switch(index){
                    ///第一行
                      case 1:
                        return TabRow(
                            cellWidget: const [2,4,1,1,1,1,4],
                            enableDivider: true,
                            dividerColor: Colors.black,
                            cellItem:CellItem(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                buildCell: (cell,index){
                                  if(index==1 ||  index ==6){
                                    cell.alignment = Alignment.centerLeft;
                                    cell.padding = const EdgeInsets.only(left: 10);
                                  }else{
                                    cell.alignment  = Alignment.center;
                                  }
                                  var cellBean =  (data as RowBean).cells[index];
                                  if(cellBean.isTitle){
                                    return TabSpaceText(
                                        contents: KitMath.parseStr((cellBean.name).toString()),
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        style: const TextStyle(fontSize: 14,color: Colors.black));
                                  }
                                  return Text((cellBean.name).toString(),style: const TextStyle(fontSize: 14,color: Colors.black));
                                }
                            ));
                      case 2:
                      case 3:
                      case 4:
                        return TabRow(

                            cellWidget: const [2,6,2,4],
                            enableDivider: true,
                            dividerColor: Colors.black,
                            cellItem:CellItem(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                buildCell: (cell,index){
                                  if(index==1 ||  index ==3){
                                    cell.alignment = Alignment.centerLeft;
                                    cell.padding = const EdgeInsets.only(left: 10);
                                  }else{
                                    cell.alignment  = Alignment.center;
                                  }
                                  var cellBean =  (data as RowBean).cells[index];
                                  if(cellBean.isTitle){
                                    return TabSpaceText(
                                        contents: KitMath.parseStr((cellBean.name).toString()),
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        style: const TextStyle(fontSize: 14,color: Colors.black));
                                  }
                                  return Text((cellBean.name).toString(),style: const TextStyle(fontSize: 14,color: Colors.black));
                                }
                            ));
                    }


                    return TabRow(
                        cellWidget: const [2,12],
                        dividerColor: Colors.black,
                        enableDivider: true,
                        cellItem:CellItem(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            buildCell: (cell,index){
                              if(index==1 ||  index ==6){
                                cell.alignment = Alignment.centerLeft;
                                cell.padding = const EdgeInsets.only(left: 10);
                              }
                              var cellBean =  (data as RowBean).cells[index];
                              if(cellBean.isTitle){
                                return TabSpaceText(
                                    contents: KitMath.parseStr((cellBean.name).toString()),
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    style: const TextStyle(fontSize: 14,color: Colors.black));
                              }
                              return Text((cellBean.name).toString(),style: const TextStyle(fontSize: 14,color: Colors.black));
                            }
                        ));

                  },
                ),


                const SizedBox(height: 30),
                Row(children: const [
                  Expanded(child:  Center(child:  Text("四川xxxxx医院",style: TextStyle(color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500))))
                ]),

                const SizedBox(height: 10),

                // TableView<int>(
                //   enableDivider: false,
                //   enableTopDivider: false,
                //   enableBottomDivider: false,
                //   physics: const NeverScrollableScrollPhysics(),
                //   controller: ScrollController(),
                //   preDealData: (){
                //
                //     List<RowBean> rowDatas = [
                //       RowBean(cells: [
                //         CellBean(name: "病案"),
                //         CellBean(name: "hx202206022034"),
                //         CellBean(name: "检查设备"),
                //         CellBean(name: "PHILIPS-iE22-2"),
                //         CellBean(name: "年龄"),
                //         CellBean(name: "30岁"),
                //         CellBean(name: "族别"),
                //         CellBean(name: "汉族")
                //       ]),
                //
                //
                //       RowBean(cells: [
                //         CellBean(name: "姓名"),
                //         CellBean(name: "张三"),
                //         CellBean(name: "性别"),
                //         CellBean(name: "男"),
                //         CellBean(name: "年龄"),
                //         CellBean(name: "30岁"),
                //         CellBean(name: "族别"),
                //         CellBean(name: "汉族")
                //       ]),
                //
                //       RowBean(cells: [
                //         CellBean(name: "科室"),
                //         CellBean(name: "门诊抽血室"),
                //         CellBean(name: "床号"),
                //         CellBean(name: "ks3003"),
                //         CellBean(name: "门诊/住院号"),
                //         CellBean(name: "14323023"),
                //       ]),
                //
                //       RowBean(cells: [
                //         CellBean(name: "临床诊断"),
                //         CellBean(name: "缺铁贫血"),
                //         CellBean(name: "标本种类"),
                //         CellBean(name: "--"),
                //       ]),
                //     ];
                //     return rowDatas;
                //   },
                //   buildRowStyle: (data,index){
                //     switch(index){
                //
                //       case 1:
                //         return Column(children: [
                //           TabRow(
                //               cellWidget: const [2,9,2,3],
                //               enableDivider: true,
                //               rowHeight: 40,
                //               dividerColor: Colors.white,
                //               cellItem:CellItem(
                //                   alignment: Alignment.centerLeft,
                //                   buildCell: (cell,index){
                //                     var cellBean =  (data as RowBean).cells[index];
                //                     if(index%2!=0){
                //                       return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.lightBlue));
                //                     }
                //                     return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.black));
                //                   }
                //               )),
                //
                //           Container(
                //             height: 1,
                //             color: Colors.black,)
                //         ]);
                //
                //       case 2:
                //         return TabRow(
                //             cellWidget: const [2,4,1,1,1,2,2,3],
                //             enableDivider: true,
                //             dividerColor: Colors.white,
                //              rowHeight: 40,
                //             cellItem:CellItem(
                //                 alignment: Alignment.centerLeft,
                //                 buildCell: (cell,index){
                //                   var cellBean =  (data as RowBean).cells[index];
                //                   if(index%2!=0){
                //                     return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.lightBlue));
                //                   }
                //                   return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.black));
                //                 }
                //             ));
                //
                //       case 3:
                //         return TabRow(
                //             cellWidget: const [2,6,1,2,2,3],
                //             enableDivider: true,
                //             dividerColor: Colors.white,
                //              rowHeight: 40,
                //             cellItem:CellItem(
                //                 alignment: Alignment.centerLeft,
                //                 buildCell: (cell,index){
                //                   var cellBean =  (data as RowBean).cells[index];
                //                   if(index%2!=0){
                //                     return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.lightBlue));
                //                   }
                //                   return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.black));
                //                 }
                //             ));
                //     }
                //
                //     return TabRow(
                //         cellWidget: const [2,4,2,8],
                //         dividerColor: Colors.white,
                //         enableDivider: true,
                //          rowHeight: 40,
                //         cellItem:CellItem(
                //             alignment: Alignment.centerLeft,
                //             buildCell: (cell,index){
                //               var cellBean =  (data as RowBean).cells[index];
                //               if(index%2!=0){
                //                 return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.lightBlue));
                //               }
                //               return Text(cellBean.name.toString(),style: TextStyle(fontSize: 14,color: Colors.black));
                //             }
                //         ));
                //
                //   },
                // ),

                Row(children: const [
                  Expanded(child:  Center(child:  Text("血常规24项化验单",style: TextStyle(fontSize: 14,color: Colors.black))))
                ]),

                Container(height: 2,
                    color: Colors.black),

                Row(children: const [

                  Expanded(
                      flex: 2,
                      child:  Text("项目明细",style: TextStyle(fontSize: 14,color: Colors.black))),
                  Expanded(
                      flex: 1,
                      child:  Text("检查方法",style: TextStyle(fontSize: 14,color: Colors.black))),

                  Expanded(
                      flex: 1,
                      child:  Text("结果",style: TextStyle(fontSize: 14,color: Colors.black))),
                  Expanded(
                      flex: 1,
                      child:  Text("单位",style: TextStyle(fontSize: 14,color: Colors.black))),

                  Expanded(
                      flex: 1,
                      child:  Text("参考值",style: TextStyle(fontSize: 14,color: Colors.black))),
                ]),

                Container(height: 1,
                    color: Colors.black),


                ListView.builder(
                    itemCount: 100,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return   Row(children:const  [

                        Expanded(
                            flex: 2,
                            child:  Text("中性粒细胞百分含量(NEU%)",style: TextStyle(fontSize: 14,color: Colors.black))),
                        Expanded(
                            flex: 1,
                            child:  Text("VCS技术",style: TextStyle(fontSize: 14,color: Colors.black))),

                        Expanded(
                            flex: 1,
                            child:  Text("64.72%",style: TextStyle(fontSize: 14,color: Colors.black))),
                        Expanded(
                            flex: 1,
                            child:  Text("%",style: TextStyle(fontSize: 14,color: Colors.black))),

                        Expanded(
                            flex: 1,
                            child:  Text("50.0-70.9",style: TextStyle(fontSize: 14,color: Colors.black))),
                      ]);
                    })
              ],
            ),
          ),
        ))]),
    );
  }
}
