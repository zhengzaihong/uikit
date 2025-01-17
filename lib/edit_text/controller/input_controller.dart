import 'package:flutter/material.dart';

import '../input_text.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/11/26
/// create_time: 11:15
/// describe: 优化输入框 InputText 的控制器
///
class InputController {
  InputController();

  InputTextState? _state;

  void bind(InputTextState state) {
    _state = state;
  }

  void addPop() {
    _state?.addPop();
  }

  void removePop() {
    _state?.removePop();
  }

  void notyListUiChange() {
    _state?.notyListUiChange();
  }

  void clearContent() {
    _state?.clearContent();
  }

  bool isFocus()=>_state?.isFocus() ?? false;

  bool hasContent()=>_state?.getHasContent() ?? false;

  void setText(String text) {
    _state?.setText(text);
  }

  InputTextState? getState() =>_state;

  TextEditingController? getTextEditingController() {
    return _state?.getTextEditingController();
  }

  RenderBox? getRenderBox() {
    final obj = _state?.context.findRenderObject();
    if (obj != null) {
      return obj as RenderBox;
    }
    return null;
  }

  void dispose() {
    _state = null;
  }
}
