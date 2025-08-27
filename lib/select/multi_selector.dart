import 'package:flutter/material.dart';
import 'bean/multi_selector_entity.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025/6/24
/// create_time: 10:35
/// describe: 此组件为无限层级多级选择组件（支持多选，自动跟踪到选择的末节点）
/// 如果你要单选，请从业务层处理，保留 defaultSelected 最多只有一个值即可
///This component is an infinite hierarchical and multi-level selection component (supports multiple selection and automatically tracks to the selected end node)
///If you want to select a single selection, please process it from the business layer and keep defaultSelected with only one value at most
/// eg:
//               MultiSelector(
//                       key: UniqueKey(),
//                       data: provider.diagnoseList,
//                       defaultSelected:(provider.sixNaoDiseases??[]).map((id) => id.toString()).toList(),
//                       controller: provider.multiSelectorController,
//                       onSelectionChanged: (list){
//                         LogUtil.v(list.toString());
//                         String name = "";
//                         List<num> selectedIds = [];
//                         if(list.isNotEmpty){
//                           for(int i = 0;i<list.length;i++){
//                             name += "${(i+1)}.${list[i].name}   ";
//                             selectedIds.add(list[i].id?.toNum(def: 0)??0);
//                           }
//                         }else{
//                           name = "请选择";
//                         }
//                         provider.diagnoseNameNotifier.value = name;
//                         provider.sixNaoDiseases = selectedIds;
//
//                       },
//                       buildItems: (node, level, isExpanded,hasChildren) {
//                         return  Row(
//                           children: [
//                             Checkbox(
//                               value: node.isSelected,
//                               onChanged: (checked) {
//                                 provider.multiSelectorController.setItemSelection(node, checked);
//                               },
//                             ),
//                             Expanded(
//                               child: Text(
//                                 node.name ?? '',
//                                 style: const TextStyle(color: Colors.black),
//                               ),
//                             ),
//                             hasChildren?Icon(isExpanded ? Icons.expand_less : Icons.expand_more):const SizedBox.shrink(),
//                           ],
//                         );
//                       },
//                     )


final Map<String, MultiSelectorEntity?> _accordionExpandedMap = {};

class MultiSelector extends StatefulWidget {

  // 无限层级的选择项 --子类需要构造此数据
  // Infinite levels of options-subclasses need to construct this data
  final List<MultiSelectorEntity> data;
  // 选择变化回调
  // Select Change Callback
  final void Function(List<MultiSelectorEntity> list) onSelectionChanged;
  // 构造子节点
  // Constructing child nodes
  final Widget Function(MultiSelectorEntity node,int level,bool isExpanded,bool hasChildren) buildItems;
  // 同一个 key 表示共享手风琴逻辑
  // The same key means sharing accordion logic
  final String? accordionKey;
  // 手风琴动画是否开启
  // Whether accordion animation is turned on
  final bool animation;
  // 手风琴动画时长
  // accordion animation duration
  final Duration animationDuration;
  // 手风琴动画
  // accordion animation
  final Curve curve;
  // 手风琴动画位置
  // accordion animation position
  final AlignmentGeometry animationAlignment;
  // 控制器
  // controller
  final MultiSelectorController? controller;
  // 默认选中
  // selected by default
  final List<String>? defaultSelected;
  // 加载完成回调数据-利用组件将默认条目选中后回调内容
  // Load completion callback data-Use the component to select the default entry and call back content
  final bool completeCallback;

  const MultiSelector({Key? key,
    required this.data,
    required this.onSelectionChanged,
    required this.buildItems,
    this.controller,
    this.accordionKey,
    this.animation = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.animationAlignment = Alignment.topLeft,
    this.defaultSelected,
    this.completeCallback = true,
  }): super(key: key);

  @override
  MultiSelectorState createState() => MultiSelectorState();
}


class MultiSelectorState extends State<MultiSelector> with TickerProviderStateMixin {

  final Map<MultiSelectorEntity, bool> _expandedNodes = {};

