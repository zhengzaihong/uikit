import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uikit/dropwidget/async_input_drop.dart';
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

      // Expanded(child: AsyncInputDrop(
      //   suffixIcon: IconButton(
      //     icon: const Icon(Icons.android),
      //     onPressed: (){
      //
      //     },),
      //   loadingWidget: DropdownButtonFormField<dynamic>(
      //       icon: IconButton(
      //           icon: const Icon(Icons.android),
      //           onPressed: (){
      //
      //           }),
      //       decoration:  const InputDecoration(
      //         border: InputBorder.none,
      //         hintText: "请输入",
      //         hintStyle: TextStyle(fontSize: 14),
      //         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //       ),
      //       items: []) ,
      //
      //   errorWidget: DropdownButtonFormField<dynamic>(
      //       decoration: const InputDecoration(
      //         border: InputBorder.none,
      //         hintText: "请输入",
      //         hintStyle: TextStyle(fontSize: 14),
      //         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //       ),
      //       items:[]) ,
      //   loadStatus: (status){
      //     if(status.connectionState == ConnectionState.waiting){
      //       print("请稍等，加载中");
      //     }
      //     if(status.hasError){
      //       print("加载错误");
      //     }
      //   },
      //   asyncLoad: (c) {
      //     Future.delayed(const Duration(seconds: 1),(){
      //       List<Object> data = [];
      //       data.add("111");
      //       data.add("222");
      //       data.add("333");
      //       data.add("4");
      //       data.add(2243434);
      //       data.add("asfasgafga");
      //       return c.complete(Future.value(data));
      //     });
      //     return c.future;
      //   },
      //   itemWidget: (list,callBack) {
      //     List<DropdownMenuItem> items = [];
      //
      //     if(null != list  && list is List){
      //       list.forEach((element) {
      //         var bean = element as Object;
      //         items.add(
      //             DropdownMenuItem(
      //               onTap: (){
      //               },
      //               child: Text(bean.toString(),style: TextStyle(fontSize: 14),),
      //               value: bean.toString(),
      //             ));
      //       });
      //
      //     }
      //     return items;
      //   },
      // ),),
    ]);
  }
}