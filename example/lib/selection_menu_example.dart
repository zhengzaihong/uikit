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

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title: const Text("仿系统下拉框 可高度自定义"),
      ),
      backgroundColor: Colors.white,
      body:Center(
        child: SelectionMenu(
          selectorBuilder: (context) {
            return Container(
              height: 400,
              decoration: const BoxDecoration(
                  color: Colors.yellow
              ),
            );
          }
        ),
      ),
    ));
  }

}
