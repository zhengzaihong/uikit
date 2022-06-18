import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

class PopWindowExample extends StatefulWidget {
  const PopWindowExample({Key? key}) : super(key: key);

  @override
  _PopWindowExampleState createState() => _PopWindowExampleState();
}

class _PopWindowExampleState extends State<PopWindowExample> {
  
  GlobalKey btnKey = GlobalKey();


  String selectText = "请选择信息";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: const Text("popwindow"),
        ),
        body: Row(children: [

          InkWell(
              key: btnKey,
              onTap: () {
                showSelectPop(
                    context: context,
                    globalKey: btnKey,
                    clickCallBack: (data,index){
                      selectText = "item $index";
                      setState(() {

                      });
                    },
                    datas: List.generate(100, (index) => index),
                    buildItem: (data, index) {

                      return Text("item $index",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 10));
                    });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border:
                    Border.all(width: 0.5, color: Colors.white),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children:  [
                    const SizedBox(width: 10),
                    Text(selectText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14)),
                  ],
                ),
              )),

        ]));
  }
}



typedef BuildItem = Widget Function(dynamic data, int index);
/// 通用弹出下拉框
void showSelectPop({
  required BuildContext context,
  required GlobalKey globalKey,
  required List<dynamic> datas,
  required BuildItem buildItem,
  double? width = 0,
  double? height = 0,
  Function(dynamic data, int index)? clickCallBack,
}) {
  RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;

  showPopupWindow(
    context,
    bgColor: Colors.transparent,
    clickOutDismiss: true,
    gravity: PopupGravity.centerBottom,
    targetRenderBox: box,
    duration: const Duration(milliseconds: 300),
    childFun: (pop) {
      return StatefulBuilder(
          key: GlobalKey(),
          builder: (popContext, popState) {
            return Bubble(
                width: 0 == width ? 300.0 : width!,
                height: 0 == height ? 300 : width!,
                color:Colors.tealAccent.withOpacity(0.7),
                position:BubbleArrowDirection.top,
                child:  Container(
                  margin: const EdgeInsets.only(top: 2),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  child: MediaQuery.removePadding(context: context,
                      removeTop: true,
                      child: ListView.separated(
                      itemCount: datas.isNotEmpty ? datas.length : 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (null != clickCallBack) {
                              clickCallBack.call(datas[index], index);
                            }
                            pop.dismiss(context);
                          },
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 2, bottom: 20, top: 20, right: 2),
                              color: Colors.transparent,
                              child: buildItem(datas[index], index)),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 1, color: Colors.black12);
                      })),
                ));
          });
    },
  );
}