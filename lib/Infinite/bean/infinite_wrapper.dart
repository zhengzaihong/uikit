
class InfiniteWrapper{

  int? currentLevel;
  bool? hasNext;
  dynamic srcBean;
  bool? expand;
  String? title;
  String? pid;
  List<InfiniteWrapper>? childs;

  InfiniteWrapper({
    this.currentLevel,
    this.hasNext,
    this.srcBean,
    this.expand = false,
    this.title,
    this.childs,
    this.pid,
 });
}