import 'dart:async';


// void tap([String label = '']) {
//   print('tap: $label @ ${DateTime.now()}');
// }
//
// void search({required String keyword, int page = 1}) {
//   print('search: $keyword, page=$page @ ${DateTime.now()}');
// }
// void main() {
//   // —— throttle ——（1s 内只执行一次）
//   final t = tap.throttle(milliseconds: 1000); // 返回 dynamic，可直接调用
//   t('A');  // ✅ 执行
//   t('B');  // ❌ 窗口内丢弃
//   // 可随时取消窗口
//   t.cancel();
//
//   // —— debounce ——（停止输入 500ms 后执行；末尾触发）
//   final d = search.debounce(milliseconds: 500);
//   d(keyword: 'flutter', page: 1);
//   d(keyword: 'flutter', page: 2);
//   d(keyword: 'flutter', page: 3); // ✅ 只会执行这一笔
//   // 手动立即触发最后一笔
//   d.flush();
//
//   // —— debounce（leading + trailing + maxWait）——
//   final d2 = search.debounce(
//     milliseconds: 300,
//     leading: true,          // 首次立刻执行
//     trailing: true,         // 停止后再执行最后一笔
//     maxWaitMilliseconds: 1000, // 最长等待 1s 必触发一次
//   );
//   d2(keyword: 'dart', page: 1);
//   d2(keyword: 'dart', page: 2);
//   d2(keyword: 'dart', page: 3);
// }


/// 函数扩展方法，提供防抖和节流功能
/// 内部：通用工具
void _apply(Function fn, List<dynamic>? pos, Map<Symbol, dynamic>? named) {
  Function.apply(fn, pos ?? const [], named ?? const {});
}

/// —— Throttle 实现（领先沿，丢弃窗口内后续调用）——
class ThrottleInvoker {
  final Function _fn;
  final Duration _wait;
  Timer? _timer;
  bool _allowed = true;

  ThrottleInvoker(this._fn, this._wait);

  void cancel() {
    _timer?.cancel();
    _timer = null;
    _allowed = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    // 支持像函数一样调用：obj(...)
    if (invocation.memberName == #call) {
      if (!_allowed) return null;
      _allowed = false;
      _apply(_fn, invocation.positionalArguments, invocation.namedArguments);

      _timer?.cancel();
      _timer = Timer(_wait, () {
        _allowed = true;
      });
      return null;
    }
    return super.noSuchMethod(invocation);
  }
}

/// —— Debounce 实现（默认仅末尾触发，可配置 leading/trailing/maxWait）——
class DebounceInvoker {
  final Function _fn;
  final Duration _wait;
  final bool leading;
  final bool trailing;
  final Duration? maxWait;

  Timer? _timer;
  Timer? _maxTimer;
  bool _didLead = false;

  // 记录最后一次参数，用于 trailing/flush
  List<dynamic>? _lastPos;
  Map<Symbol, dynamic>? _lastNamed;

  DebounceInvoker(
      this._fn,
      this._wait, {
        this.leading = false,
        this.trailing = true,
        this.maxWait,
      });

  void _scheduleMax() {
    if (maxWait == null || _maxTimer != null) return;
    _maxTimer = Timer(maxWait!, () => flush());
  }

  void cancel() {
    _timer?.cancel();
    _maxTimer?.cancel();
    _timer = null;
    _maxTimer = null;
    _didLead = false;
    _lastPos = null;
    _lastNamed = null;
  }

  void flush() {
    _timer?.cancel();
    _timer = null;
    if (trailing && (_lastPos != null || _lastNamed != null)) {
      _apply(_fn, _lastPos, _lastNamed);
    }
    _didLead = false;
    _lastPos = null;
    _lastNamed = null;
    _maxTimer?.cancel();
    _maxTimer = null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #call) {
      _scheduleMax();

      // 领先沿
      if (leading && !_didLead) {
        _didLead = true;
        _apply(_fn, invocation.positionalArguments, invocation.namedArguments);
      }

      // 记录最后一次参数用于 trailing
      _lastPos = invocation.positionalArguments;
      _lastNamed = invocation.namedArguments;

      // 重置定时器，最后一次才执行
      _timer?.cancel();
      _timer = Timer(_wait, () => flush());
      return null;
    }
    return super.noSuchMethod(invocation);
  }
}

/// 扩展：返回 *可调用对象*（dynamic），支持不限参数与命名参数。
extension RateLimitFunctionX on Function {
  /// 节流：窗口期内只执行一次（领先沿触发）。
  /// 返回对象支持：直接调用、.cancel()
  ThrottleInvoker throttle({int milliseconds = 500}) {
    return ThrottleInvoker(this, Duration(milliseconds: milliseconds));
  }

  /// 防抖：默认仅末尾触发；可配置 leading/trailing/maxWait。
  /// 返回对象支持：直接调用、.cancel()、.flush()
  DebounceInvoker debounce({
    int milliseconds = 500,
    bool leading = false,
    bool trailing = true,
    int? maxWaitMilliseconds,
  }) {
    return DebounceInvoker(
      this,
      Duration(milliseconds: milliseconds),
      leading: leading,
      trailing: trailing,
      maxWait: maxWaitMilliseconds == null
          ? null
          : Duration(milliseconds: maxWaitMilliseconds),
    );
  }
}
