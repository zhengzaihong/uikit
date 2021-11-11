import 'package:flutter/cupertino.dart';
import 'package:uikit_example/expression.dart';

class ItemModel extends ChangeNotifier{

  Widget? widget;
  String? value;

  List<TextEditingController> controllers = [];


  void changeValue(String data){
    value = data;
    notifyListeners();
  }



  ItemModel(){
    widget = Row(children: [
    Expanded(child: buildSelect(
        value: value,
        contents: ["非洲","南美洲","北极洲"])),


      SizedBox(width: 10),
      Expanded(child: buildSelect(contents: ["非洲","南美洲","北极洲"])),
      SizedBox(width: 10),

      Expanded(child: buildSelect(contents: ["非洲","南美洲","北极洲"])),

      SizedBox(width: 10),
      Expanded(child: buildSelect(contents: ["非洲","南美洲","北极洲"])),
    ]);
  }
}