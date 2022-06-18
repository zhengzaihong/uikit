import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/dropwidget/async_input_drop.dart';
import 'package:flutter_uikit_forzzh/dropwidget/drop_wapper.dart';

class AsyncDropExample extends StatelessWidget {
  const AsyncDropExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("异步下拉框，样式跟随系统，建议InputExtentd组件代替"),
      ),
      body: ListView(
          children: [

            AsyncInputDrop<dynamic>(
              margin: const EdgeInsets.all(30),
              suffixIcon: IconButton(
                  icon: const Icon(Icons.android),
                  onPressed: (){

                  }),
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
              loadingWidget: DropdownButtonFormField<dynamic>(
                  onChanged: (data){

                  },
                  icon: IconButton(
                      icon: const Icon(Icons.android),
                      onPressed: (){

                      }),
                  decoration:  const InputDecoration(
                    border: InputBorder.none,
                    hintText: "加载中...",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  items: []) ,

              errorWidget: DropdownButtonFormField<dynamic>(
                  onChanged: (data){

                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "加载错误",
                    hintStyle: TextStyle(fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  items:[]) ,
              loadStatus: (status){
                if(status.connectionState == ConnectionState.waiting){
                  print("请稍等，加载中");
                }
                if(status.hasError){
                  print("加载错误");
                }
              },
              asyncLoad: (c) {
                Future.delayed(const Duration(seconds: 1),(){
                  List<Object> data = [];
                  List.generate(30, (index){
                    data.add("item $index");
                  });
                  return c.complete(Future.value(data));
                });

                return c.future;
              },
              itemWidget: (list) {
                List<DropdownMenuItem> items = [];
                if(null != list  && list is List){
                  list.forEach((element) {
                    var bean = element as Object;
                    items.add(
                        DropdownMenuItem(
                          onTap: (){
                          },
                          child: Text(bean.toString(),style: TextStyle(fontSize: 14),),
                          value: bean.toString(),
                        ));
                  });
                }
                return DropWapper(drops: items,initValue: null);//可以给初始值，但必须是下拉项中的某一项
              },
            ),

          ]),
    );
  }
}
