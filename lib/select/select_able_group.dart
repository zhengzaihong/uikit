import 'package:flutter/material.dart';



///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025-10-23
/// create_time: 17:59
/// describe:
// 🔸 单选 / 多选
// 🔸 互斥选项（如“全选”）
// 🔸 外部控制（controller）
// 🔸 首次选中回调
// 🔸 外部主动更新
// 🔸 流式布局（Wrap）
// 🔸 网格布局（Grid）支持 crossAxisCount
// 🔸 高性能 + 可动画 + 可主题化

// eg:
// final tagController = SelectableController();
// SelectableGroup(
//   layout: SelectableLayout.wrap,
//   multiple: true,
//   mutualExclusionIndex: 0,
//   controller: tagController,
//   itemCount: 6,
//   defaultValue: [2, 4],
//   onSelectionChanged: (selected) => print("选择: $selected"),
//   itemBuilder: (context, index, isSelected) {
//     final tags = ["全部", "科技", "体育", "电影", "时尚", "美食"];
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.orange : Colors.grey[200],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(tags[index],
//           style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black87,
//               fontWeight: FontWeight.w600)),
//     );
//   },
// );

/// 支持的布局类型
enum SelectableLayout { column, row, wrap, grid }

/// 控制器：用于外部主动控制选中状态
class SelectableController extends ChangeNotifier {
  List<int> _selected = [];
  bool multiple = false;
  void Function(List<int>)? _onChanged;

  List<int> get selected => List.unmodifiable(_selected);

  void _bindInternal({
    required List<int> initialSelected,
    required bool multiple,
    required void Function(List<int>) onChanged,
  }) {
    _selected = List.from(initialSelected);
    this.multiple = multiple;
    _onChanged = onChanged;
  }

  void _notify() => _onChanged?.call(List.from(_selected));

  /// 外部接口
  void select(int index) {
    if (multiple) {
      if (!_selected.contains(index)) _selected.add(index);
    } else {
      _selected = [index];
    }
    _notify();
  }

  void unselect(int index) {
    _selected.remove(index);
    _notify();
  }

  void toggle(int index) {
    if (_selected.contains(index)) {
      _selected.remove(index);
    } else {
      if (multiple) {
        _selected.add(index);
      } else {
        _selected = [index];
      }
    }
    _notify();
  }

  void selectAll(int itemCount) {
    if (multiple) {
      _selected = List.generate(itemCount, (i) => i);
      _notify();
    }
  }

  void clear() {
    _selected.clear();
    _notify();
  }

  void reset(List<int> defaults) {
    _selected = List.from(defaults);
    _notify();
  }



  void onTap(int index) {
    _selectableGroupState?.onTap(index);
  }
  _SelectableGroupState? _selectableGroupState;
  void bind(_SelectableGroupState state) {
    _selectableGroupState = state;
  }
}

/// 主组件
class SelectableGroup extends StatefulWidget {

  const SelectableGroup({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.multiple = false,
    this.defaultValue,
    this.enable = true,
    this.onDisabledTap,
    this.onSelectionChanged,
    this.mutualExclusionIndex = -1,
    this.enableFirstTrigger = false,
    this.controller,
    this.layout = SelectableLayout.column,
    this.spacing = 8,
    this.runSpacing = 8,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.childAspectRatio = 1.2,
  });

  /// 条目数
  final int itemCount;
  final Widget Function(BuildContext context, int index, bool isSelected) itemBuilder;

  /// 是否支持多选
  final bool multiple;
  /// 默认选中
  final dynamic defaultValue;
  /// 是否可用
  final bool enable;
  /// 点击不可用
  final VoidCallback? onDisabledTap;
  /// 选中回调
  final void Function(List<int> selected)? onSelectionChanged;
  /// 互斥索引
  final int mutualExclusionIndex;
  /// 第一次触发回调
  final bool enableFirstTrigger;
  /// 控制器
  final SelectableController? controller;

  /// 布局模式
  final SelectableLayout layout;

  /// Wrap 参数
  final double spacing;
  final double runSpacing;

  /// Grid 参数
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  State<SelectableGroup> createState() => _SelectableGroupState();
}

class _SelectableGroupState extends State<SelectableGroup> {
  late List<int> _selected;

  @override
  void initState() {
    super.initState();
    widget.controller?.bind(this);
    _selected = widget.multiple
        ? List<int>.from(widget.defaultValue ?? [])
        : <int>[widget.defaultValue ?? -1];

    widget.controller?._bindInternal(
      initialSelected: _selected,
      multiple: widget.multiple,
      onChanged: _externalUpdate,
    );

    if (widget.enableFirstTrigger && widget.onSelectionChanged != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          widget.onSelectionChanged!(_selected);
        });
      });
    }
  }

  void _externalUpdate(List<int> updated) {
    if (mounted) {
      setState(() => _selected = List.from(updated));
      widget.onSelectionChanged?.call(List.from(_selected));
    }
  }

  void onTap(int index) {
    if (!widget.enable) {
      widget.onDisabledTap?.call();
      return;
    }

    setState(() {
      if (widget.multiple) {
        if (widget.mutualExclusionIndex >= 0) {
          if (index == widget.mutualExclusionIndex) {
            _selected = [index];
          } else {
            _selected.remove(widget.mutualExclusionIndex);
            if (_selected.contains(index)) {
              _selected.remove(index);
            } else {
              _selected.add(index);
            }
          }
        } else {
          _selected.contains(index)
              ? _selected.remove(index)
              : _selected.add(index);
        }
      } else {
        _selected = [index];
      }
    });

    widget.onSelectionChanged?.call(List.from(_selected));
  }

  bool _isSelected(int index) => _selected.contains(index);


  @override
  void didUpdateWidget(SelectableGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null &&
        oldWidget.controller != widget.controller) {
      widget.controller?.bind(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = List.generate(widget.itemCount, (index) {
      return  widget.itemBuilder(context, index, _isSelected(index));
    });

    switch (widget.layout) {
      case SelectableLayout.wrap:
        return Wrap(
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          children: children,
        );

      case SelectableLayout.row:
        return Row(children: children);

      case SelectableLayout.grid:
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          childAspectRatio: widget.childAspectRatio,
          children: children,
        );
      default:
        return Column(children: children);
    }
  }
}
