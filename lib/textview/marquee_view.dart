import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/9/26
/// create_time: 15:20
/// describe: 跑马灯组件 / Marquee Component
///
/// 支持垂直和横向滚动的跑马灯效果组件
/// Marquee component with vertical and horizontal scrolling support
///
/// ## 功能特性 / Features
/// - 📜 支持垂直滚动 / Vertical scrolling
/// - ➡️ 支持横向滚动 / Horizontal scrolling
/// - 🔄 支持循环播放 / Loop playback
/// - 🎨 支持渐变边缘 / Fade edge support
/// - ⚙️ 可自定义速度和间隔 / Customizable speed and interval
/// - 📢 支持索引变化回调 / Index change callback
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 垂直跑马灯
/// MarqueeView(
///   marqueeItems: ['消息1', '消息2', '消息3'],
///   direction: MarqueeDirection.vertical,
///   buildItem: (context, data) {
///     return Text(data, style: TextStyle(fontSize: 16));
///   },
/// )
///
/// // 横向跑马灯
/// MarqueeView(
///   marqueeItems: ['新闻1', '新闻2', '新闻3'],
///   direction: MarqueeDirection.horizontal,
///   speed: 1.0,
///   gap: 50,
///   buildItem: (context, data) {
///     return Text(data);
///   },
/// )
///
/// // 带渐变边缘
/// MarqueeView(
///   marqueeItems: items,
///   direction: MarqueeDirection.horizontal,
///   enableFadeEdge: true,
///   fadeEdgeWidth: 40,
///   buildItem: (context, data) {
///     return Container(
///       padding: EdgeInsets.all(8),
///       child: Text(data),
///     );
///   },
/// )
///
/// // 公告栏示例
/// MarqueeView(
///   marqueeItems: announcements,
///   direction: MarqueeDirection.vertical,
///   itemExtent: 40,
///   interval: Duration(seconds: 3),
///   animateDuration: Duration(milliseconds: 500),
///   onIndexChange: (index) {
///     print('当前显示: $index');
///   },
///   buildItem: (context, data) {
///     return Row(
///       children: [
///         Icon(Icons.campaign, size: 20),
///         SizedBox(width: 8),
///         Expanded(child: Text(data)),
///       ],
///     );
///   },
/// )
///
/// // 不循环播放
/// MarqueeView(
///   marqueeItems: ['第一条', '第二条', '最后一条'],
///   loop: false,
///   buildItem: (context, data) => Text(data),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - 垂直模式下 itemExtent 为单条高度 / itemExtent is item height in vertical mode
/// - 横向模式下 itemExtent 为容器高度 / itemExtent is container height in horizontal mode
/// - speed 越大横向滚动越快 / Larger speed means faster horizontal scrolling
/// - 数据为空时显示空白占位 / Shows blank placeholder when data is empty
///

/// 跑马灯方向 / Marquee Direction
enum MarqueeDirection { 
  /// 垂直滚动 / Vertical scrolling
  vertical, 
  /// 横向滚动 / Horizontal scrolling
  horizontal 
}

typedef BuildItem = Widget Function(BuildContext context, dynamic data);

class MarqueeView extends StatefulWidget {
  /// 数据源 / Data source
  /// 
  /// 跑马灯显示的数据列表
  /// List of data to display in marquee
  /// 
  /// 必填参数 / Required
  final List marqueeItems;

  /// 条目构建器 / Item builder
  /// 
  /// 构建每个数据项的UI
  /// Builds UI for each data item
  /// 
  /// 必填参数 / Required
  final BuildItem buildItem;

  /// 滚动方向 / Scroll direction
  /// 
  /// 垂直或横向滚动
  /// Vertical or horizontal scrolling
  /// 
  /// 默认值: MarqueeDirection.horizontal / Default: MarqueeDirection.horizontal
  final MarqueeDirection direction;

  /// 条目高度/容器高度 / Item height/Container height
  /// 
  /// 垂直模式: 单条高度 / Vertical: item height
  /// 横向模式: 容器高度 / Horizontal: container height
  /// 
  /// 默认值: 40 / Default: 40
  final double itemExtent;

  /// 显示间隔 / Display interval
  /// 
  /// 垂直模式下每条显示的时长
  /// Duration for each item in vertical mode
  /// 
  /// 默认值: Duration(seconds: 2) / Default: Duration(seconds: 2)
  final Duration interval;

  /// 动画时长 / Animation duration
  /// 
  /// 垂直切换动画的时长
  /// Duration of vertical transition animation
  /// 
  /// 默认值: Duration(milliseconds: 600) / Default: Duration(milliseconds: 600)
  final Duration animateDuration;

  /// 横向间距 / Horizontal gap
  /// 
  /// 横向模式下两个条目间的间距
  /// Gap between items in horizontal mode
  /// 
  /// 默认值: 40 / Default: 40
  final double gap;

  /// 横向滚动速度 / Horizontal scroll speed
  /// 
  /// 像素/帧,越大越快
  /// Pixels per frame, larger is faster
  /// 
  /// 默认值: 0.5 / Default: 0.5
  final double speed;

  /// 是否循环 / Loop playback
  /// 
  /// 是否循环播放
  /// Whether to loop playback
  /// 
  /// 默认值: true / Default: true
  final bool loop;

  /// 索引变化回调 / Index change callback
  /// 
  /// 垂直模式下当前显示索引变化时触发
  /// Triggered when current index changes in vertical mode
  final Function(int)? onIndexChange;

  /// 启用渐变边缘 / Enable fade edge
  /// 
  /// 是否启用淡入淡出边缘效果
  /// Whether to enable fade in/out edge effect
  /// 
  /// 默认值: false / Default: false
  final bool enableFadeEdge;

  /// 横向渐变宽度 / Horizontal fade width
  /// 
  /// 横向模式下渐变区域的宽度
  /// Width of fade area in horizontal mode
  /// 
  /// 默认值: 30 / Default: 30
  final double fadeEdgeWidth;

  /// 垂直渐变高度 / Vertical fade height
  /// 
  /// 垂直模式下渐变区域的高度
  /// Height of fade area in vertical mode
  /// 
  /// 默认值: 20 / Default: 20
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
