
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uikit/input_extend/input_extend.dart';


class InputExtentdExample extends StatefulWidget {

  const InputExtentdExample({Key? key}) : super(key: key);

  @override
  _InputExtentdExampleState createState() => _InputExtentdExampleState();
}

class _InputExtentdExampleState extends State<InputExtentdExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
             margin: const EdgeInsets.only(left: 30),
              width: 300,
              padding: const EdgeInsets.only(top: 5,left: 10,bottom: 5),
              decoration: const BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: InputExtentd<String>(
                  checkedItemWidth: 80,
                  itemsBoxMaxWidth: 240,
                  initCheckedValue: ["item1","item3"],
                  inputDecoration: const InputDecoration(
                    hintText: "请填写",
                    filled: true,
                    counterText: "",
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),

                  onChanged: (text, controller) {
                    List<String> datas = [];
                    int max = Random().nextInt(15);
                    for (int i = 0; i < max; i++) {
                      datas.add("item$i");
                    }
                    controller.setSearchResultData(datas);

                  },
                  checkedWidgets: (datas,controller) {
                    List<Widget> widgets = [];

                    datas.forEach((element) {
                      var itemWidget = Container(
                          width: 80,
                          height: 40,
                          margin: const EdgeInsets.only(left: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              controller.updateCheckedData(element, (list) {
                                var hasData = false;
                                for (var i in list) {
                                  if (element == i) {
                                    hasData = true;
                                    break;
                                  }
                                }
                                return hasData;
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(element),
                                  Image.asset("images/删除.png",
                                      width: 20, height: 20)
                                ]),
                          ));
                      widgets.add(itemWidget);
                    });
                    return widgets;
                  },
                  builder: (context, controller) {
                    return Material(
                      color: Colors.transparent,
                      elevation: 20,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: ListView.builder(

                          itemCount: controller.getSearchData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = controller.getSearchData[index];
                            var checkeds = controller.getCheckedData;

                            bool hasValue = false;
                            for (var element in checkeds) {
                              if (element == data) {
                                hasValue = true;
                                break;
                              }
                            }
                            return InkWell(
                                onTap: () {
                                  controller.updateCheckedData(data, (list) {
                                    var hasData = false;
                                    for (var element in list) {
                                      if (data == element) {
                                        hasData = true;
                                        break;
                                      }
                                    }
                                    return hasData;
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("item${index}"),
                                          Visibility(
                                              visible: hasValue,
                                              child: Container(
                                                child: Image.asset(
                                                    "images/选中.png",
                                                    width: 30,
                                                    height: 30),
                                              ))
                                        ])));
                          }),
                    ),);
                  })),

          SizedBox(height: 40),
          ListView.builder(
              itemCount: 100,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text("item$index");
              })
        ],
      )),
    ));
  }
}
