
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

  static final Map<dynamic, ValueNotifier> _listenerMap = HashMap();
  static final Map<dynamic, List<Function(dynamic)>> _listener = HashMap();

  EventNotifier._();

  static ValueNotifier? get(dynamic target) {
    return _listenerMap[target];
  }

  static ValueNotifier obtain<T>(dynamic target,{Function(dynamic)? listener,T? defaultValue}) {
    if (!_listenerMap.containsKey(target)) {
      final notifier = ValueNotifier<T?>(defaultValue);
      _listenerMap[target] = notifier;
      _listener[target] = [];
      notifier.addListener(() {
        _listener[target]?.forEach((element) {
          element(notifier.value);
        });
      });
    }
    if(null != listener){
     _listener[target]!.add(listener);
    }
    return _listenerMap[target]!;
  }


  static void addListener(dynamic target,Function(dynamic) listener) {
    if (_listener.containsKey(target)) {
      _listener[target]!.add(listener);
    }
  }

  static void removeListener(dynamic target,Function(dynamic) listener) {
    if (_listener.containsKey(target)) {
      _listener[target]!.remove(listener);
    }
  }


  static void sendNotification<T>(dynamic target, T? object) {
    if (_listenerMap.containsKey(target)) {
      _listenerMap[target]!.value = object;
    }
  }

  ///注意： 当有多个地方使用同一个ValueNotifier时，注意回收的时机。
  static void remove(dynamic target) {
    if (_listenerMap.containsKey(target)) {
      _listenerMap.remove(target);
    }

    if (_listener.containsKey(target)) {
      _listener.remove(target);
    }
  }

  static void clear(){
    _listenerMap.clear();
    _listener.clear();
  }
}