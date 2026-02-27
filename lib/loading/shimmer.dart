import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/3/11
/// create_time: 17:30
/// describe: Shimmer 微光加载效果组件 / Shimmer Loading Effect Component
///
/// 实现骨架屏加载效果,支持全局配置和局部覆盖
/// Implements skeleton screen loading effect with global and local configuration
///
/// ## 功能特性 / Features
/// - ✨ 微光滑动效果 / Shimmer sliding effect
/// - 🎨 支持自定义渐变色 / Custom gradient colors
/// - 🔧 全局配置 + 局部覆盖 / Global config + local override
/// - 🤖 自动生成占位布局 / Auto-generate placeholder
/// - 📋 支持列表加载 / List loading support
/// - 🎯 支持 Grid/Column/Row / Grid/Column/Row support
///
/// ## 基础示例 / Basic Example
/// ```dart
/// // 简单使用
/// Shimmer(
///   isLoading: true,
///   builder: (context) {
///     return ListTile(
///       leading: CircleAvatar(),
///       title: Text('标题'),
///       subtitle: Text('副标题'),
///     );
///   },
/// )
///
/// // 自定义占位
/// Shimmer(
///   isLoading: true,
///   builder: (context) => YourWidget(),
///   placeholderBuilder: (context) {
///     return Container(
///       height: 100,
///       color: Colors.grey[300],
///     );
///   },
/// )
///
/// // 自定义配置
/// Shimmer(
///   isLoading: true,
///   config: ShimmerConfig(
///     gradient: LinearGradient(
///       colors: [Colors.grey[300]!, Colors.grey[100]!, Colors.grey[300]!],
///     ),
///     period: Duration(milliseconds: 1000),
///   ),
///   builder: (context) => YourWidget(),
/// )
///
/// // 列表加载
/// AutoShimmerList(
///   isLoading: true,
///   direction: ShimmerListDirection.vertical,
///   children: [
///     ListTile(title: Text('Item 1')),
///     ListTile(title: Text('Item 2')),
///     ListTile(title: Text('Item 3')),
///   ],
/// )
///
/// // Grid 加载
/// AutoShimmerList(
///   isLoading: true,
///   direction: ShimmerListDirection.grid,
///   crossAxisCount: 2,
///   children: List.generate(6, (i) => Container(height: 100)),
/// )
/// ```
///
/// ## 全局配置 / Global Configuration
/// ```dart
/// // 在 main.dart 中配置
/// ShimmerConfig.setGlobal(
///   ShimmerConfig(
///     gradient: LinearGradient(
///       colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
///     ),
///     period: Duration(milliseconds: 1500),
///   ),
/// );
/// ```
///
/// ## 注意事项 / Notes
/// - isLoading 为 true 时显示加载效果 / Shows loading when true
/// - 未提供 placeholderBuilder 时自动生成占位 / Auto-generates placeholder when not provided
/// - 支持 Text、CircleAvatar、Container 等常见组件 / Supports common widgets
///

/// 全局配置类 / Global Configuration Class
class ShimmerConfig {
  /// 渐变色配置 / Gradient configuration
  final LinearGradient gradient;

  /// 动画周期 / Animation period
  final Duration period;

  /// 动画曲线 / Animation curve
  final Curve curve;

  const ShimmerConfig({
    this.gradient = const LinearGradient(
      colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
      stops: [0.1, 0.3, 0.4],
      begin: Alignment(-1, -0.3),
      end: Alignment(1, 0.3),
    ),
    this.period = const Duration(milliseconds: 1500),
    this.curve = Curves.linear,
  });

  static ShimmerConfig _global = const ShimmerConfig();

  static ShimmerConfig get global => _global;

  static void setGlobal(ShimmerConfig config) => _global = config;
}

/// Shimmer 核心组件 / Shimmer Core Component
class Shimmer extends StatefulWidget {
  /// 是否加载中 / Is loading
  /// 
  /// true: 显示加载效果 / Show loading effect
  /// false: 显示实际内容 / Show actual content
  final bool isLoading;

  /// 内容构建器 / Content builder
  /// 
  /// 构建实际要显示的内容
  /// Builds the actual content to display
  final WidgetBuilder builder;

  /// 占位构建器 / Placeholder builder
  /// 
  /// 自定义加载时的占位布局
  /// Custom placeholder layout when loading
  /// 
  /// 不提供时自动生成 / Auto-generates when not provided
  final WidgetBuilder? placeholderBuilder;

  /// Shimmer 配置 / Shimmer configuration
  /// 
  /// 局部配置,覆盖全局配置
  /// Local config, overrides global config
  /// 
  /// 不提供时使用全局配置 / Uses global config when not provided
  final ShimmerConfig? config;

