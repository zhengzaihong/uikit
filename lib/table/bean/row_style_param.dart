
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/7/12
/// create_time: 11:37
/// describe: 构建每一行的参数
///
class RowStyleParam<T>{

  RowStyleParam({this.data,this.rowWidth,this.cellWidth,this.index,this.enableDivider = false});

  bool enableDivider;

  int? index;

  T? data;

  /// 行高
  double? rowWidth;

  /// 单元格宽度
  List<double>? cellWidth;


}