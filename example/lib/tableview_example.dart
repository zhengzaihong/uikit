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

  Widget _cellBuilder(String title,double flex,RowStyleParam styleParam){
    return   Container(
      width: flex*1,
      alignment: Alignment.center,
      // decoration: styleParam.enableDivider? const BoxDecoration(
      //   border: Border(left: BorderSide(color: Colors.cyanAccent,width: 1)),
      // ):null,
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
      body:Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child:  Text("双向滚动示例",style: TextStyle(color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500))),
            const SizedBox(height: 30),
            Expanded(child:  TableViewExtend<TestBean>(
              enableDivider: true,
              // gridDivider: false,
              dividerColor: Colors.grey,
              enableFixHeaderColumn: true,
              enableFixFootColumn: true,
              tableDatas: list,
              minCellWidth:60,
              shrinkWrap: true,
              fixCellHeaderWidthFlex: [1,],
              buildFixHeaderTableHeaderStyle: (context,rowStyle){
                return Container(
                  width: rowStyle.rowWidth,
                  height: 40,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    children: [
                      _cellBuilder("姓名",rowStyle.cellWidth![0],rowStyle),
                      // _cellBuilder("姓名1",rowStyle.cellWidth![0],rowStyle),
                      // _cellBuilder("姓名2",rowStyle.cellWidth![0],rowStyle),
                    ],
                  ),
                );
              },
              fixHeaderRowStyle: (rowStyle){
                TestBean bean = rowStyle.data;
                return IntrinsicHeight(
                  child: Container(
                    width: rowStyle.rowWidth,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    child:Column(
                      children: [ Expanded(child: Row(
                        children: [
                          _cellBuilder("姓名11", rowStyle.cellWidth![0],rowStyle),
                          // _cellBuilder("姓名22", rowStyle.cellWidth![0],rowStyle),
                          // _cellBuilder("姓名33", rowStyle.cellWidth![0],rowStyle),
                          // _cellBuilder(bean.name!+"1", rowStyle.cellWidth![0],rowStyle),
                          // _cellBuilder(bean.name!+"2", rowStyle.cellWidth![0],rowStyle),
                        ],
                      ))],
                    ),
                  ),
                );
              },

              fixCellFootWidthFlex: [1,],
              buildFixFootTableHeaderStyle: (context,rowStyle){
                final cellsWidth = rowStyle.cellWidth!;
                return Container(
                  width: rowStyle.rowWidth,
                  height: 40,
                  margin: EdgeInsets.only(top: 1),
                  decoration:  BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    children: [
                      _cellBuilder("电话",cellsWidth[0],rowStyle),
                    ],
                  ),
                );
              },
              fixFootRowStyle: (rowStyle){
                TestBean bean = rowStyle.data!;
                final cellsWidth = rowStyle.cellWidth!;
                final rowWidth = rowStyle.rowWidth;
                return IntrinsicHeight(
                  child: Container(
                    width: rowWidth,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    child:Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            print("-------------bean.phone:${bean.phone}");
                          },
                          child: _cellBuilder(bean.phone!, cellsWidth[0],rowStyle),
                        ),
                      ],
                    ),
                  ),
                );
              },

              cellWidthFlex: const [1,3,1,1,2,4],
              buildTableHeaderStyle: (context,rowStyle){
                final flex = rowStyle.cellWidth!;
                final rowWidth = rowStyle.rowWidth;
                return Container(
                  width: rowWidth,
                  height: 40,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent),
                  child: Row(
                    children: [
                      _cellBuilder("姓名",flex[0],rowStyle),
                      _cellBuilder("年龄",flex[1],rowStyle),
                      _cellBuilder("生日",flex[2],rowStyle),
                      _cellBuilder("身份证",flex[3],rowStyle),
                      _cellBuilder("电话号码",flex[4],rowStyle),
                      _cellBuilder("住址",flex[5],rowStyle),

                    ],
                  ),
                );
              },
              buildRowStyle: (rowStyle){
                TestBean bean = rowStyle.data!;
                final flex = rowStyle.cellWidth!;
                final rowWidth = rowStyle.rowWidth;
                int index = rowStyle.index!;
                double sum = flex.reduce((value, element) => value+element);
                print("----------rowWidth--${rowWidth}---sum--$sum");
                return IntrinsicHeight(
                  child: Container(
                    width: rowWidth,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    child:Row(
                      children: [
                        _cellBuilder(bean.name!, flex[0],rowStyle),
                        _cellBuilder(bean.age!, flex[1],rowStyle),
                        _cellBuilder(bean.birth!, flex[2],rowStyle),
                        _cellBuilder(bean.card!, flex[3],rowStyle),
                        _cellBuilder(bean.phone!, flex[4],rowStyle),
                        _cellBuilder(index%2==0?bean.address!:'sssssss', flex[5]-1,rowStyle),
                      ],
                    ),
                  ),
                );
              },
            )),

            const SizedBox(height: 30),
            Row(children: const [
              Expanded(child:  Center(child:  Text("放射科检查报告单(垂直滑动表格)",style: TextStyle(color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))))
            ]),

            const SizedBox(height: 10),

          Expanded(child:   Padding(
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
                    CellBean(name: "中西医结合科医疗单位,中西医结合科医疗单位,中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中"),
                    CellBean(name: "床位号",isTitle: true),
                    CellBean(name: "中西医结合科医疗单位,中西医结合科医疗单位,中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，中西医结合科医疗单位，"
                        "中西医结合科医疗单位中西医结合科医疗单位11111中西医结合科医疗单位,中西医结合科医疗单位,中西医结合科医疗单位，中西医结合科医疗单位，"),
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
              buildRowStyle: (rowStyle){
                final index = rowStyle.index;
                final data = rowStyle.data;
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
            ),))

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