
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uikit/input_extend/input_extend.dart';
import 'package:uikit/input_extend/landscape_listview.dart';


class InputExtentdExample extends StatefulWidget {

  const InputExtentdExample({Key? key}) : super(key: key);

  @override
  _InputExtentdExampleState createState() => _InputExtentdExampleState();
}

class _InputExtentdExampleState extends State<InputExtentdExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          InputExtendDemo() ,
          InputSearchNameWidget(),
        ],
      )),
    ));
  }
}

class InputExtendDemo extends StatelessWidget {
  const InputExtendDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.only(left: 30),
        width: 300,
        padding: const EdgeInsets.only(top: 5,left: 10,bottom: 5),
        decoration: const BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InputExtentd<String>(
            checkedItemWidth: 80,
            itemsBoxMaxWidth: 240,
            initCheckedValue: ["item1","item3"], ///真实项目一般都是对象 填充对象即可
            inputDecoration: (c){
              return const InputDecoration(
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
              );
            },

            onChanged: (text, controller) {
              List<String> datas = [];
              int max = Random().nextInt(15);
              for (int i = 0; i < max; i++) {
                datas.add("item$i");
              }

              ///无论是同步还是异步 拿到数据后setSearchResultData填充数据
              controller.setSearchResultData(datas);

            },

            ///自定义选中后样式
            checkedWidgets: (datas,controller) {
              List<Widget> widgets = [];
              for (var element in datas) {
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
              }
              return widgets;
            },

            ///自定义构建弹出窗样式
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
            }));
  }
}


///输入框 搜索Pop 扩展 demo
class InputSearchNameWidget extends StatelessWidget {
  const InputSearchNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10,top: 40),
        width: 300,
        padding: const EdgeInsets.only(top: 2, left: 10, bottom: 2),
        decoration:  BoxDecoration(
            color: Colors.grey.withAlpha(200),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(children: [
          Expanded(child: InputExtentd<dynamic>(
              checkedItemWidth: 90,
              itemsBoxMaxWidth: 240,
              autoClose: true,
              enableClickClear: true,
              popConstraintBox: PopConstraintBox(
                  limitSize: false,
                  width: 800,
                  height: 400//可以不传
              ),
              enableMultipleChoice: false,
              enableHasFocusCallBack: true,
              inputDecoration: (controller) {
                return InputDecoration(
                  hintText: controller.getCheckedData.isEmpty ? "请填写" : "",
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
                List newData =[];
                for(int i =0;i<10;i++){
                  newData.add("name$i");
                }
                ///无论是同步还是异步 拿到数据后setSearchResultData填充数据
                controller.setSearchResultData(newData);

              },
              ///自定义选中后样式
              checkedWidgets: (datas, controller) {
                List<Widget> widgets = [];
                return widgets;
              },
              ///自定义选中后样式
              builder: (context, controller) {
                return Material(
                    color: Colors.transparent,
                    child: controller.getSearchData.isEmpty
                        ? const SizedBox()
                        :Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 200),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                      child: SingleChildScrollView(
                          controller: ScrollController(),
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                createOftenSearch(),

                                LandscapeListView(
                                    cascadeSize: 3,
                                    lanuchRequestData: (cascade,viewState,completer){

                                      Future.delayed(Duration(seconds: 2),
                                              () {
                                            List<String> data = [];
                                            for (int i = 0; i < 30; i++) {
                                              data.add("第$cascade级联Item$i");
                                            }
                                            return completer.complete(data);
                                          });

                                      return completer.future;
                                    },
                                    buildCascade: (cascade,viewState){
                                      return createSearchListResult(cascade,viewState);

                                    }),
                              ])
                      ),
                    ));
              })),

        ]));
  }


  ///创建常用热搜关键词
  Widget createOftenSearch(){

    List<Widget> oftenSearchButtons = [];
    List<String> titles = ["执行情况","费用查询","用户列表","标签列表","执行情况","费用查询","用户列表","标签列表"];

    for(int i = 0;i<titles.length;i++){
      var itemText = titles[i];
      var view =  InkWell(
          onTap: (){

          },
          hoverColor: Colors.transparent,
          child: Container(
              width: itemText.length*16+10,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(left: 3,right: 3),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Text(itemText)));

      oftenSearchButtons.add(view);
    }

    return  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: oftenSearchButtons));
  }

  Widget createSearchListResult(int cascade,LandscapeListViewState viewState){

    List<Widget> oftenSearchButtons = [];

    var clickItemIndex = viewState.getCascadeClickItem(cascade);
    List<dynamic> datas = viewState.getDataForKey(cascade);

    for(int i = 0;i<datas.length;i++){
      var itemText = datas[i];
      var view =  InkWell(
          onTap: (){
            viewState.setCascadeClickItem(cascade, i);

            ///构建选中的参数
            StringBuffer buffer = StringBuffer();
            for(int i =1 ;i<=cascade;i++){
              var value =viewState.getDataForKey(i)[viewState.getCascadeClickItem(i)!];
              if(null!=value){
                buffer.write("-->");
                buffer.write(value);
              }
            }

            print("----------------->${buffer.toString()}");
          },
          hoverColor: Colors.transparent,
          child: Container(
              width: (itemText.length*16+10)*1.0,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10,top: 10),
              padding: const EdgeInsets.only(left: 3,right: 3),
              decoration: BoxDecoration(
                  color: clickItemIndex == i?Colors.grey:Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Row(children: [Expanded(child: Center(child: Text(itemText),)),const Text(">")])));

      oftenSearchButtons.add(view);
    }
    return  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: oftenSearchButtons));

  }



  void checkDataStatus(InputExtentdState controller, String bean) {

    ///这里是字符串直接比较的 内容，如果是对象 且数据来源于网络一定的通过对象 属性id 等来判断
    controller.updateCheckedData(bean, (list) {
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
