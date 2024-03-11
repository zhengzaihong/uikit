import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-02-01
/// create_time: 21:58
/// describe: 仿系统下拉框，满足其他需求场景
///
class SelectionMenuExample extends StatefulWidget {

  const SelectionMenuExample({Key? key}) : super(key: key);

  @override
  State<SelectionMenuExample> createState() => _SelectionMenuExampleState();
}

class _SelectionMenuExampleState extends State<SelectionMenuExample> {

  int? _checkedIndex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title: const Text("仿系统下拉框 可高度自定义"),
      ),
      backgroundColor: Colors.white,
      body:Center(
        child: SelectionMenu(
            popWidth: 200,
            dropDownButtonBuilder: (isShow){
            return Container(
              height: 40,
              width: 200,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                  Icon(isShow?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                ],
              ),
            );
          },
          selectorBuilder: (context) {
            return Container(
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.yellow
              ),
              child: ListView.separated(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    _checkedIndex = index;
                    Navigator.pop(context);
                  },
                  child: 'item $_checkedIndex' == 'item $index' ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("item $index",style: const TextStyle(color: Colors.red),),
                      const Icon(Icons.check,color: Colors.red,)
                    ],
                  ) : Text("item $index"),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },),
            );
          }
        ),
      ),
    ));
  }

}
