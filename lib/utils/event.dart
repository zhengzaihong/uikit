import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/7/30
/// create_time: 16:13
/// describe: 示例：
///
// class EventExample extends StatefulWidget {
//   const EventExample({Key? key}):super(key: key);
//   @override
//   State<EventExample> createState() => _EventExampleState();
// }
//
// class _EventExampleState extends State<EventExample> with EventSubscriber {
//   String? targetValue;
//   UserLoggedIn? currentUser;
//   @override
//   void initState() {
//     super.initState();
//     // target 通知自动解绑
//     listenTargetStream<String?>("login", (v) {
//       debugPrint("---v:${v}");
//       setState(() {
//         targetValue = v;
//       });
//     });
//     // 手动方式--注意dispose 需要及时： EventNotifier.remove("login");
//     // 注意这里不会覆盖之前的 target:login,如果有target只是注册监听
//     // EventNotifier.obtain("login", listener:(v){
//     //   debugPrint("-1--v:${v}");
//     //   setState(() {
//     //     targetValue = v.toString();
//     //   });
//     // });
//
//     // 全局 EventBus 自动解绑
//     listenEventStream<UserLoggedIn>((e) {
//       setState(() {
//         currentUser = e;
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("事件工具"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             FilledButton(onPressed: (){
//               EventNotifier.sendNotification("login", "fail");
//             }, child: const Text("target 通知2:login fail")),
//
//             const SizedBox(height: 20,),
//             FilledButton(onPressed: (){
//               EventNotifier.sendNotification("login", "success");
//             }, child: const Text("target 通知: login success")),
//
//             const SizedBox(height: 20,),
//
//
//             Text("target事件数据: $targetValue"),
//             StreamBuilder(
//               stream: EventNotifier.stream("login"),
//               initialData: "",
//               builder: (context, snapshot) {
//                 return Text("Stream:登录状态: ${snapshot.data}");
//               },
//             ),
//
//             const SizedBox(height: 20,),
//             FilledButton(onPressed: (){
//               EventBus.emit(UserLoggedIn(NumUtils.random(min: 1000,max: 999999).toString()));
//             }, child: const Text("全局EventBus：发送")),
//
//             const SizedBox(height: 20,),
//             Expanded(child: Text("当前用户id: ${currentUser?.userId}"))
//
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     //手动移除，推荐使用自动方式
//     // EventNotifier.remove("login");
//     super.dispose();
//   }
// }
//
// class UserLoggedIn {
//   final String userId;
//   UserLoggedIn(this.userId);
// }


/// --------------------
/// EventNotifier（局部 target 通知）
/// --------------------
class EventNotifier {
  static final Map<dynamic, ValueNotifier<dynamic>> _notifiers = HashMap();
  static final Map<dynamic, Set<void Function(dynamic)>> _listeners = HashMap();

  EventNotifier._();

  /// 获取已有的 ValueNotifier
  static ValueNotifier<T>? get<T>(dynamic target) {
    final notifier = _notifiers[target];
    if (notifier == null) return null;
    return notifier as ValueNotifier<T>;
  }

  /// 获取或创建 ValueNotifier
  static ValueNotifier<T> obtain<T>(
      dynamic target, {
        void Function(T value)? listener,
        T? defaultValue,
      }) {
    if (!_notifiers.containsKey(target)) {
      final notifier = ValueNotifier<T?>(defaultValue);
      _notifiers[target] = notifier;
      _listeners[target] = <void Function(dynamic)>{};

      notifier.addListener(() {
        final value = notifier.value;
        for (var l in _listeners[target]!.toList()) {
          l(value);
        }
      });
    }

    if (listener != null) {
      _listeners[target]!.add((value) => listener(value as T));
    }

    return _notifiers[target]! as ValueNotifier<T>;
  }

  /// 添加监听
  static void addListener<T>(dynamic target, void Function(T value) listener) {
    if (_listeners.containsKey(target)) {
      _listeners[target]!.add((value) => listener(value as T));
    }
  }

  /// 移除监听（不推荐手动，建议使用自动解绑或 Stream）
  static void removeListener<T>(dynamic target, void Function(T value) listener) {
    // 手动 removeListener 时无法移除包装 lambda
    // 推荐使用 EventSubscriber 自动解绑
    if(_listeners.containsKey(target)){
      _listeners.remove(listener);
    }
  }

  /// 一次性监听
  static void listenOnce<T>(dynamic target, void Function(T value) listener) {
    Function? wrapper;
    wrapper = (value) {
      listener(value as T);
      removeListener(target, wrapper as void Function(T));
    };
    addListener(target, wrapper as void Function(T));
  }

  /// 发送通知
  static void sendNotification<T>(dynamic target, T? object) {
    if (_notifiers.containsKey(target)) {
      (_notifiers[target]! as ValueNotifier<T?>).value = object;
    }
  }

  /// 移除某个 target
  static void remove(dynamic target) {
    _notifiers[target]?.dispose();
    _notifiers.remove(target);
    _listeners.remove(target);
  }

  /// 清空所有
  static void clear() {
    for (var notifier in _notifiers.values) {
      notifier.dispose();
    }
    _notifiers.clear();
    _listeners.clear();
  }

  /// --------------------
  /// 转为 Stream
  /// --------------------
  static Stream<T> stream<T>(dynamic target) {
    final controller = StreamController<T>.broadcast();
    final notifier = obtain<T>(target);
    // 推送当前值
    if (notifier.value != null) controller.add(notifier.value);
    void listener(dynamic value) => controller.add(value as T);
    addListener(target, listener);
    controller.onCancel = () => _listeners[target]?.remove(listener);
    return controller.stream;
  }
}

/// --------------------
/// 全局 EventBus（基于事件类型）
/// --------------------
class EventBus {
  static final Map<Type, Set<Function>> _eventListeners = {};

  EventBus._();

  //订阅
  static void on<T>(void Function(T event) listener) {
    _eventListeners.putIfAbsent(T, () => <Function>{});
    _eventListeners[T]!.add(listener);
  }

  //取消
  static void off<T>(void Function(T event) listener) {
    _eventListeners[T]?.remove(listener);
  }

  //一次性订阅
  static void once<T>(void Function(T event) listener) {
    Function? wrapper;
    wrapper = (event) {
      listener(event as T);
      off<T>(wrapper as void Function(T));
    };
    on<T>(wrapper as void Function(T));
  }

  //发送事件
  static void emit<T>(T event) {
    if (_eventListeners.containsKey(T)) {
      for (var listener in _eventListeners[T]!.toList()) {
        (listener as void Function(T)).call(event);
      }
    }
  }

  //清除
  static void clear() {
    _eventListeners.clear();
  }

  /// --------------------
  /// 转为 Stream
  /// --------------------
  static Stream<T> stream<T>() {
    final controller = StreamController<T>.broadcast();
    void listener(T event) => controller.add(event);
    on<T>(listener);
    controller.onCancel = () => off<T>(listener);
    return controller.stream;
  }
}

/// --------------------
/// 自动解绑封装
/// --------------------
class EventSubscription {
  final void Function() _cancel;
  EventSubscription(this._cancel);

  void cancel() => _cancel();
}

mixin EventSubscriber<T extends StatefulWidget> on State<T> {
  final List<EventSubscription> _subscriptions = [];

  /// 绑定 target 的监听，自动解绑
  void listenTarget<V>(
      dynamic target,
      void Function(V value) listener,
      ) {
    EventNotifier.addListener(target, listener);
    _subscriptions.add(EventSubscription(() {
      // 移除包装后的 lambda
      EventNotifier.removeListener(target, listener);
    }));
  }

  /// 绑定全局 EventBus 的监听，自动解绑
  void listenEvent<E>(
      void Function(E event) listener,
      ) {
    EventBus.on(listener);
    _subscriptions.add(EventSubscription(() {
      EventBus.off(listener);
    }));
  }

  /// 绑定 target 的 Stream，自动解绑
  void listenTargetStream<V>(
      dynamic target,
      void Function(V value) listener,
      ) {
    final sub = EventNotifier.stream<V>(target).listen(listener);
    _subscriptions.add(EventSubscription(() => sub.cancel()));
  }

  /// 绑定 EventBus 的 Stream，自动解绑
  void listenEventStream<E>(
      void Function(E event) listener,
      ) {
    final sub = EventBus.stream<E>().listen(listener);
    _subscriptions.add(EventSubscription(() => sub.cancel()));
  }

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    EventNotifier.clear();
    EventBus.clear();
    _subscriptions.clear();
    super.dispose();
  }
}
