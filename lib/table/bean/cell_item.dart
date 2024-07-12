

import 'package:flutter/material.dart';


/// CellItem 每个元素的信息
///外部构建每个表格的样式信息
typedef BuildCell = Widget Function(CellItem cellItem, int index, double? weight);

class CellItem {
  AlignmentGeometry alignment;
  EdgeInsetsGeometry padding;
  Color background;

  final BuildCell buildCell;

  CellItem(
      {this.alignment = Alignment.center,
        this.background = Colors.transparent,
        this.padding = const EdgeInsets.all(0),
        required this.buildCell});
}
