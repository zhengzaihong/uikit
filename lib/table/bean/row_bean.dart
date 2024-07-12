
import 'cell_bean.dart';

///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class RowBean {

  final List<CellBean> cells;

  RowBean({required this.cells});
}

