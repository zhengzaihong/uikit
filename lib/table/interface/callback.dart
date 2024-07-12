
import 'package:flutter/material.dart';

import '../bean/row_style_param.dart';

///构建标题行
// typedef BuildTableHeaderStyle<T> = Widget Function(
//     BuildContext context, double rowWidth, List<double> cellWidth);

typedef BuildTableHeaderStyle<T> = Widget Function(
    BuildContext context, RowStyleParam rowStyle);

///构建每一行的样式
// typedef BuildRowStyle<T> = Widget Function(
//     T data, int index, double rowWidth, List<double> cellWidth);
typedef BuildRowStyle<T> = Widget Function(RowStyleParam rowStyle);

///预处理数据
typedef PreDealData<T> = List<T> Function();


///构建每一行的样式
typedef BuildFixHeaderRowStyle<T> = Widget Function(RowStyleParam rowStyle);

// typedef BuildFixHeaderRowStyle<T> = Widget Function(
//     T data, int index, double rowWidth, List<double> cellWidth);