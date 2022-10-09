
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/8
/// create_time: 9:36
/// describe: 纵向无限层级菜单
///


typedef BuildMenueItem<T> = Widget Function(
    InfiniteLevelsMenuesState state,
    bool isCurrent,
    T data,
    int currentLevel);

typedef BuildSeparator<Dynamic> = Widget Function(
    BuildContext context, dynamic data, int currentLevel);


typedef CallBackChildData<Dynamic> = List<dynamic> Function(dynamic data,int currentLevel);


class InfiniteLevelsMenues2<T> extends StatefulWidget {

  final List<InfiniteWrapper>? datas;
  final BuildMenueItem buildMenueItem;
  final BuildSeparator? buildSeparator;
  final Widget? noDataView;
  final CallBackChildData callBackChildData;
  final double titleChildSpace;
  final Function? buildComplete;
  final bool? oneExpand;

  const InfiniteLevelsMenues2(
      {
        required this.buildMenueItem,
        required this.callBackChildData,
        this.buildSeparator,
        this.datas,
        this.noDataView,
        this.titleChildSpace =5,
        this.buildComplete,
        this.oneExpand = true,
        Key? key
      }) : super(key: key);

  @override
  State<InfiniteLevelsMenues2> createState() => InfiniteLevelsMenuesState();
}

class InfiniteLevelsMenuesState extends State<InfiniteLevelsMenues2> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.buildComplete?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent(){
    if(widget.datas==null){
      return  widget.noDataView==null?const SizedBox():widget.noDataView!;
    }

    Widget infinite = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ...buildTitle(widget.datas??[], 1)
    ]);

    return infinite;

  }

  Widget buildChild(dynamic element,int level){
    List currentData = widget.callBackChildData.call(element,level);
    Widget parent = Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            controller: ScrollController(),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentData.length,
            itemBuilder: (context,index){
              InfiniteWrapper bean = currentData[index];
              bool expand =  _mExpands.contains(bean);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.buildMenueItem.call(
                      this,
                      bean == _lastClickItem,
                      bean,
                      level),

                    (
                     expand && ((widget.oneExpand!)?bean.expand!:true)
                    )? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.titleChildSpace*(level+1),
                        ),
                        Expanded(child: buildChild(bean,level+1))
                      ],
                    ):const SizedBox.shrink(),
                ],
              );
            },
            separatorBuilder:(context,index){
              if(widget.buildSeparator==null){
                return const SizedBox();
              }
              return widget.buildSeparator!.call(context,currentData[index],level);
            })
      ],
    );
    return parent;
  }

  List<Widget> buildTitle(List<InfiniteWrapper> datas,int level){
    List<Widget> titles = [];
    for (var element in datas) {
      bool contain =  _mExpands.contains(element);
      titles.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.buildMenueItem.call(
                this,
                element == _lastClickItem,
                element,
                level),
             (
                contain && ((widget.oneExpand!)?element.expand!:true)
            )? Row(
                children: [
                  SizedBox(
                    width: widget.titleChildSpace*(level+1),
                  ),
                  Expanded(child: buildChild(element,level+1))
                ],
              ):const SizedBox.shrink(),
          ],
        )
      );
    }
    return titles;
  }

  InfiniteWrapper? _lastClickItem;
  void setCurrentExpand(InfiniteWrapper data){
    if(widget.oneExpand!){
      onlyOneExpand(data);
    }else{
       canExpandAll(data);
    }

    setState((){});
  }

  void canExpandAll(InfiniteWrapper data){
    _lastClickItem = data;
    if(_mExpands.contains(data)){
      _mExpands.remove(data);
    }else{
      _mExpands.add(data);
    }
  }

  void onlyOneExpand(InfiniteWrapper data){
    if(_samePids.contains(data)){
      for (var element in _samePids) {
        if(_lastClickItem!=data){
          element.expand = false;
        }
      }
    }
    if(data.isRoot!){
      data.expand = false;
    }
    _samePids.clear();
    _mExpands.clear();
    data.expand = !data.expand!;
    _lastClickItem = data;
    _findCascadeData(data, null);
    for (var element in _mExpands) {
      if(element!=data){
        element.expand = true;
      }
    }
  }





  final Set<InfiniteWrapper> _mExpands = HashSet();
  void _findCascadeData(InfiniteWrapper child,InfiniteWrapper? parent){
    _findSamePid(child,parent);
    for (var element in _samePids) {
      List  childs= element.childs??[];
      if(childs.contains(child)){
        _mExpands.add(element);
        _findParent(element);
      }
    }
    _mExpands.add(child);
  }

  void _findParent(InfiniteWrapper child){
    for (var element in _samePids) {
      var datas = element.childs??[];
      if(datas.contains(child)){
        _mExpands.add(element);
        element.expand=true;
        _findParent(element);
      }
    }
  }

   final Set<InfiniteWrapper> _samePids = HashSet();
   void _findSamePid(InfiniteWrapper child,InfiniteWrapper? parent){
    List datas =(parent==null? widget.datas:parent.childs)??[];
    List<InfiniteWrapper> parents = [];
    for (var element in datas) {
      if(element is InfiniteWrapper){
        if(element.pid == child.pid){
          parents.add(element);
        }
      }
    }
    ///找出一级的 pid
    _samePids.addAll(parents);

    ///查找所有子孙级pid
    for (var element in parents) {
      _findChilds(element);
    }
  }

  void _findChilds(InfiniteWrapper parent){
    List<InfiniteWrapper> childs = parent.childs??[];
    if(childs.isNotEmpty){
      for (var element in childs) {
        _samePids.add(element);
        _findChilds(element);
      }
    }
  }
}
