import 'package:flutter/material.dart';

import '../bean/cell_item.dart';

class TabRow extends StatelessWidget {
  final bool enableDivider;
  final List<int> cellWidget;
  final double? rowDividerHeight;
  final double rowDividerWidth;
  final Color? dividerColor;
  final CellItem cellItem;
  final double? rowHeight;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final bool fixRowHeight;

  const TabRow(
      {this.enableDivider = true,
        this.rowDividerHeight,
        this.rowDividerWidth = 0.5,
        required this.cellWidget,
        required this.cellItem,
        this.rowHeight,
        this.mainAxisAlignment = MainAxisAlignment.start,
        this.mainAxisSize = MainAxisSize.max,
        this.crossAxisAlignment = CrossAxisAlignment.center,
        this.verticalDirection = VerticalDirection.down,
        this.textDirection,
        this.dividerColor = Colors.red,
        this.fixRowHeight = false,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRow();
  }

  Widget _buildRow() {
    return IntrinsicHeight(
      child: Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          verticalDirection: verticalDirection,
          textDirection: textDirection,
          children: _buildCells(cellWidget)),
    );
  }

  Widget _createRowLine() {
    if (!fixRowHeight && rowHeight != null) {
      return SizedBox(
        width: rowDividerWidth,
        height: rowHeight,
        child: Row(
          children: [
            Expanded(
                child: Container(
                  width: rowDividerWidth,
                  color: dividerColor,
                ))
          ],
        ),
      );
    }
    return Container(
      width: rowDividerWidth,
      height: rowDividerHeight,
      color: dividerColor,
    );
  }

  List<Widget> _buildCells(List<int> cellWidget) {
    List<Widget> cells = [];

    for (var i = 0; i < cellWidget.length; i++) {
      var widget = cellItem.buildCell(cellItem, i, null);
      cells.add(Expanded(
          flex: cellWidget[i],
          child: Row(children: [
            if (enableDivider) _createRowLine(),
            Expanded(
                child: Container(
                  color: cellItem.background,
                  padding: cellItem.padding,
                  alignment: cellItem.alignment,
                  child: widget,
                ))
          ])));
    }
    if (enableDivider) {
      cells.add(_createRowLine());
    }
    return cells;
  }
}