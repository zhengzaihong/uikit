import 'dart:async';

/// 防抖
extension ThrottleExtension on Function {
  void Function() throttle({int milliseconds = 500}) {
    var isAllowed = true;
    Timer? throttleTimer;
    return () {
      if (!isAllowed) return;
      isAllowed = false;
      this();
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }

  void Function(T t) throttle1<T>({int milliseconds = 500}) {
    var isAllowed = true;
    Timer? throttleTimer;
    return (t) {
      if (!isAllowed) return;
      isAllowed = false;
      this(t);
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }

  void Function(T t, E e) throttle2<T, E>({int milliseconds = 500}) {
    var isAllowed = true;
    Timer? throttleTimer;
    return (t, e) {
      if (!isAllowed) return;
      isAllowed = false;
      this(t,e);
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }

  void Function(T t, E e, G g) throttle3<T, E, G>({int milliseconds = 500}) {
    var isAllowed = true;
    Timer? throttleTimer;
    return (t, e, g) {
      if (!isAllowed) return;
      isAllowed = false;
      this(t,e,g);
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }
}
