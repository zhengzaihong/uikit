import 'package:flutter/material.dart';

import '../input_extend.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/11/26
/// create_time: 11:15
/// describe:控制器
///
class InputExtendController {
  InputExtendController();

  InputExtendState? _state;

  get getSearchData => _state?.getSearchData;

  void bind(InputExtendState state) {
    _state = state;
  }

  void notyListUiChange() {
    _state?.notyListUiChange();
  }

  void setText(String text) {
    _state?.setText(text);
  }

  InputExtendState? getState() {
    return _state;
  }

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


  void setCheckChange({required data}) {
    _state?.setCheckChange(data: data);
  }

  bool isCheckedVO(bool Function(dynamic item) data) {
    return _state?.isCheckedVO(data) ?? false;
  }
  bool isChecked(int index) {
    return _state?.isChecked(index)??false;
  }

  void closePop() {
    _state?.closePop();
  }


  void setSearchData(List<dynamic> list) {
    _state?.setSearchData(list);
  }
}