  const Shimmer({
    Key? key,
    required this.isLoading,
    required this.builder,
    this.placeholderBuilder,
    this.config,
  }) : super(key: key);

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ShimmerConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.config ?? ShimmerConfig.global;

    // AnimationController 范围 [0,1]
    _controller = AnimationController(
      vsync: this,
      duration: _config.period,
    )..repeat();

    _animation = CurvedAnimation(parent: _controller, curve: _config.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.builder(context);

    final placeholder = widget.placeholderBuilder != null
        ? widget.placeholderBuilder!(context)
        : SmartShimmerPlaceholder.generate(widget.builder(context));

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: _config.gradient.colors,
              stops: _config.gradient.stops,
              begin: _config.gradient.begin,
              end: _config.gradient.end,
              tileMode: _config.gradient.tileMode,
              transform:
              _SlidingGradientTransform(slidePercent: _animation.value),
            ).createShader(bounds);
          },
          child: placeholder,
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    // 此时 slidePercent 永远在 [0,1]，安全
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

/// 自动生成占位 Widget
class SmartShimmerPlaceholder {
  static Widget generate(
      Widget child, {
        Color? color,
        double borderRadius = 8,
      }) {
    color ??= Colors.grey[300]!;
    return _SmartPlaceholder(
      child: child,
      color: color,
      borderRadius: borderRadius,
    );
  }
}

class _SmartPlaceholder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;

  const _SmartPlaceholder({
    Key? key,
    required this.child,
    required this.color,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child is Text) {
      final t = child as Text;
      return Container(
        width: double.infinity,
        height: t.style?.fontSize ?? 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: const EdgeInsets.symmetric(vertical: 2),
      );
    } else if (child is CircleAvatar) {
      final c = child as CircleAvatar;
      double size = (c.radius ?? 25) * 2;
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    } else if (child is SizedBox) {
      final s = child as SizedBox;
      return Container(
        width: s.width ?? double.infinity,
        height: s.height ?? 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    } else if (child is Container) {
      final c = child as Container;
      double width = double.infinity;
      double height = 16;

      if (c.constraints != null) {
        width = c.constraints!.hasBoundedWidth
            ? c.constraints!.maxWidth
            : double.infinity;
        height =
        c.constraints!.hasBoundedHeight ? c.constraints!.maxHeight : 16;
      }

      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    } else if (child is Column || child is Row) {
      final children = (child is Column
          ? (child as Column).children
          : (child as Row).children)
          .map((c) => SmartShimmerPlaceholder.generate(c,
          color: color, borderRadius: borderRadius))
          .toList();
      return child is Column
          ? Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children)
          : Row(children: children);
    }

    // 默认占位
    return Container(
      width: double.infinity,
      height: 16,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}

/// 列表方向
enum ShimmerListDirection { vertical, horizontal, grid }

/// 自动列表 shimmer
class AutoShimmerList extends StatelessWidget {
  final List<Widget> children;
  final bool isLoading;
  final ShimmerListDirection direction;
  final double spacing;
  final double borderRadius;
  final ShimmerConfig? config;
  final int crossAxisCount;

  const AutoShimmerList({
    required this.children,
    required this.isLoading,
    this.direction = ShimmerListDirection.vertical,
    this.spacing = 8,
    this.borderRadius = 8,
    this.config,
    this.crossAxisCount = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      config: config,
      placeholderBuilder: (_) {
        switch (direction) {
          case ShimmerListDirection.vertical:
            return Column(
              children: List.generate(
                children.length,
                    (i) => Padding(
                  padding: EdgeInsets.only(
                      bottom: i == children.length - 1 ? 0 : spacing),
                  child: SmartShimmerPlaceholder.generate(children[i],
                      borderRadius: borderRadius),
                ),
              ),
            );
          case ShimmerListDirection.horizontal:
            return Row(
              children: List.generate(
                children.length,
                    (i) => Padding(
                  padding: EdgeInsets.only(
                      right: i == children.length - 1 ? 0 : spacing),
                  child: SmartShimmerPlaceholder.generate(children[i],
                      borderRadius: borderRadius),
                ),
              ),
            );
          case ShimmerListDirection.grid:
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: children.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemBuilder: (_, i) => SmartShimmerPlaceholder.generate(
                children[i],
                borderRadius: borderRadius,
              ),
            );
        }
      },
      builder: (_) {
        switch (direction) {
          case ShimmerListDirection.vertical:
            return Column(children: children);
          case ShimmerListDirection.horizontal:
            return Row(children: children);
          case ShimmerListDirection.grid:
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: children.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemBuilder: (_, i) => children[i],
            );
        }
      },
    );
  }
}
