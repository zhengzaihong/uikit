import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/20
/// create_time: 16:48
/// describe: 支持无限层级横向扩展的listView
///


///创建子级联的回调
typedef BuildCascade = Widget Function(int cascade,LandscapeListViewState viewState );


///构建创建数据源的请求  网络或者本地
typedef LanuchRequestData<T> = Future<T> Function(int cascade,LandscapeListViewState viewState,Completer completer);


class LandscapeListView extends StatefulWidget {


  final int cascadeSize;
  final ScrollController? scrollController;
  final BuildCascade buildCascade;

  final bool enableClearChildCascade;

  final LanuchRequestData lanuchRequestData;

  const LandscapeListView({
    required this.buildCascade,
    this.cascadeSize = 1,
    this.scrollController,
    this.enableClearChildCascade = true,
    required this.lanuchRequestData,
    Key? key,
  }) : super(key: key);

  @override
  State<LandscapeListView> createState() => LandscapeListViewState();
}

class LandscapeListViewState extends State<LandscapeListView> {

  ///记录点击的条目信息，
   Map<int,int> _cascadeItemClick = HashMap();

   final Map<int,List<dynamic>> _dataSourceMap = HashMap();


   @override
  void initState() {
    super.initState();

    for(int i = 1;i<=widget.cascadeSize;i++){
      widget.lanuchRequestData.call(i,this,Completer()).then((value){
        _dataSourceMap[i] = value;
        notyDataChange();
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    List<Widget> cascadeList = [];
    for(int i = 1;i<=widget.cascadeSize;i++){
      cascadeList.add(widget.buildCascade.call(i,this));
    }

    return SingleChildScrollView(
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:cascadeList));
  }




   List<dynamic> getDataForKey(int cascadeKey){
     return _dataSourceMap[cascadeKey]??[];
   }


   int? getCascadeClickItem(int cascadeKey){
    return _cascadeItemClick[cascadeKey];
  }

  void setCascadeClickItem(int cascadeKey,int itemIndex){
    _cascadeItemClick[cascadeKey] = itemIndex;

    if(widget.enableClearChildCascade){
      clearChildCascade(cascadeKey);
    }else{
      notyDataChange();
    }
  }

  void clearChildCascade(int cascadeKey) async{
    Map<int,int> temp = HashMap();
    _cascadeItemClick.forEach((key, value) {
      if(key<=cascadeKey){
        temp[key] = value;
      }
    });
    _cascadeItemClick = temp;
    notyDataChange();
  }



  void notyDataChange(){
     if(mounted){
       setState(() {

       });
     }
  }
}

