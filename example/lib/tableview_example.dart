import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class TableViewExample extends StatefulWidget {
  const TableViewExample({Key? key}) : super(key: key);

  @override
  _TableViewExampleState createState() => _TableViewExampleState();
}

class _TableViewExampleState extends State<TableViewExample> {



  List<TestBean> list = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 50; i++) {
      list.add(TestBean(name: "姓名$i", age:"18",phone: "123456$i",address: "这是一段很长很长的地址测试$i",birth: "生日$i",card: 'item$i'));
    }
  }

  Widget _cellBuilder(String title,double flex){
    return   Container(
      width: flex,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Colors.red,width: 1)),
      ),
      child:Row(
        children: [
          Expanded(child: Center(child: Text(title,style: const TextStyle(fontSize: 14,color: Colors.black)),)),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("表格"),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child:  Text("双向滚动示例",style: TextStyle(color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500))),
            Container(
               height: 500,
              margin: const EdgeInsets.only(left: 100,right: 100),
              child:  TableView<TestBean>(
              enableDivider: true,
              enableTopDivider: true,
              enableBottomDivider: true,
              dividerColor: Colors.red,
              doubleScroll: true,
              tableDatas: list,
              cellColumnCount: 6,
              minCellWidth:100,
              shrinkWrap: true,
              cellWidthFlex: const [1,1,1,1,1,1],
              buildTableHeaderStyle: (context,rowWidth,flex){
                return SizedBox(
                  width: rowWidth,
                  child: Row(
                    children: [
                      _cellBuilder("姓名",flex[0]),

                      _cellBuilder("年龄",flex[1]),
                      _cellBuilder("生日",flex[2]),
                      _cellBuilder("身份证",flex[3]),
                      _cellBuilder("电话号码",flex[4]),
                      _cellBuilder("住址",flex[5]),

                    ],
                  ),
                );
              },
              buildRowStyle: (data,index,rowWidth,flex){
                TestBean bean = data;
                return IntrinsicHeight(
                  child: SizedBox(
                    width: rowWidth,
                    child:Column(
                      children: [ Expanded(child: Row(
                        children: [
                          _cellBuilder(bean.name!, flex[0]),
                          _cellBuilder(bean.age!, flex[1]),
                          _cellBuilder(bean.birth!, flex[2]),
                          _cellBuilder(bean.card!, flex[3]),
                          _cellBuilder(bean.phone!, flex[4]),
                          _cellBuilder(index==1?bean.address!:'sssssss', flex[5]),
                        ],
                      ))],
                    ),
                  ),
                );
              },
            ),),

            const SizedBox(height: 30),
            Row(children: const [
              Expanded(child:  Center(child:  Text("放射科检查报告单",style: TextStyle(color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))))
            ]),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 100,right: 100),
              child: TableView<int>(
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
              buildRowStyle: (data,index,rowWidth,flex){
                switch(index){
                ///第一行
                  case 1:
                    return TabRow(
                        cellWidget: const [2,4,1,1,1,1,4],
                        enableDivider: true,
                        dividerColor: Colors.black,
                        cellItem:CellItem(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            buildCell: (cell,index,width){
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
                            buildCell: (cell,index,width){
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
                        buildCell: (cell,index,width){
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
            ),)

          ],
        ),
      ),
    );
  }
}

class TestBean{
  String? name;
  String? age;
  String? birth;
  String? phone;
  String? card;
  String? address;

  TestBean({
    this.name,
    this.age,
    this.birth,
    this.phone,
    this.card,
    this.address
  });
}