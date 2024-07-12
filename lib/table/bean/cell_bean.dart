
///通用性单元格实体，只针对非列表数据结构的处理成表格
///列表结构不要使用该类
class CellBean {
  String? name;
  int? rowIndex;
  int? cellIndex;
  final bool isTitle;

  ///附加信息
  dynamic obj;

  CellBean(
      {this.rowIndex,
        required this.name,
        this.cellIndex,
        this.obj,
        this.isTitle = false});
}
