
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/8
/// create_time: 9:36
/// describe: 纵向无限层级菜单
///

typedef BuildMenuItem<T> = Widget Function(
    InfiniteLevelsMenusState state,
    bool isCurrent,
    T data,
    int currentLevel);

typedef BuildSeparator<Dynamic> = Widget Function(
    BuildContext context, dynamic data, int currentLevel);


class InfiniteLevelsMenus<T> extends StatefulWidget {

  final List<InfiniteMenu>? datas;
  final BuildMenuItem buildMenuItem;
  final BuildSeparator? buildSeparator;
  final Widget? noDataView;
  final double titleChildSpace;
  final Function? buildComplete;
  final bool oneExpand;

  const InfiniteLevelsMenus(
      {
        required this.buildMenuItem,
        this.buildSeparator,
        this.datas,
        this.noDataView,
        this.titleChildSpace =5,
        this.buildComplete,
        this.oneExpand = true,
        Key? key
      }) : super(key: key);

  @override
  State<InfiniteLevelsMenus> createState() => InfiniteLevelsMenusState();
}

class InfiniteLevelsMenusState extends State<InfiniteLevelsMenus> {

  InfiniteMenu? _lastClickItem;

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
    if(widget.datas==null || widget.datas!.isEmpty){
      return  widget.noDataView==null?const SizedBox():widget.noDataView!;
    }

    Widget infinite = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ...buildTitle(widget.datas??[], 1)
    ]);

    return infinite;

  }

  Widget buildChild(InfiniteMenu rootMenu,InfiniteMenu parentMenu,int level){
    List<InfiniteMenu> currentData = parentMenu.children??[];
    Widget parent = Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            controller: ScrollController(),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentData.length,
            itemBuilder: (context,index){
              InfiniteMenu bean = currentData[index];
              // print("-----------title:${bean.title}---- expand:$expand");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  parentMenu.isChecked?widget.buildMenuItem.call(
                      this,
                      bean == _lastClickItem,
                      bean,
                      level):const SizedBox(),

                  parentMenu.isChecked?
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child:Padding(
                        padding: EdgeInsets.only(left: widget.titleChildSpace*(level+1)),
                        child:  buildChild(rootMenu,bean,level+1),
                      ))
                    ],
                  )
                      :const SizedBox(),
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
    return parentMenu.isChecked?parent:const SizedBox();
  }

  List<Widget> buildTitle(List<InfiniteMenu> titleMenus,int level){
    List<Widget> titles = [];
    for (var element in titleMenus) {
      print("---------element:${element.title} --element.isChecked:${element.isChecked}");
      titles.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ///标题
            widget.buildMenuItem.call(
                this,
                element == _lastClickItem,
                element,
                level),

              ///子标题
              Row(
                children: [
                  Expanded(child:Padding(
                    padding: EdgeInsets.only(left: widget.titleChildSpace*(level+1)),
                    child:  buildChild(element,element,level+1),
                  ))
                ],
              ),
          ],
        )
      );
    }
    return titles;
  }

  ///id 始终是根节点id
  void setItem(InfiniteMenu data) {
    setState(() {
      data.isChecked = !data.isChecked;
      if(!data.isChecked){
        _closeAllChild(data);
      }
      _lastClickItem = data;
    });
  }

  void _closeAllChild(InfiniteMenu data){
    data.children?.forEach((element) {
      element.isChecked = false;
      _closeAllChild(element);
    });
  }

  void _openAllChild(InfiniteMenu data){
    data.children?.forEach((element) {
      element.isChecked = true;
      _openAllChild(element);
    });
  }


}
