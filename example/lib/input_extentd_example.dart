import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uikit_forzzh/input_extend/input_extend.dart';
import 'package:flutter_uikit_forzzh/input_extend/landscape_listview.dart';
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
              margin: const EdgeInsets.only(top: 30, left: 10,right: 20),
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: InputExtend<String>(
                  checkedItemWidth: 80,
                  checkBoxMaxWidth: 240,
                  autoClose: true,
                  enableMultipleChoice: false,
                  enableClickClear: true,
                  initCheckedValue: checkeds,
                  focusNode: focusNode,

                  ///真实项目一般都是对象(bean) 填充对象即可
                  inputDecoration: (c) {
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
                    return Material(
                      color: Colors.transparent,
                      elevation: 10,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child:  srcs.isEmpty?Container(
                            child: const Text("无数据"),
                            alignment: Alignment.center,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ))
                            :ListView.builder(
                            itemCount: srcs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = controller.getSearchData[index];
                              bool hasValue = controller.isChecked(index);

                              return InkWell(
                                  onTap: () {
                                    Toast.show( "----${index}");

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
                      ),
                    );
                  })),
          GestureDetector(
            onTap: (){
              focusNode.unfocus();
            },
            child:const Padding(padding:  EdgeInsets.only(top: 20),child: Text("搜索",style:  TextStyle(color: Colors.white,fontSize: 20))),)
        ],
      ),

      Container(width: 200,
      margin: const EdgeInsets.only(top: 30),
      child:  InputExtend<String>(
          autoClose: true,
          enableMultipleChoice: true,
          selectPopMarginTop: 5,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
         ],
          keyboardType: TextInputType.number,
          inputDecoration: (c) {
            return InputDecoration(
              hintText: "输入关键词",
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5), fontSize: 10),
              filled: true,
              fillColor: Colors.white,
              isCollapsed: true,
              focusColor: Colors.red,
              prefixIcon: FontIcon(
                0xe716,
                color: Colors.grey,
                size: 14,
              ),
              contentPadding: EdgeInsets.fromLTRB(5, 15, 5, 1),
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

          ///自定义构建弹出窗样式
          buildSelectPop: (context, srcs, controller) {
            return Material(
              elevation: 10,
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListView.builder(
                    itemCount: srcs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = controller.getSearchData[index];
                      bool hasValue = controller.isChecked(index);
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
              ),
            );
          }),)
    ]);
  }
}

///输入框 搜索Pop 扩展 demo
class InputSearchNameWidget extends StatelessWidget {
  const InputSearchNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, top: 40),
        width: 300,
        padding: const EdgeInsets.only(top: 2, left: 10, bottom: 2),
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(200),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(children: [
          Expanded(
              child: InputExtend<dynamic>(
                  checkedItemWidth: 90,
                  checkBoxMaxWidth: 240,
                  autoClose: true,
                  enableClickClear: true,
                  popConstraintBox: PopConstraintBox(
                      limitSize: false, width: 800, height: 400 //可以不传
                      ),
                  enableMultipleChoice: false,
                  enableHasFocusCallBack: true,
                  inputDecoration: (checkeds) {
                    return InputDecoration(
                      hintText: checkeds.isEmpty ? "请填写" : "",
                      filled: true,
                      counterText: "",
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    );
                  },
                  onChanged: (text, controller) {
                    ///请求数据
                    List newData = [];
                    for (int i = 0; i < 10; i++) {
                      newData.add("name$i");
                    }

                    ///无论是同步还是异步 拿到数据后setSearchData填充数据
                    controller.setSearchData(newData);
                  },

                  ///自定义选中后样式
                  buildCheckedBarStyle: (item, controller) {},

                  ///自定义选中后样式
                  buildSelectPop: (context, src, controller) {
                    return Material(
                        color: Colors.transparent,
                        child: controller.getSearchData.isEmpty
                            ? const SizedBox()
                            : Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 200),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                        style: BorderStyle.solid),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          createOftenSearch(),
                                          LandscapeListView(
                                              cascadeSize: 3,
                                              lanuchRequestData: (cascade,
                                                  viewState, completer) {
                                                Future.delayed(
                                                    Duration(seconds: 0), () {
                                                  List<String> data = [];
                                                  for (int i = 0; i < 30; i++) {
                                                    data.add(
                                                        "第$cascade级联Item$i");
                                                  }
                                                  return completer
                                                      .complete(data);
                                                });

                                                return completer.future;
                                              },
                                              buildCascade:
                                                  (cascade, viewState) {
                                                return createSearchListResult(
                                                    cascade, viewState);
                                              }),
                                        ])),
                              ));
                  })),
        ]));
  }

  ///创建常用热搜关键词
  Widget createOftenSearch() {
    List<Widget> oftenSearchButtons = [];
    List<String> titles = [
      "执行情况",
      "费用查询",
      "用户列表",
      "标签列表",
      "执行情况",
      "费用查询",
      "用户列表",
      "标签列表"
    ];

    for (int i = 0; i < titles.length; i++) {
      var itemText = titles[i];
      var view = InkWell(
          onTap: () {},
          hoverColor: Colors.transparent,
          child: Container(
              width: itemText.length * 16 + 10,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(left: 3, right: 3),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(itemText)));

      oftenSearchButtons.add(view);
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: oftenSearchButtons));
  }

  Widget createSearchListResult(int cascade, LandscapeListViewState viewState) {
    List<Widget> oftenSearchButtons = [];

    var clickItemIndex = viewState.getCascadeClickItem(cascade);
    List<dynamic> datas = viewState.getDataForKey(cascade);

    for (int i = 0; i < datas.length; i++) {
      var itemText = datas[i];
      var view = InkWell(
          onTap: () {
            viewState.setCascadeClickItem(cascade, i);

            ///构建选中的参数
            StringBuffer buffer = StringBuffer();
            for (int i = 1; i <= cascade; i++) {
              var value =
                  viewState.getDataForKey(i)[viewState.getCascadeClickItem(i)!];
              if (null != value) {
                buffer.write("-->");
                buffer.write(value);
              }
            }

            print("----------------->${buffer.toString()}");
          },
          hoverColor: Colors.transparent,
          child: Container(
              width: (itemText.length * 16 + 10) * 1.0,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, top: 10),
              padding: const EdgeInsets.only(left: 3, right: 3),
              decoration: BoxDecoration(
                  color: clickItemIndex == i ? Colors.grey : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(children: [
                Expanded(
                    child: Center(
                  child: Text(itemText),
                )),
                const Text(">")
              ])));

      oftenSearchButtons.add(view);
    }
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: oftenSearchButtons));
  }

  void checkDataStatus(InputExtendState controller, String bean) {
    ///这里是字符串直接比较的 内容，如果是对象 且数据来源于网络一定的通过对象 属性id 等来判断
    controller.setCheckChange(
        data: bean,
        compare: (list) {
          for (var i in list) {
            var item = i as String;
            if (bean == item) {
              return true;
            }
          }
          return false;
        });
  }

  ///同上
  bool isSelectThisData(String bean, dynamic checkeds) {
    for (var element in checkeds) {
      if (bean == element) {
        return true;
      }
    }
    return false;
  }
}
