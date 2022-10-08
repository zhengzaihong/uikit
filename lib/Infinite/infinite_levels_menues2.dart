
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/8
/// create_time: 9:36
/// describe: 纵向无限层级菜单
///
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


class InfiniteLevelsMenues2<T> extends StatefulWidget {

  ///描述当前菜单最大层级
  final int? level;
  final List<T>? datas;
  final BuildMenueItem buildMenueItem;
  final BuildSeparator? buildSeparator;
  final Widget? noDataView;
  final BuildChildContainer buildChildContainer;
  final double titleChildSpace;
  final Function? buildComplete;
  const InfiniteLevelsMenues2(
      {
        required this.buildMenueItem,
        required this.buildChildContainer,
        this.buildSeparator,
        this.level =1,
        this.datas,
        this.noDataView,
        this.titleChildSpace =5,
        this.buildComplete,
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.buildMenueItem.call(
                      this,
                      bean == lastClickItem,
                      bean == lastClickItem,
                      bean,
                      level),

                   (level<=widget.level! &&  bean == lastClickItem)? Row(
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
      titles.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.buildMenueItem.call(
                this,
                element == lastClickItem,
                element == lastClickItem,
                element,level),
            level<=widget.level! && element == lastClickItem? Row(
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

  InfiniteWrapper? lastClickItem;
  void setCurrentExpand(InfiniteWrapper data){
    data.expand = true;
    lastClickItem = data;
    setState((){});
  }

  void findParent(InfiniteWrapper child,InfiniteWrapper? parent){
    List datas =(parent==null? widget.datas:parent.childs)??[];
    List<InfiniteWrapper> parents = [];
    for (var element in datas) {
      if(element is InfiniteWrapper){
        if(element.pid == child.pid && element.currentLevel == (child.currentLevel!-1) ){
          parents.add(element);
        }
      }
    }
    if(parents.isNotEmpty){
      for (var element in parents) {
        List  childs= element.childs??[];
        if(childs!.contains(child)){
          // return  element;
        }
      }
    }

  }
}
