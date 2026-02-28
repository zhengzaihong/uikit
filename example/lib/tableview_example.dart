import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit_plus/uikit_lib.dart';

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
    //横屏
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]
    );
    for (var i = 0; i < 50; i++) {
      list.add(TestBean(name: "姓名$i", age:"18",phone: "123456$i",address: "这是一段很长很长的地址测试$i",birth: "生日$i",card: 'item$i'));
    }
  }

  Widget _cell(String text) {
    return Container(
      alignment: Alignment.center,
      child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
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
                  child: TableExtendCells(
                    rowStyle: rowStyle,
                    children: [
                      _cell("操作"),
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
                return Container(
                  width: rowStyle.rowWidth,
                  height: 40,
                  decoration:  const BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: TableExtendCells(
                    rowStyle: rowStyle,
                    children: [
                      _cell("其他"),
                    ],
                  ),
                );
              },
              fixFootRowStyle: (rowStyle){
                TestBean bean = rowStyle.data!;
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
                          child: TableExtendCells(
                            rowStyle: rowStyle,
                            children: [
                              _cell(bean.phone!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },

              cellWidthFlex: const [1,3,1,1,2,4],
              buildTableHeaderStyle: (context,rowStyle){
                final rowWidth = rowStyle.rowWidth;
                return Container(
                  width: rowWidth,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent),
                  child: TableExtendCells(
                    rowStyle: rowStyle,
                    children: [
                      _cell("姓名"),
                      _cell("年龄"),
                      _cell("生日"),
                      _cell("身份证"),
                      _cell("电话号码"),
                      _cell("住址"),
                    ],
                  )
                );
              },
              buildRowStyle: (rowStyle){
                TestBean bean = rowStyle.data!;
                final rowWidth = rowStyle.rowWidth;
                int index = rowStyle.index!;
                return IntrinsicHeight(
                  child: Container(
                    width: rowWidth,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                    child: TableExtendCells(
                      rowStyle: rowStyle,
                      children: [
                        _cell(bean.name!),
                        _cell(bean.age!),
                        _cell(bean.birth!),
                        _cell(bean.card!),
                        _cell(bean.phone!),
                        _cell(index%2==0?bean.address!:'sssssss'),
                      ],
                    )
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