import 'dart:async';
import 'dart:collection';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2022/7/20
/// create_time: 10:10
/// describe: 全局 订阅模式
///
class BroadcastHelper {

  static final StreamController<Object?> _streamController = StreamController();

  static BroadcastHelper? _instance;

  static Stream? _broadcastStream;

  static final Map<dynamic, dynamic> _listenerMap = HashMap();

  static BroadcastHelper getInstance() {
    _instance ??= BroadcastHelper._();
    return _instance!;
  }

  BroadcastHelper._() {
    _broadcastStream = _streamController.stream.asBroadcastStream();
  }

  void sendBroadcast(dynamic target,{ Object? object}) {
    var message = Message.obtain();
    message.target = target;
    message.msg = object;
    _streamController.sink.add(message);
  }

  void close() {
    _streamController.sink.close();
  }

  void unRegist(dynamic target){
    if(_listenerMap.containsKey(target)){
      _listenerMap.remove(target);
    }
  }
  void regist(dynamic target, void Function(Object? object) onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    if (_listenerMap.containsKey(target)) {
      return;
    }
    _listenerMap[target] = onData;
    if(!_streamController.hasListener){
      _broadcastStream?.distinct().listen((data) {
        var message = (data as Message);
        _listenerMap.forEach((key, value) {
          if (message.target == key) {
             value(message.msg);
          }
        });
      }, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    }
  }
}

class Message {
  dynamic _target;
  dynamic _msg;

  Message._();

  static Message obtain() {
    return Message._();
  }

  dynamic get msg => _msg;

  set msg(dynamic value) {
    _msg = value;
  }

  dynamic get target => _target;

  set target(dynamic value) {
    _target = value;
  }
}
