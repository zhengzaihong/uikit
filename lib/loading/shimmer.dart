import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/3/11
/// create_time: 17:30
/// describe: 实现一个微光加载效果
/// 全局配置 + 局部覆盖
/// 微光滑动效果
/// 占位自动生成 SmartShimmerPlaceholder
/// Grid/Column/Row 全支持
/// 支持手动配置占位布局


/// 全局配置
class ShimmerConfig {
  final LinearGradient gradient;
  final Duration period;
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

/// 核心组件
class Shimmer extends StatefulWidget {
  final bool isLoading;
  final WidgetBuilder builder;
  final WidgetBuilder? placeholderBuilder;
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
