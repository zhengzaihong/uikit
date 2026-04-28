///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2024-04-24
/// time: 13:35
/// describe: 约束浮层的条件
///
class PopBox {
  double? width;
  double? height;

  ///limitSize 为真，则约束宽度无效，可无限延伸
  final bool limitSize;

  PopBox({this.width, this.height, this.limitSize = false});
}
