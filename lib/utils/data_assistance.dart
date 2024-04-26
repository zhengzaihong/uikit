
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2024/4/26
/// create_time: 14:32
/// describe: 数据处理相关语法糖
///


/// future 数据滤空
extension Unwrap<T> on Future<T?> {
  Future<T> unwrap() => then(
        (value) => value != null
        ? Future<T>.value(value)
        : Future.any([]),
  );
}

///数据流滤空
//Stream<int?>.periodic(
//     const Duration(seconds: 1),
//     (value) => value % 2 == 0 ? value : null,
//   ).unwrap().listen((evenValue) {
//     print(evenValue);
//   });
//  输出结果 :0 2 4 6 ...

extension UnwrapStream<T> on Stream<T?> {
  Stream<T> unwrap() => where((event) => event != null).cast();
}



/// 数据展平
//  final flat = [
//     [[1, 2, 3], 4, 5],
//     [6, [7, [8, 9]], 10],
//     11,12
//   ].flatten();
//   print(flat); // (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)

extension Flatten<T extends Object> on Iterable<T> {
  Iterable<T> flatten() {
    Iterable<T> _flatten(Iterable<T> list) sync* {
      for (final value in list) {
        if (value is List<T>) {
          yield* _flatten(value);
        } else {
          yield value;
        }
      }
    }
    return _flatten(this);
  }
}


/// 数据追加
// const Iterable<int> values = [10, 20, 30];
// print((values & [40, 50]));
// 输出结果：(10, 20, 30, 40, 50)

extension InlineAdd<T> on Iterable<T> {
  Iterable<T> operator +(T other) => followedBy([other]);
  Iterable<T> operator &(Iterable<T> other) => followedBy(other);
}


/// Map 1数据过滤
// const Map<String, int> people = {'John': 20, 'Mary': 21, 'Peter': 22};
// print(people.where((key, value) => key.length > 4 && value > 20)); // {Peter: 22}
// print(people.whereKey((key) => key.length < 5)); // {John: 20, Mary: 21}
// print(people.whereValue((value) => value.isEven)); // {John: 20, Peter: 22}

extension DetailedWhere<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
    entries.where((entry) => f(entry.key, entry.value)),
  );

  Map<K, V> whereKey(bool Function(K key) f) =>
      {...where((key, value) => f(key))};

  Map<K, V> whereValue(bool Function(V value) f) =>
      {...where((key, value) => f(value))};
}


/// Map 2数据过滤
//  const Map<String, int> people = {
//     'foo': 20,
//     'bar': 31,
//     'baz': 25,
//     'qux': 32,
//   };
//   final peopleOver30 = people.filter((e) => e.value > 30);

//   print(peopleOver30); // 输出结果：(MapEntry(bar: 31), MapEntry(qux: 32))

extension Filter<K, V> on Map<K, V> {
  Iterable<MapEntry<K, V>> filter(
      bool Function(MapEntry<K, V> entry) f,
      ) sync* {
    for (final entry in entries) {
      if (f(entry)) {
        yield entry;
      }
    }
  }
}

/// Map 数据合并
//const userInfo = {
//   'name': 'StellarRemi',
//   'age': 28,
// };
//
// const address = {
//   'address': 'shanghai',
//   'post_code': '200000',
// };

// final allInfo = userInfo.merge(address);
// print(allInfo);
// 输出结果：{name: StellarRemi, age: 28, address: shanghai, post_code: 200000}

extension Merge<K, V> on Map<K, V> {
  Map<K, V> merge(Map<K, V> other) => {...this}..addEntries(
    other.entries,
  );
}
