///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/9
/// create_time: 17:35
/// describe: 实现无线层级的实体类
/// 实际开发中需要将 您的菜单类别转换成该类模型。
///
///
class InfiniteWrapper {

  ///附加数据
  dynamic tagObj;

  ///是否展开
  bool? expand;

  /// 当前菜单标题
  String? title;

  ///该层级的 唯一标识。 同一层级的pid 因该一直
  String pid;

  /// 是否是 根节点
  bool? isRoot;

  /// 子孙菜单
  List<InfiniteWrapper>? childs;

  InfiniteWrapper({
    this.tagObj,
    this.expand = false,
    this.isRoot = false,
    this.title,
    this.childs,
    required this.pid,
  });
}
