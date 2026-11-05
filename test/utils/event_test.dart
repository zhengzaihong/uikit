import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uikit_plus/utils/event.dart';

void main() {
  testWidgets('EventSubscriber dispose keeps other listeners alive',
      (tester) async {
    final target = Object();
    var received = 0;

    EventNotifier.obtain<int?>(target);
    EventNotifier.addListener<int?>(target, (value) => received++);

    await tester.pumpWidget(MaterialApp(home: _Subscriber(target: target)));
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));

    EventNotifier.sendNotification<int?>(target, 1);

    expect(received, 1);
    EventNotifier.remove(target);
  });
}

class _Subscriber extends StatefulWidget {
  const _Subscriber({required this.target});

  final Object target;

  @override
  State<_Subscriber> createState() => _SubscriberState();
}

class _SubscriberState extends State<_Subscriber> with EventSubscriber {
  @override
  void initState() {
    super.initState();
    listenTarget<int?>(widget.target, (_) {});
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}