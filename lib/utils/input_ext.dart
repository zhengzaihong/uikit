

import 'dart:async';

/// 输入框防抖 防止频繁调用
extension ThrottleExtension on Function {

  void Function(String? text) inputThrottle({int milliseconds = 500}) {
    var isAllowed = true;
    Timer? throttleTimer;
    return (text) {
      if (!isAllowed) return;
      isAllowed = false;
      this(text);
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }


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
}
