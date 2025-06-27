import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/8
/// create_time: 9:36
/// describe: 纵向无限层级菜单
///

typedef BuildMenuItem = Widget Function(InfiniteLevelsMenusState state,
    bool isCurrent, InfiniteMenu data, int currentLevel);

typedef BuildSeparator<Dynamic> = Widget Function(
    BuildContext context, dynamic data, int currentLevel);

class InfiniteLevelsMenus extends StatefulWidget {
  /// 菜单数据
  final List<InfiniteMenu>? datas;

  /// 构建样式回调
  final BuildMenuItem buildMenuItem;

  /// 构建分割线
  final BuildSeparator? buildSeparator;

  /// 没数据样式
  final Widget? noDataView;

  /// 子菜单层级间距
  final double titleChildSpace;

  /// 构建完成
  final Function(InfiniteLevelsMenusState state, InfiniteMenu? item)?
      buildComplete;

  /// 是否展开所有
  final bool? allExpand;

  /// 默认展开的那个子项菜单
  final InfiniteMenu? defaultExpand;

  const InfiniteLevelsMenus(
      {required this.buildMenuItem,
      this.buildSeparator,
      this.datas,
      this.noDataView,
      this.titleChildSpace = 5,
      this.buildComplete,
      this.allExpand,
      this.defaultExpand,
      Key? key})
      : super(key: key);

  @override
  State<InfiniteLevelsMenus> createState() => InfiniteLevelsMenusState();
}

class InfiniteLevelsMenusState extends State<InfiniteLevelsMenus> {
  InfiniteMenu? _lastClickItem;
  bool isFirstBuild = true;

  @override
  void initState() {
    super.initState();

    _lastClickItem = widget.defaultExpand;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isFirstBuild) {
        isFirstBuild = false;
        widget.buildComplete?.call(this, _lastClickItem);
      }
      if (widget.allExpand == true) {
        openAll();
        return;
      }
      if (widget.allExpand == false) {
        closeAll();
        // return;
      }
      if (_lastClickItem != null) {
        ///根据当前选中的层级查询所在父层级
        setState(() {
          var datas = widget.datas ?? [];
          for (int i = 0; i < datas.length; i++) {
            List<InfiniteMenu> parents = [];
            var bean = datas[i];
            parents.add(bean);
            List<InfiniteMenu> newParents = _findAllParents(bean, parents);
            if (newParents.contains(_lastClickItem)) {
              int index = newParents.indexOf(_lastClickItem!);
              newParents.removeRange(index + 1, newParents.length);
              for (var element in newParents) {
                element.isChecked = true;
              }
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent() {
    if (widget.datas == null || widget.datas!.isEmpty) {
      return widget.noDataView == null ? const SizedBox() : widget.noDataView!;
    }

    Widget infinite = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...buildTitle(widget.datas ?? [], 1)]);

    return infinite;
  }

  Widget buildChild(InfiniteMenu rootMenu, InfiniteMenu parentMenu, int level) {
    List<InfiniteMenu> currentData = parentMenu.children ?? [];
    Widget parent = Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            controller: ScrollController(),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentData.length,
            itemBuilder: (context, index) {
              InfiniteMenu bean = currentData[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  parentMenu.isChecked
                      ? widget.buildMenuItem
                          .call(this, bean == _lastClickItem, bean, level)
                      : const SizedBox(),
                  parentMenu.isChecked
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  left: widget.titleChildSpace * (level + 1)),
                              child: buildChild(rootMenu, bean, level + 1),
                            ))
                          ],
                        )
                      : const SizedBox(),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return widget.buildSeparator
                      ?.call(context, currentData[index], level) ??
                  const SizedBox();
            })
      ],
    );
    return parentMenu.isChecked ? parent : const SizedBox();
  }

  List<Widget> buildTitle(List<InfiniteMenu> titleMenus, int level) {
    List<Widget> titles = [];
    for (var element in titleMenus) {
      titles.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///标题
          widget.buildMenuItem
              .call(this, element == _lastClickItem, element, level),

          ///子标题
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding:
                    EdgeInsets.only(left: widget.titleChildSpace * (level + 1)),
                child: buildChild(element, element, level + 1),
              ))
            ],
          ),
        ],
      ));
    }
    return titles;
  }

  List<InfiniteMenu> _findAllParents(
      InfiniteMenu data, List<InfiniteMenu> parents) {
    var datas = data.children ?? [];
    for (int i = 0; i < datas.length; i++) {
      var bean = datas[i];
      parents.add(bean);
      if (bean == _lastClickItem) {
        return parents;
      }
      _findAllParents(datas[i], parents);
    }
    return parents;
  }

  void setItem(InfiniteMenu data) {
    setState(() {
      data.isChecked = !data.isChecked;
      if (!data.isChecked) {
        _closeAllChild(data);
      }
      _lastClickItem = data;
    });
  }

  void openAll() {
    setState(() {
      widget.datas?.forEach((element) {
        element.isChecked = true;
        _openAllChild(element);
      });
    });
  }

  void closeAll() {
    setState(() {
      widget.datas?.forEach((element) {
        element.isChecked = false;
        _closeAllChild(element);
      });
    });
  }

  void _closeAllChild(InfiniteMenu data) {
    data.children?.forEach((element) {
      element.isChecked = false;
      _closeAllChild(element);
    });
  }

  void _openAllChild(InfiniteMenu data) {
    data.children?.forEach((element) {
      element.isChecked = true;
      _openAllChild(element);
    });
  }
}
