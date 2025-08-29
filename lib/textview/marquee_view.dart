import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/9/26
/// create_time: 15:20
/// describe: 跑马灯效果,支持垂直和横向(横向是将多条数据 展平为一条从右向左滚动)
///

enum MarqueeDirection { vertical, horizontal }

typedef BuildItem = Widget Function(BuildContext context, dynamic data);

class MarqueeView extends StatefulWidget {
  // 数据源
  final List marqueeItems;
  // 构建条目
  final BuildItem buildItem;
  // 滚动方向
  final MarqueeDirection direction;
  // 组件高度 / 单条高度（垂直时等于单条高度；横向时用于约束外层高度）
  final double itemExtent;
  // 每条展示多久
  final Duration interval;
  // 动画时长
  final Duration animateDuration;
  // 横向滚动时两个 item 间的间距
  final double gap;
  // 横向滚动速度-越大越快（像素/帧）
  final double speed;
  // 是否循环
  final bool loop;
  final Function(int)? onIndexChange;

  /// 渐变边缘配置
  final bool enableFadeEdge; // 是否启用淡入淡出边缘
  // 横向渐变宽度
  final double fadeEdgeWidth;
  // 垂直渐变高度
  final double fadeEdgeHeight;

  const MarqueeView({
    Key? key,
    required this.marqueeItems,
    required this.buildItem,
    this.direction = MarqueeDirection.horizontal,
    this.itemExtent = 40,
    this.interval = const Duration(seconds: 2),
    this.animateDuration = const Duration(milliseconds: 600),
    this.gap = 40,
    this.speed = 0.5,
    this.loop = true,
    this.onIndexChange,
    this.enableFadeEdge = false,
    this.fadeEdgeWidth = 30,
    this.fadeEdgeHeight = 20,
  }) : super(key: key);

  @override
  State<MarqueeView> createState() => _MarqueeViewState();
}

class _MarqueeViewState extends State<MarqueeView> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int? _nextIndex;
  bool _isAnimating = false;

  ScrollController? _scrollController;
  Ticker? _ticker;
  double _scrollOffset = 0.0;

  AnimationController? _vController;
  Animation<double>? _vCurve;

  bool get _isHorizontal => widget.direction == MarqueeDirection.horizontal;

  @override
  void initState() {
    super.initState();
    if (_isHorizontal) _startHorizontal();
    if (!_isHorizontal) _initVerticalController();
    if (!_isHorizontal) WidgetsBinding.instance.addPostFrameCallback((_) => _startVerticalLoop());
  }

  void _initVerticalController() {
    _vController ??= AnimationController(
      vsync: this,
      duration: widget.animateDuration,
    );
    _vCurve ??= CurvedAnimation(parent: _vController!, curve: Curves.easeInOut);
  }

  void _startHorizontal() {
    _scrollController ??= ScrollController();
    _ticker ??= createTicker((_) {
      if (!mounted || _scrollController == null || !_scrollController!.hasClients) return;
      final max = _scrollController!.position.maxScrollExtent;
      if (max <= 0) return;
      _scrollOffset = (_scrollOffset + widget.speed).clamp(0.0, max);
      if (_scrollOffset >= max) {
        _scrollOffset = 0.0;
        _scrollController!.jumpTo(0.0);
      } else {
        _scrollController!.jumpTo(_scrollOffset);
      }
    });
    _ticker!.start();
  }

  void _stopHorizontal() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
    _scrollController?.dispose();
    _scrollController = null;
  }

  Future<void> _startVerticalLoop() async {
    if (widget.marqueeItems.length <= 1) return;
    while (mounted) {
      await Future.delayed(widget.interval);
      if (!mounted) break;
      if (_isAnimating) continue;

      final next = (_currentIndex + 1) % widget.marqueeItems.length;
      setState(() {
        _nextIndex = next;
        _isAnimating = true;
      });

      await _vController!.forward(from: 0.0);
      if (!mounted) break;

      setState(() {
        _currentIndex = next;
        widget.onIndexChange?.call(_currentIndex);
        _nextIndex = null;
        _isAnimating = false;
        _vController!.reset();
      });

      if (!widget.loop && _currentIndex == widget.marqueeItems.length - 1) break;
    }
  }

  @override
  void dispose() {
    _stopHorizontal();
    _vController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.marqueeItems.isEmpty) return SizedBox(height: widget.itemExtent);
    return _isHorizontal ? _buildHorizontal() : _buildVertical();
  }

  /// 横向跑马灯
  Widget _buildHorizontal() {
    final base = SizedBox(
      height: widget.itemExtent,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder: (_, __) => SizedBox(width: widget.gap),
        itemCount: widget.marqueeItems.length == 1 ? 1 : widget.marqueeItems.length * 2,
        itemBuilder: (context, index) {
          final item = widget.marqueeItems[index % widget.marqueeItems.length];
          return Align(alignment: Alignment.centerLeft, child: widget.buildItem(context, item));
        },
      ),
    );

    if (!widget.enableFadeEdge) return base;

    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth.isFinite ? constraints.maxWidth : 0.0;
      final leftStop = w == 0 ? 0.0 : (widget.fadeEdgeWidth / w).clamp(0.0, 0.5);
      final rightStart = 1 - leftStop;
      return ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: [0.0, leftStop, rightStart, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: base,
      );
    });
  }

  /// 垂直跑马灯
  Widget _buildVertical() {
    final height = widget.itemExtent;
    final content = SizedBox(
      height: height,
      child: ClipRect(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (_nextIndex != null) ...[
              Positioned.fill(
                child: SlideTransition(
                  position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
                      .animate(_vCurve!),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_vCurve!),
                    child: IgnorePointer(
                      ignoring: true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        key: ValueKey<int>(_currentIndex),
                        child: widget.buildItem(context, widget.marqueeItems[_currentIndex]),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(_vCurve!),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(_vCurve!),
                    child: IgnorePointer(
                      ignoring: true,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        key: ValueKey<int>(_nextIndex!),
                        child: widget.buildItem(context, widget.marqueeItems[_nextIndex!]),
                      ),
                    ),
                  ),
                ),
              ),
            ] else
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  key: ValueKey<int>(_currentIndex),
                  child: widget.buildItem(context, widget.marqueeItems[_currentIndex]),
                ),
              ),
          ],
        ),
      ),
    );

    if (!widget.enableFadeEdge) return content;

    return LayoutBuilder(builder: (context, constraints) {
      final h = constraints.maxHeight.isFinite ? constraints.maxHeight : height;
      final topStop = h == 0 ? 0.0 : (widget.fadeEdgeHeight / h).clamp(0.0, 0.5);
      final bottomStart = 1 - topStop;
      return ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: [0.0, topStop, bottomStart, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: content,
      );
    });
  }
}
