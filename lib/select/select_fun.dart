import 'package:flutter/material.dart';

typedef DropDownButtonBuilder<T> = Widget Function(bool show);

typedef DropDownPopCreated = void Function(bool isShowPop);

typedef DropDownPopShow = void Function(bool isShowPop);

typedef DropDownPopDismiss =void Function(bool isShowPop);

typedef LayoutSelectPop = RelativeRect Function(RenderBox button,RenderBox overlay);