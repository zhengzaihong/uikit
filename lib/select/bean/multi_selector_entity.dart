///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025/6/24
/// create_time: 10:42
/// describe: 无限层级的选择项的父类,子类需要构造此类中的数据
/// Parent class of options at infinite levels，Subclasses need to construct the data in this class
///
///
class MultiSelectorEntity {

  //每项的id
  //ID of each item
  String? id;

  //每项的名称
  //Name of each item
  String? name;

  //是否选中
  //is checked
  bool isSelected;

  //额外数据
  //additional data
  dynamic extra;

  //子节点
  //child node
  List<MultiSelectorEntity>? children;

  MultiSelectorEntity({
    this.id,
    this.name,
    this.isSelected = false,
    this.extra,
    this.children,
  });

  factory MultiSelectorEntity.formJson(Map<String, dynamic> json) {
    return MultiSelectorEntity(
      id: json['id'],
      name: json['name'],
      isSelected: json['isSelected'],
      extra: json['extra'],
      children: json['children'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isSelected': isSelected,
      'extra': extra,
      'children': children,
    };
  }
}
