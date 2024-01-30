///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/10/9
/// create_time: 17:35
/// describe: 实现无线层级的实体类
/// 实际开发中需要将 您的菜单类别转换成该类模型。
///
///
class InfiniteMenu {

  ///附加数据
  dynamic obj;
  /// 当前菜单标题
  String? title;
  bool isChecked;
  /// 子孙菜单
  List<InfiniteMenu>? children;

  InfiniteMenu({
    this.obj,
    this.title,
    this.children,
    this.isChecked = false,
  });

  toMap() {
    return {
      "obj": obj,
      "title": title,
      "children": children,
      'isChecked': isChecked
    };
  }

  fromMap(Map<String, dynamic> map) {
    obj = map['obj'];
    title = map['title'];
    children = map['children'];
    isChecked = map['isChecked'];
  }

}
