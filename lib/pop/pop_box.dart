///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024-04-24
/// create_time: 13:35
/// describe: 约束浮层的条件
///
class PopBox {
  double? width;
  double? height;

  ///limitSize 为真，则约束宽度无效，可无限延伸
  final bool limitSize;

  PopBox({this.width, this.height, this.limitSize = false});
}
