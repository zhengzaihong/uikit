import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/12
/// create_time: 13:54
/// describe: 侧边栏工具
///
class SmartDrawer extends StatefulWidget {
  final double elevation;
  final Widget child;
  final String? semanticLabel;
  final double? widthPercent;
  final double? width;
  final DrawerCallback? callback;
  final BoxDecoration? decoration;

  const SmartDrawer({
    Key? key,
    this.elevation = 0.0,
    required this.child,
    this.semanticLabel,
    this.widthPercent = 0.35,
    this.width,
    this.decoration,
    this.callback,
  }) : super(key: key);

  @override
  _SmartDrawerState createState() => _SmartDrawerState();
}

class _SmartDrawerState extends State<SmartDrawer> {
  @override
  void initState() {
    if (widget.callback != null) {
      widget.callback!(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.callback != null) {
      widget.callback!(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String? label = widget.semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = widget.semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        label = widget.semanticLabel ??
            MaterialLocalizations.of(context).drawerLabel;
    }
    double _width;
    if (widget.width != null) {
      _width = widget.width!;
    } else {
      _width = MediaQuery.of(context).size.width * widget.widthPercent!;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          color: Colors.transparent,
          elevation: widget.elevation,
          child: widget.decoration == null
              ? widget.child
              : Container(decoration: widget.decoration, child: widget.child),
        ),
      ),
    );
  }
}
