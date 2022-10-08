
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/8
/// create_time: 9:36
/// describe: 纵向无限层级菜单
///

typedef BuildMenueItem<T> = Widget Function(
    InfiniteLevelsMenuesState state,
    bool expand,
    bool isLastClick,
    T data,
    int currentLevel);

typedef BuildSeparator<Dynamic> = Widget Function(
    BuildContext context, dynamic data, int currentLevel);


typedef BuildChildContainer<Dynamic> = List<dynamic> Function(dynamic data,int currentLevel);


class InfiniteLevelsMenues<T> extends StatefulWidget {

  ///描述当前菜单最大层级
  final int? level;
  final List<T>? datas;
  final BuildMenueItem buildMenueItem;
  final BuildSeparator? buildSeparator;
  final Widget? noDataView;
  final BuildChildContainer buildChildContainer;
  final double titleChildSpace;
  const InfiniteLevelsMenues(
      {
        required this.buildMenueItem,
        required this.buildChildContainer,
        this.buildSeparator,
        this.level =1,
        this.datas,
        this.noDataView,
        this.titleChildSpace =5,
        Key? key
      }) : super(key: key);

  @override
  State<InfiniteLevelsMenues> createState() => InfiniteLevelsMenuesState();
}

class InfiniteLevelsMenuesState extends State<InfiniteLevelsMenues> {
  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent(){
    if(widget.datas==null){
      return  widget.noDataView==null?const SizedBox():widget.noDataView!;
    }

    ///只有一级
    if(widget.level==1){
      return ListView.separated(
          itemCount: widget.datas!.length,
          itemBuilder: (context,index){
            return widget.buildMenueItem.call(
                this,
                false,
                false,
                widget.datas![index],
                widget.level!);
          },
          separatorBuilder:(context,index){
            if(widget.buildSeparator==null){
              return const SizedBox();
            }
            return widget.buildSeparator!.call(context,widget.datas![index],widget.level!);
          });
    }

    ///多级
    Widget infinite = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ...buildTitle(widget.datas??[], 1)
    ]);

    return infinite;

  }

  Widget buildChild(dynamic element,int level){
    List currentData = widget.buildChildContainer.call(element,level);
    Widget parent = Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            controller: ScrollController(),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentData.length,
            itemBuilder: (context,index){
              var bean = currentData[index];
              bool expand =  _mExpands.contains(bean);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.buildMenueItem.call(
                      this,
                      expand,
                      bean == lastClickItem,
                      bean,
                      level),

                   (level<=widget.level! && expand)? Row(
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

  List<Widget> buildTitle(List<dynamic> datas,int level){
    List<Widget> titles = [];
    for (var element in datas) {
     bool expand =  _mExpands.contains(element);
      titles.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.buildMenueItem.call(
                this,
                expand,
                element == lastClickItem,
                element,level),
            level<=widget.level! && expand? Row(
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

  ///记录 展开的集合
  final List<dynamic> _mExpands = [];
  dynamic lastClickItem;
  void setCurrentExpand(dynamic data){
    lastClickItem = data;
    if(_mExpands.contains(data)){
      _mExpands.remove(data);
    }else{
      _mExpands.add(data);
    }

    setState((){});
  }
}
