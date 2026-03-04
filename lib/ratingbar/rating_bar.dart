import 'package:flutter/material.dart';

/// 评分组件 - 支持整星、半星、精确评分等多种模式
///
/// Rating Bar Component - Supports full star, half star, and precise rating modes
///
/// ## 功能特性 / Features
/// - 支持自定义星星数量和大小 / Custom star count and size
/// - 支持步长控制(整星/半星/任意精度) / Step control (full/half/any precision)
/// - 支持只读模式 / Read-only mode support
/// - 完全自定义星星样式 / Fully customizable star appearance
/// - 可配置是否允许0分 / Configurable zero rating
/// -  持触摸和滑动交互 / Touch and swipe interaction
///
/// ## 使用场景 / Use Cases
/// - 商品评价 / Product reviews
/// - 用户满意度调查 / User satisfaction surveys
/// - 内容评分系统 / Content rating systems
/// - 技能等级展示 / Skill level display
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单评分条
/// RatingBar(
///   count: 5,
///   value: 3.5,
///   size: 30,
///   normalImage: Icon(Icons.star_border, color: Colors.grey),
///   selectImage: Icon(Icons.star, color: Colors.amber),
///   selectAble: true,
///   onRatingUpdate: (rating) {
///     print('当前评分: $rating');
///   },
/// )
/// ```
///
/// ## 高级示例 / Advanced Example
/// ```dart
/// // 半星评分(步长0.5)
/// RatingBar(
///   count: 5,
///   value: 3.5,
///   step: 0.5,
///   maxRating: 10.0,
///   allowZero: false,
///   normalImage: Icon(Icons.star_border),
///   selectImage: Icon(Icons.star, color: Colors.orange),
///   selectAble: true,
///   onRatingUpdate: (rating) => print(rating),
/// )
///
/// // 只读展示模式
/// RatingBar(
///   count: 5,
///   value: 4.2,
///   readOnly: true,
///   normalImage: Icon(Icons.star_border),
///   selectImage: Icon(Icons.star, color: Colors.amber),
/// )
/// ```
///
/// ## 注意事项 / Notes
/// - [value] 必须在 0 到 [maxRating] 之间 / Must be between 0 and [maxRating]
/// - [step] 必须大于 0 / Must be greater than 0
/// - [count] 必须大于 0 / Must be greater than 0
/// - 当 [readOnly] 为 true 时,[selectAble] 会被忽略 / [selectAble] is ignored when [readOnly] is true
/// - 建议使用 Icon 或 Image.asset 作为星星图片 / Recommend using Icon or Image.asset for star images
///
/// See also:
/// * [Slider] - Flutter 原生滑块组件
/// * [LinearProgressBar] - 本库的进度条组件
class RatingBar extends StatefulWidget {
  /// 星星数量 / Number of stars
  ///
  /// 显示的星星总数,通常为 5 个
  /// Total number of stars to display, typically 5
  ///
  /// 默认值: 5 / Default: 5
  /// 取值范围: > 0 / Range: > 0
  final int count;

  /// 最大评分值 / Maximum rating value
  ///
  /// 评分的最大值,配合 [count] 使用
  /// Maximum rating value, used with [count]
  ///
  /// 例如: count=5, maxRating=10.0 表示每颗星代表2分
  /// Example: count=5, maxRating=10.0 means each star represents 2 points
  ///
  /// 默认值: 10.0 / Default: 10.0
  /// 取值范围: > 0 / Range: > 0
  final double maxRating;

  /// 当前评分值 / Current rating value
  ///
  /// 当前的评分值,必须在 0 到 [maxRating] 之间
  /// Current rating value, must be between 0 and [maxRating]
  ///
  /// 默认值: 0 / Default: 0
  /// 取值范围: 0 ~ [maxRating] / Range: 0 ~ [maxRating]
  final double value;

  /// 星星大小 / Star size
  ///
  /// 每颗星星的宽度和高度(正方形)
  /// Width and height of each star (square)
  ///
  /// 默认值: 20 / Default: 20
  /// 取值范围: > 0 / Range: > 0
  final double size;

  /// 星星间距 / Spacing between stars
  ///
  /// 两颗星星之间的水平间距
  /// Horizontal spacing between two stars
  ///
  /// 默认值: 3 / Default: 3
  /// 取值范围: >= 0 / Range: >= 0
  final double padding;

  /// 未选中星星样式 / Unselected star widget
  ///
  /// 未被选中的星星显示的组件,通常使用 Icon 或 Image
  /// Widget to display for unselected stars, typically Icon or Image
  ///
  /// 示例 / Example:
  /// ```dart
  /// Icon(Icons.star_border, color: Colors.grey)
  /// Image.asset('assets/star_empty.png')
  /// ```
  final Widget normalImage;

