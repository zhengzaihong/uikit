import 'package:flutter/material.dart';
import 'package:uikit/pop/pop_lib.dart';
import 'package:uikit/bubble/bubble_lib.dart';
class PopWindowExample extends StatefulWidget {
  const PopWindowExample({Key? key}) : super(key: key);

  @override
  _PopWindowExampleState createState() => _PopWindowExampleState();
}

class _PopWindowExampleState extends State<PopWindowExample> {
  GlobalKey btnKey1 = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();

  String? itemText;

  late PopupWindow popupWindow;
  RenderBox? tagbox;
  Offset? offset;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    popupWindow = createPopupWindow(
      context,
      // childSize:Size(240, 800),
      // gravity: PopupGravity.rightBottom,
      // curve: Curves.elasticOut,
      bgColor: Colors.transparent,
      clickOutDismiss: true,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      targetRenderBox: tagbox,
      needSafeDisplay: true,
      underStatusBar: false,
      underAppBar: false,
      offsetX:offset==null?50:offset!.dx+50,
      offsetY: offset==null?50:offset!.dy,
      duration: Duration(milliseconds: 300),
      onShowStart: (pop) {
        print("showStart");
      },
      onShowFinish: (pop) {
        print("showFinish");
      },
      onDismissStart: (pop) {
        print("dismissStart");
      },
      onDismissFinish: (pop) {
        print("dismissFinish");
      },
      onClickOut: (pop) {
        print("onClickOut");
      },
      onClickBack: (pop) {
        print("onClickBack");
      },
      childFun: (pop) {
        return StatefulBuilder(
            key: GlobalKey(),
            builder: (popContext, popState) {
              return Bubble(
                margin: BubbleEdges.only(top: 80,left: 100),
                nip: BubbleNip.no,
                nipOffset: 100,
                nipWidth: 30,
                nipHeight: 20,
                radius: Radius.circular(30),
                color: Color.fromRGBO(225, 255, 199, 1.0),
                child:Container(
                  width: 200,
                  height: 300,
                  child: ListView.builder(
                    itemCount: 100,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            RenderBox box = btnKey1.currentContext?.findRenderObject() as RenderBox;
                            offset = box.localToGlobal(Offset(0.0, box.size.height));
                            tagbox = box;
                            itemText = "item$index";
                            popupWindow.dismiss(context);
                          });
                        },
                        child: Center(
                          child: Text("item${index}"),
                        ),
                      );
                    }),),
              );
            });
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("popwindow"),
        ),
        body: Column(children: [

          MaterialButton(
              key: btnKey1,
              height: 50,
              child: Text(itemText ?? "popup1"),
              color: Colors.redAccent,
              onPressed: () {
                RenderBox box = btnKey1.currentContext?.findRenderObject() as RenderBox;
                 offset = box.localToGlobal(Offset(0.0, box.size.height));
                tagbox = box;
                popupWindow.show(context);
              }),

          SizedBox(height: 50),
          MaterialButton(
              key: btnKey2,
              height: 50,
              child: Text(itemText ?? "popup2"),
              color: Colors.redAccent,
              onPressed: () {
                RenderBox box =
                    btnKey2.currentContext?.findRenderObject() as RenderBox;
                var offset = box.localToGlobal(Offset(0.0, box.size.height));
                // Offset offset = box.localToGlobal(Offset(0,Offset.));

                showPopupWindow(
                  context,
                  // childSize:Size(240, 800),
                  gravity: PopupGravity.rightBottom,
                  // curve: Curves.elasticOut,
                  // bgColor: Colors.grey.withOpacity(0.5),
                  clickOutDismiss: true,
                  clickBackDismiss: true,
                  customAnimation: false,
                  customPop: false,
                  customPage: false,
                  targetRenderBox: box,
                  needSafeDisplay: true,
                  underStatusBar: false,
                  underAppBar: false,
                  // offsetX: offset.dx+50,
                  // offsetY: offset.dy,
                  duration: Duration(milliseconds: 300),
                  onShowStart: (pop) {
                    print("showStart");
                  },
                  onShowFinish: (pop) {
                    print("showFinish");
                  },
                  onDismissStart: (pop) {
                    print("dismissStart");
                  },
                  onDismissFinish: (pop) {
                    print("dismissFinish");
                  },
                  onClickOut: (pop) {
                    print("onClickOut");
                  },
                  onClickBack: (pop) {
                    print("onClickBack");
                  },
                  childFun: (pop) {
                    return StatefulBuilder(
                        key: GlobalKey(),
                        builder: (popContext, popState) {
                          return Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            alignment: Alignment.center,
                            child: ListView.builder(
                                itemCount: 100,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      popState(() {
                                        itemText = "item$index";
                                      });
                                    },
                                    child: Center(
                                      child: Text("item${index}"),
                                    ),
                                  );
                                }),
                          );
                        });
                  },
                );
              }),
        ]));
  }
}
