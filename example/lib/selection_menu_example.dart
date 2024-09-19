import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-02-01
/// create_time: 21:58
/// describe: 仿系统下拉框，满足其他需求场景
///
class SelectionMenuExample extends StatefulWidget {

  const SelectionMenuExample({Key? key}) : super(key: key);

  @override
  State<SelectionMenuExample> createState() => _SelectionMenuExampleState();
}

class _SelectionMenuExampleState extends State<SelectionMenuExample> {

  int? _checkedIndex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title: const Text("仿系统下拉框 可高度自定义"),
      ),
      backgroundColor: Colors.white,
      body:Column(
        children: [
          SelectionMenu(
              popWidth: 30,
              alignType: AlignType.center,
              buttonBuilder: (show){
                return Container(
                  height: 40,
                  width: 200,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                      Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                    ],
                  ),
                );
              },
              selectorBuilder: (context) {
                return Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      color: Colors.yellow
                  ),
                  child: ListView.separated(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          _checkedIndex = index;
                          Navigator.pop(context);
                        },
                        child: 'item $_checkedIndex' == 'item $index' ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("item $index",style: const TextStyle(color: Colors.red),),
                            const Icon(Icons.check,color: Colors.red,)
                          ],
                        ) : Text("item $index"),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },),
                );
              }
          ),
          SelectionMenu(
              popWidth: 300,
              alignType: AlignType.right,
              buttonBuilder: (show){
                return Container(
                  height: 40,
                  width: 200,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                      Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                    ],
                  ),
                );
              },
              selectorBuilder: (context) {
                return Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      color: Colors.yellow
                  ),
                  child: ListView.separated(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          _checkedIndex = index;
                          Navigator.pop(context);
                        },
                        child: 'item $_checkedIndex' == 'item $index' ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("item $index",style: const TextStyle(color: Colors.red),),
                            const Icon(Icons.check,color: Colors.red,)
                          ],
                        ) : Text("item $index"),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },),
                );
              }
          ),
          Expanded(
            child: Center(child: SelectionMenu(
                popWidth: 300,
                buttonBuilder: (show){
                  return Container(
                    height: 40,
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                        Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  );
                },
                selectorBuilder: (context) {
                  return Container(
                    height: 200,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.yellow
                    ),
                    child: ListView.separated(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            _checkedIndex = index;
                            Navigator.pop(context);
                          },
                          child: 'item $_checkedIndex' == 'item $index' ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("item $index",style: const TextStyle(color: Colors.red),),
                              const Icon(Icons.check,color: Colors.red,)
                            ],
                          ) : Text("item $index"),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },),
                  );
                }
            ),),
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              SelectionMenu(
                  popWidth: 300,
                  elevation: 2,
                  popHeight: 200,
                  buttonBuilder: (show){
                    return Container(
                      height: 40,
                      width: 200,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                          Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    );
                  },
                  onShow: (menu,show){
                    menu.refresh();
                  },
                  onDismiss: (menu,show){
                    menu.refresh();
                  },
                  selectorBuilder: (context) {
                    return ListView.separated(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            _checkedIndex = index;
                            Navigator.pop(context);
                          },
                          child: 'item $_checkedIndex' == 'item $index' ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("item $index",style: const TextStyle(color: Colors.red),),
                              const Icon(Icons.check,color: Colors.red,)
                            ],
                          ) : Text("item $index"),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },);
                  }
              ),
              Spacer(),
              SelectionMenu(
                  popWidth: 300,
                  popHeight: 200,
                  alignType: AlignType.right,
                  buttonBuilder: (show){
                    return Container(
                      height: 40,
                      width: 200,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                          Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    );
                  },
                  selectorBuilder: (context) {
                    return Container(
                      color: Colors.purpleAccent,
                    );
                    // return ListView.separated(
                    //   itemCount: 20,
                    //   itemBuilder: (context, index) {
                    //     return GestureDetector(
                    //       onTap: (){
                    //         _checkedIndex = index;
                    //         Navigator.pop(context);
                    //       },
                    //       child: 'item $_checkedIndex' == 'item $index' ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text("item $index",style: const TextStyle(color: Colors.red),),
                    //           const Icon(Icons.check,color: Colors.red,)
                    //         ],
                    //       ) : Text("item $index"),
                    //     );
                    //   }, separatorBuilder: (BuildContext context, int index) {
                    //   return const Divider();
                    // },);
                  }
              ),
              SizedBox(width: 20,),
            ],
          ),
          Center(
            child: SelectionMenu(
                popWidth: 300,
                elevation: 2,
                popHeight: 500,
                // vMargin: -20,
                shadowColor: Colors.redAccent,
                // popCenter: true,
                // barrierColor: Colors.black38,
                alignType: AlignType.center,
                buttonBuilder: (show){
                  return Container(
                    height: 40,
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                        Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  );
                },
                selectorBuilder: (context) {
                  return Container(
                    // height: 200,
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            _checkedIndex = index;
                            Navigator.pop(context);
                          },
                          child: 'item $_checkedIndex' == 'item $index' ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("item $index",style: const TextStyle(color: Colors.red),),
                              const Icon(Icons.check,color: Colors.red,)
                            ],
                          ) : Text("item $index"),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },),
                  );
                }
            ),
          ),
          Center(
            child: SelectionMenu(
                popWidth: 300,
                elevation: 2,
                popHeight: 500,
                // vMargin: -20,
                shadowColor: Colors.redAccent,
                // popCenter: true,
                // barrierColor: Colors.black38,
                alignType: AlignType.left,
                buttonBuilder: (show){
                  return Container(
                    height: 40,
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child:  Text(_checkedIndex==null?"请选择":'item $_checkedIndex')),
                        Icon(show?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  );
                },
                // layoutSelectPop: (button,overlay){
                //   Offset offset = Offset(0.0, -(200+20.0));
                //   // Offset offset = button.localToGlobal(Offset.zero);
                //
                //   return RelativeRect.fromRect(
                //     Rect.fromPoints(
                //       button.localToGlobal(offset, ancestor: overlay),
                //         // Offset(300,200)
                //       button.localToGlobal(offset, ancestor: overlay),
                //     ),
                //    Rect.fromPoints(
                //       const Offset(0, 0),
                //       const Offset(0, 0),
                //     ),
                //   );
                // },
                selectorBuilder: (context) {
                  return Container(
                    // height: 200,
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            _checkedIndex = index;
                            Navigator.pop(context);
                          },
                          child: 'item $_checkedIndex' == 'item $index' ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("item $index",style: const TextStyle(color: Colors.red),),
                              const Icon(Icons.check,color: Colors.red,)
                            ],
                          ) : Text("item $index"),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },),
                  );
                }
            ),
          )
        ],
      ),
    ));
  }

}