  /// 选中星星样式 / Selected star widget
  ///
  /// 被选中的星星显示的组件,通常使用 Icon 或 Image
  /// Widget to display for selected stars, typically Icon or Image
  ///
  /// 示例 / Example:
  /// ```dart
  /// Icon(Icons.star, color: Colors.amber)
  /// Image.asset('assets/star_filled.png')
  /// ```
  final Widget selectImage;

  /// 是否可交互 / Whether interactive
  ///
  /// 是否允许用户通过点击或滑动来改变评分
  /// Whether to allow users to change rating by clicking or swiping
  ///
  /// 注意: 当 [readOnly] 为 true 时,此参数会被忽略
  /// Note: This parameter is ignored when [readOnly] is true
  ///
  /// 默认值: false / Default: false
  final bool selectAble;

  /// 评分变化回调 / Rating change callback
  ///
  /// 当评分值改变时触发的回调函数
  /// Callback function triggered when rating value changes
  ///
  /// 参数 [rating] 为新的评分值 / Parameter [rating] is the new rating value
  ///
  /// 示例 / Example:
  /// ```dart
  /// onRatingUpdate: (rating) {
  ///   print('新评分: $rating');
  ///   // 保存到数据库或状态管理
  /// }
  /// ```
  final ValueChanged<double>? onRatingUpdate;

  /// 评分步长 / Rating step
  ///
  /// 评分变化的最小单位
  /// Minimum unit of rating change
  ///
  /// - 1.0: 整星评分 / Full star rating
  /// - 0.5: 半星评分 / Half star rating
  /// - 0.1: 精确到0.1 / Precise to 0.1
  /// - 任意值 > 0 / Any value > 0
  ///
  /// 默认值: 1.0 / Default: 1.0
  /// 取值范围: > 0 / Range: > 0
  final double step;

  /// 是否允许0分 / Whether to allow zero rating
  ///
  /// - true: 允许评分为0 / Allow rating to be 0
  /// - false: 最低评分为 [step] / Minimum rating is [step]
  ///
  /// 默认值: true / Default: true
  final bool allowZero;

  /// 是否只读模式 / Whether read-only mode
  ///
  /// 只读模式下仅展示评分,不响应任何交互
  /// In read-only mode, only display rating without any interaction
  ///
  /// 适用场景: 展示历史评分、平均评分等
  /// Use cases: Display historical ratings, average ratings, etc.
  ///
  /// 默认值: false / Default: false
  final bool readOnly;

