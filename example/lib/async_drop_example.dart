import 'package:flutter/material.dart';
import 'package:uikit/dropwidget/async_input_drop.dart';

class AsyncDropExample extends StatelessWidget {
  const AsyncDropExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem> temp =[];
    temp.add(
        const DropdownMenuItem(
      child: Text("加载中",style: TextStyle(fontSize: 14),),
      value: "加载中",
    )
    );

    temp.add(
        const DropdownMenuItem(
          child: Text("加载中2434",style: TextStyle(fontSize: 14),),
          value: "加载中3434",
        )
    );

    return MaterialApp(home: Scaffold(
      body: ListView(children: [

        SizedBox(height: 30),

        AsyncInputDrop(
          margin: EdgeInsets.all(30),
          suffixIcon: IconButton(
            icon: const Icon(Icons.android),
            onPressed: (){

          },),
          padding: EdgeInsets.only(top: 30,bottom: 30),
          loadingWidget: DropdownButtonFormField<dynamic>(
            icon: IconButton(
              icon: const Icon(Icons.android),
              onPressed: (){

              }),
             decoration:  InputDecoration(
               border: InputBorder.none,
               hintText: "请输入",
               hintStyle: TextStyle(fontSize: 14),
               contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
             ),
              items: []) ,

          errorWidget: DropdownButtonFormField<dynamic>(
              decoration:  InputDecoration(
                border: InputBorder.none,
                hintText: "请输入",
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
            Future.delayed(Duration(seconds: 4),(){
              List<Object> data = [];
              data.add("111");
              data.add("222");
              data.add("333");
              data.add("4");
              data.add(2243434);
              data.add("asfasgafga");
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
            return items;
          },
        ),
        AsyncInputDrop(
          margin: EdgeInsets.all(30),
          suffixIcon: IconButton(
            icon: const Icon(Icons.android),
            onPressed: (){

          },),
          padding: EdgeInsets.only(top: 30,bottom: 30),
          loadingWidget: DropdownButtonFormField<dynamic>(
            icon: IconButton(
              icon: const Icon(Icons.android),
              onPressed: (){

              }),
             decoration:  InputDecoration(
               border: InputBorder.none,
               hintText: "请输入",
               hintStyle: TextStyle(fontSize: 14),
               contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
             ),
              items: []) ,

          errorWidget: DropdownButtonFormField<dynamic>(
              decoration:  InputDecoration(
                border: InputBorder.none,
                hintText: "请输入",
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
            Future.delayed(Duration(seconds: 4),(){
              List<Object> data = [];
              data.add("111");
              data.add("222");
              data.add("333");
              data.add("4");
              data.add(2243434);
              data.add("asfasgafga");
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
            return items;
          },
        ),

      ]),
    ),);
  }
}
