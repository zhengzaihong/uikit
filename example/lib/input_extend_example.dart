import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/input_extend/input_extend.dart';
import 'package:flutter_uikit_forzzh/toast/toast_lib.dart';
import 'package:uikit_example/utils/font_utils.dart';

class InputExtendExample extends StatefulWidget {
  const InputExtendExample({Key? key}) : super(key: key);

  @override
  _InputExtendExampleState createState() => _InputExtendExampleState();
}

class _InputExtendExampleState extends State<InputExtendExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("输入搜索框扩展"),
      ),
      backgroundColor: Colors.teal,
      body: InputExtendDemo(),
    );
  }
}

class InputExtendDemo extends StatelessWidget {
  InputExtendDemo({Key? key}) : super(key: key);

  List<String> checkeds = [];

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 350,
              margin: const EdgeInsets.only(top: 30, left: 10, right: 20),
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: InputExtend<String>(
                  checkedItemWidth: 80,
                  checkedBarMaxWidth: 240,
                  autoClose: true,
                  enableMultipleChoice: false,
                  enableClickClear: true,
                  barrierDismissible: true,
                  ///真实项目一般都是对象(bean) 填充对象即可
                  initCheckedValue: checkeds,
                  focusNode: focusNode,
                  inputDecoration: (data,c) {
                    return InputDecoration(
                      hintText: "输入搜索名称",
                      filled: true,
                      counterText: "",
                      hintStyle:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    );
                  },
                  onChanged: (text, controller) {
                    ///模拟接口数据
                    List<String> datas = [];
                    int max = Random().nextInt(15);
                    for (int i = 0; i < max; i++) {
                      datas.add("item$i");
                    }

                    ///无论是同步还是异步 拿到数据后setSearchData填充数据
                    controller.setSearchData(datas);
                  },

                  ///自定义选中后样式
                  buildCheckedBarStyle: (element, controller) {
                    return Container(
                        width: 80,
                        height: 30,
                        margin: const EdgeInsets.only(left: 3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onTap: () {
                            ///非同一数据源 即两个集合  一定要传比较器，根据属性比较
                            ///非同一数据源 即两个集合  一定要传比较器，根据属性比较
                            ///非同一数据源 即两个集合  一定要传比较器，根据属性比较
                            controller.setCheckChange(data: element);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(element),
                                FontIcon(0xe642, size: 20, color: Colors.grey)
                              ]),
                        ));
                  },

                  ///自定义构建弹出窗样式
                  buildSelectPop: (context, srcs, controller) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: srcs.isEmpty
                          ? Container(
                              child: const Text("无数据"),
                              alignment: Alignment.center,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))
                          : ListView.builder(
                              itemCount: srcs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = controller.getSearchData[index];
                                // bool hasValue = controller.isChecked(index);

                                bool hasValue = controller.isCheckedVO((item) {
                                  return item == "item$index";
                                });

                                return InkWell(
                                    onTap: () {
                                      Toast.show("----${index}");

                                      ///非同一数据源 即两个集合  一定要传比较器，根据属性比较
                                      ///非同一数据源 即两个集合  一定要传比较器，根据属性比较
                                      ///非同一数据源 即两个集合  一定要传比较器，根据属性比较
                                      controller.setCheckChange(data: data);
                                    },
                                    child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("item$index"),
                                              Visibility(
                                                  visible: hasValue,
                                                  child: FontIcon(
                                                    0xe64a,
                                                    size: 30,
                                                    color: Colors.lightBlue,
                                                  ))
                                            ])));
                              }),
                    );
                  })),
          GestureDetector(
            onTap: () {
              focusNode.unfocus();
            },
            child: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("搜索",
                    style: TextStyle(color: Colors.white, fontSize: 20))),
          )
        ],
      ),
    ]);
  }
}