  const RatingBar({
    this.maxRating = 10.0,
    this.count = 5,
    this.value = 0,
    this.size = 20,
    required this.normalImage,
    required this.selectImage,
    this.padding = 3,
    this.selectAble = false,
    this.step = 1.0,
    this.allowZero = true,
    this.readOnly = false,
    this.onRatingUpdate,
    Key? key,
  }) : assert(count > 0, 'count must be greater than 0'),
       assert(maxRating > 0, 'maxRating must be greater than 0'),
       assert(value >= 0 && value <= maxRating, 'value must be between 0 and maxRating'),
       assert(size > 0, 'size must be greater than 0'),
       assert(padding >= 0, 'padding must be greater than or equal to 0'),
       assert(step > 0, 'step must be greater than 0'),
       super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  /// 当前评分值 / Current rating value
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = _validateAndClampValue(widget.value);
  }

  @override
  void didUpdateWidget(RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当外部value改变时,更新内部状态
    // Update internal state when external value changes
    if (oldWidget.value != widget.value) {
      _currentValue = _validateAndClampValue(widget.value);
    }
  }

  /// 验证并限制评分值在有效范围内
  /// Validate and clamp rating value within valid range
  double _validateAndClampValue(double value) {
    if (value < 0) return 0;
    if (value > widget.maxRating) return widget.maxRating;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    // 只读模式：仅展示,不响应交互
    // Read-only mode: Display only, no interaction
    if (widget.readOnly) {
      return _buildRatingDisplay();
    }

    // 可交互模式：支持点击和滑动
    // Interactive mode: Support click and swipe
    if (widget.selectAble) {
      return Listener(
        onPointerDown: _handlePointerDown,
        onPointerMove: _handlePointerMove,
        onPointerUp: _handlePointerUp,
        behavior: HitTestBehavior.opaque,
        child: _buildRatingDisplay(),
      );
    }

    // 不可交互模式：仅展示
    // Non-interactive mode: Display only
    return _buildRatingDisplay();
  }

  /// 处理指针按下事件 / Handle pointer down event
  void _handlePointerDown(PointerDownEvent event) {
    _updateRatingFromPosition(event.localPosition.dx);
  }

  /// 处理指针移动事件 / Handle pointer move event
  void _handlePointerMove(PointerMoveEvent event) {
    _updateRatingFromPosition(event.localPosition.dx);
  }

  /// 处理指针抬起事件 / Handle pointer up event
  void _handlePointerUp(PointerUpEvent event) {
    // 可以在这里添加点击反馈,如震动
    // Can add click feedback here, such as vibration
  }

  /// 根据触摸位置更新评分 / Update rating based on touch position
  ///
  /// [dx] 触摸点的x坐标 / X coordinate of touch point
  void _updateRatingFromPosition(double dx) {
    // 计算总宽度 / Calculate total width
    final totalWidth = widget.size * widget.count + widget.padding * (widget.count - 1);
    
    // 限制触摸范围 / Limit touch range
    double clampedDx = dx.clamp(0.0, totalWidth);
    
    // 计算原始评分值 / Calculate raw rating value
    double rawValue = (clampedDx / totalWidth) * widget.maxRating;
    
    // 对齐到步长 / Align to step
    double steppedValue = (rawValue / widget.step).round() * widget.step;
    
    // 限制在有效范围内 / Clamp to valid range
    steppedValue = steppedValue.clamp(0.0, widget.maxRating);
    
    // 处理不允许0分的情况 / Handle case when zero is not allowed
    if (!widget.allowZero && steppedValue == 0) {
      steppedValue = widget.step;
    }
    
    // 只有当值真正改变时才更新 / Only update when value actually changes
    if (steppedValue != _currentValue) {
      setState(() {
        _currentValue = steppedValue;
      });
      
      // 触发回调 / Trigger callback
      widget.onRatingUpdate?.call(_currentValue);
    }
  }

  /// 计算完整星星的数量 / Calculate number of full stars
  int _getFullStarCount() {
    final valuePerStar = widget.maxRating / widget.count;
    return (_currentValue / valuePerStar).floor();
  }

  /// 计算部分星星的填充比例 / Calculate partial star fill ratio
  double _getPartialStarRatio() {
    final valuePerStar = widget.maxRating / widget.count;
    final remainder = _currentValue % valuePerStar;
    return remainder / valuePerStar;
  }

  /// 构建选中状态的星星行 / Build selected stars row
  List<Widget> _buildSelectedStars() {
    final fullStarCount = _getFullStarCount();
    final partialRatio = _getPartialStarRatio();
    final List<Widget> children = [];

    // 添加完整的选中星星 / Add full selected stars
    for (int i = 0; i < fullStarCount; i++) {
      children.add(SizedBox(
        width: widget.size,
        height: widget.size,
        child: widget.selectImage,
      ));
      
      if (i < widget.count - 1) {
        children.add(SizedBox(width: widget.padding));
      }
    }

    // 添加部分选中的星星 / Add partially selected star
    if (fullStarCount < widget.count && partialRatio > 0) {
      children.add(
        ClipRect(
          clipper: _StarClipper(width: partialRatio * widget.size),
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: widget.selectImage,
          ),
        ),
      );
    }

    return children;
  }

  /// 构建未选中状态的星星行 / Build unselected stars row
  List<Widget> _buildNormalStars() {
    final List<Widget> children = [];
    
    for (int i = 0; i < widget.count; i++) {
      children.add(SizedBox(
        width: widget.size,
        height: widget.size,
        child: widget.normalImage,
      ));
      
      if (i < widget.count - 1) {
        children.add(SizedBox(width: widget.padding));
      }
    }
    
    return children;
  }

  /// 构建评分显示组件 / Build rating display widget
  Widget _buildRatingDisplay() {
    return Stack(
      children: <Widget>[
        // 底层：未选中的星星 / Bottom layer: Unselected stars
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildNormalStars(),
        ),
        // 顶层：选中的星星 / Top layer: Selected stars
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildSelectedStars(),
        ),
      ],
    );
  }
}

/// 星星裁剪器 - 用于实现部分星星填充效果
///
/// Star Clipper - Used to implement partial star fill effect
///
/// 通过裁剪实现星星的部分显示,支持任意比例的填充
/// Implements partial star display through clipping, supports any fill ratio
class _StarClipper extends CustomClipper<Rect> {
  /// 裁剪宽度 / Clip width
  final double width;

  const _StarClipper({required this.width});

  @override
  Rect getClip(Size size) {
    // 从左到右裁剪指定宽度 / Clip specified width from left to right
    return Rect.fromLTRB(0.0, 0.0, width, size.height);
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) {
    // 只有当宽度改变时才需要重新裁剪 / Only reclip when width changes
    return width != oldClipper.width;
  }
}
