
import 'dart:collection';

import 'package:flutter/foundation.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/7/30
/// create_time: 16:13
/// describe:
///
class EventNotifier{


  static final Map<dynamic, ValueNotifier<dynamic>> _listenerMap = HashMap();

  EventNotifier._();


  static ValueNotifier<dynamic>? get(dynamic target) {
    return _listenerMap[target];
  }

  static ValueNotifier obtain(dynamic target) {
    if (!_listenerMap.containsKey(target)) {
      _listenerMap[target] = ValueNotifier(null);
    }
    return _listenerMap[target]!;
  }


  static void sendNotification(dynamic target, dynamic object) {
    if (_listenerMap.containsKey(target)) {
      _listenerMap[target]!.value = object;
    }
  }

  static void remove(dynamic target) {
    if (_listenerMap.containsKey(target)) {
      _listenerMap.remove(target);
    }
  }
}