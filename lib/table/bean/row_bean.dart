import 'cell_bean.dart';

///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class RowBean {

  ///单元格宽度 权重
  final List<int> flex;
  ///单元格内容
  final List<CellBean> cells;

  RowBean({required this.cells, this.flex = const []});
}
