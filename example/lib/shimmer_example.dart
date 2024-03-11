import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/drawer/smart_drawer.dart';
import 'package:flutter_uikit_forzzh/often/time_view.dart';
import 'package:flutter_uikit_forzzh/toast/toast_utils.dart';


class ShimmerLoadingExample extends StatefulWidget {

  const ShimmerLoadingExample({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingExample> createState() => _ShimmerLoadingExampleState();
}

class _ShimmerLoadingExampleState extends State<ShimmerLoadingExample> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext  baseContext) {

    return  Scaffold(
        appBar: AppBar(
        ),
        backgroundColor: Colors.brown,
        endDrawer: SmartDrawer(
          widthPercent: 0.8,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Toast.show("我是侧边栏~~~");
              },
              child: const Text("一个侧边页面"),
            ),
          ),
        ),
        body: LayoutBuilder(builder: (mContext,_){
          return Column(
              children: [

              ]
          );
        }));
  }
}