  @override
  void initState() {
    super.initState();
    widget.controller?.bind(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.defaultSelected!=null){
        setState(() {
          setSelected(widget.defaultSelected!);
          _updateParentSelection(widget.data);
        });
        if(widget.completeCallback){
          widget.onSelectionChanged(_collectSelectedLeaves(widget.data));
        }
      }
    });
  }


  @override
  void didUpdateWidget(MultiSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?.bind(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.data.map((node) => _buildNodeItem(node: node, level: 0, siblings: widget.data)).toList(),
    );
  }

  Widget _buildNodeItem({
    required MultiSelectorEntity node,
    required int level,
    required List<MultiSelectorEntity> siblings,
  }) {
    final bool hasChildren = node.children?.isNotEmpty ?? false;
    final bool isExpanded = _expandedNodes[node] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: level * 16.0),
          child:GestureDetector(
            onTap: (){
              setState(() {
                if (widget.accordionKey != null) {
                  // 全局手风琴逻辑
                  // global accordion logic
                  final expandedNow = _accordionExpandedMap[widget.accordionKey];
                  if (expandedNow != node) {
                    _accordionExpandedMap[widget.accordionKey!] = node;
                    for (var s in siblings) {
                      _expandedNodes[s] = (s == node);
                    }
                  } else {
                    // 再次点击当前展开项 => 收起
                    // Click the current expansion item again => Close
                    _accordionExpandedMap[widget.accordionKey!] = null;
                    _expandedNodes[node] = false;
                  }
                } else {
                  _expandedNodes[node] = !isExpanded;
                }
              });
            },
            child: widget.buildItems(node,level,isExpanded,hasChildren),
          ),
        ),
        widget.animation ? AnimatedSize(
          duration: widget.animationDuration,
          curve: widget.curve,
          alignment:widget.animationAlignment,
          child: _buildItems(isExpanded, hasChildren, level, node),
        ): _buildItems(isExpanded, hasChildren, level, node),
      ],
    );
  }

  Widget _buildItems(bool isExpanded, bool hasChildren, int level, MultiSelectorEntity node) {
    return  ClipRect(
      child: isExpanded && hasChildren ? Column(children: node.children!
            .map((child) =>
            _buildNodeItem(node: child, level: level + 1, siblings: node.children!))
            .toList(),
      ) : const SizedBox.shrink());
  }


  void _clearChildrenSelection(MultiSelectorEntity node) {
    if (node.children != null) {
      for (var child in node.children!) {
        child.isSelected = false;
        _clearChildrenSelection(child);
      }
    }
  }

  void setItemSelection(MultiSelectorEntity node, bool? checked) {
    setState(() {
      node.isSelected = checked ?? false;
      if (node.isSelected) _clearChildrenSelection(node);
      _updateParentSelection(widget.data);
      widget.onSelectionChanged(_collectSelectedLeaves(widget.data));
    });
  }

  /// 递归向上传递选中状态：有任一子节点被选中，父节点也视为选中
  bool _updateParentSelection(List<MultiSelectorEntity> nodes) {
    bool anySelected = false;
    for (var node in nodes) {
      bool selfOrChildrenSelected = node.isSelected;
      if (node.children != null) {
        bool childrenSelected = _updateParentSelection(node.children!);
        selfOrChildrenSelected |= childrenSelected;
      }
      node.isSelected = selfOrChildrenSelected;
      anySelected |= selfOrChildrenSelected;
    }
    return anySelected;
  }

  List<MultiSelectorEntity> _collectSelectedLeaves(List<MultiSelectorEntity> nodes) {
    List<MultiSelectorEntity> result = [];
    for (var node in nodes) {
      if (node.isSelected && !(node.children?.any((c) => c.isSelected) ?? false)) {
        result.add(node);
      }
      if (node.children != null) {
        result.addAll(_collectSelectedLeaves(node.children!));
      }
    }
    return result;
  }

  void setSelected(List<String> selectedIds) {
    markSelectedByIds(widget.data, selectedIds);
    _updateParentSelection(widget.data);
    if(widget.completeCallback){
      widget.onSelectionChanged(_collectSelectedLeaves(widget.data));
    }
  }

  List<MultiSelectorEntity> getSelectedData(List<String> selectedIds) {
    markSelectedByIds(widget.data, selectedIds);
    _updateParentSelection(widget.data);
    return _collectSelectedLeaves(widget.data);
  }



  /// O(N) 单次递归，通过判断整个 selectedIds 集合标记是否选中
  void markSelectedByIds(List<MultiSelectorEntity> nodes, List<String> ids) {
    for (var node in nodes) {
      node.isSelected = ids.contains(node.id);
      if (node.children != null && node.children!.isNotEmpty) {
        markSelectedByIds(node.children!, ids);
        // 如果子节点中有一个选中，则父节点也应选中
        if (node.children!.any((c) => c.isSelected)) {
          node.isSelected = true;
        }
      }
    }
  }
}


class MultiSelectorController {

  MultiSelectorState? _state;

  MultiSelectorState? get state => _state;

  void bind(MultiSelectorState state) {
    _state = state;
  }

  void dispose() {
    _state = null;
  }

  RenderBox? getRenderBox() {
    final obj = _state?.context.findRenderObject();
    if (obj != null) {
      return obj as RenderBox;
    }
    return null;
  }

  void setItemSelection(MultiSelectorEntity node, bool? checked) {
    _state?.setItemSelection(node, checked);
  }

  List<MultiSelectorEntity> getSelectedData(List<String> ids) {
    return _state?.getSelectedData(ids)??[];
  }
}