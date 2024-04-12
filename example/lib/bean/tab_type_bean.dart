///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/8
/// create_time: 16:16
/// describe: 通用类型实体
///
class TabTypeBean<T> {
  TabTypeBean(
      {this.id,
      this.name,
      this.subName,
      this.path,
      this.url,
      this.fontIcon,
      this.fontIcon1,
      this.onClick,
      this.data,
      this.notice});

  String? name;
  String? subName;
  String? path;
  int? id;
  String? url;
  String? notice;
  int? fontIcon;
  int? fontIcon1;
  T? data;

  Function(TabTypeBean data)? onClick;
}
