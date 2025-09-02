import 'package:flutter/material.dart';
import 'package:uikit/uikit_lib.dart';

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
            Expanded(child:  TableExtend<TestBean>(
              enableDivider: true,
              gridDivider: false,
              dividerColor: Colors.grey,
              enableFixHeaderColumn: true,
              enableFixFootColumn: true,
              tableDatas: list,
              minCellWidth:90,
              shrinkWrap: true,
              fixCellHeaderWidthFlex: const [1,],
              buildFixHeaderTableHeaderStyle: (context,rowStyle){
                return Container(
                  width: rowStyle.rowWidth,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    children: [
                      _cellBuilder("操作",rowStyle.cellWidth![0],rowStyle),
                    ],
                  ),
                );
              },
              fixHeaderRowStyle: (rowStyle){
                return IntrinsicHeight(
                  child: Container(
                    width: rowStyle.rowWidth,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    child:Center(child:  Container(
                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ), child: const Text("查看"))),
                  ),
                );
              },

              fixCellFootWidthFlex: const [1,],
              buildFixFootTableHeaderStyle: (context,rowStyle){
                final cellsWidth = rowStyle.cellWidth!;
                return Container(
                  width: rowStyle.rowWidth,
                  height: 40,
                  decoration:  const BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    children: [
                      _cellBuilder("其他",cellsWidth[0],rowStyle),
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
                            debugPrint("-------------bean.phone:${bean.phone}");
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
                debugPrint("----------rowWidth--$rowWidth---sum--$sum");
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