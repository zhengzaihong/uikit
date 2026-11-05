import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';


class EventExample extends StatefulWidget {

  const EventExample({Key? key}):super(key: key);

  @override
  State<EventExample> createState() => _EventExampleState();
}

class _EventExampleState extends State<EventExample> with EventSubscriber {

  String? targetValue;
  UserLoggedIn? currentUser;

  void _manualLoginListener(String? value) {
    debugPrint("-1--v:$value");
    if (!mounted) return;
    setState(() {
      targetValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    // target 通知自动解绑
    listenTargetStream<String?>("login", (v) {
      debugPrint("---v:$v");
      setState(() {
        targetValue = v;
      });
    });
    //手动方式--需要在 dispose 中手动移除
    EventNotifier.obtain<String?>("login", listener: _manualLoginListener);

    // 全局 EventBus 自动解绑
    listenEventStream<UserLoggedIn>((e) {
      setState(() {
        currentUser = e;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("事件工具"),
      ),
      body: Center(
        child: Column(
          children: [
            FilledButton(onPressed: (){
              EventNotifier.sendNotification("login", "fail");
            }, child: const Text("target 通知2:login fail")),

            const SizedBox(height: 20,),
            FilledButton(onPressed: (){
              EventNotifier.sendNotification("login", "success");
            }, child: const Text("target 通知: login success")),

            const SizedBox(height: 20,),


            Text("target事件数据: $targetValue"),
            StreamBuilder(
              stream: EventNotifier.stream("login"),
              initialData: "",
              builder: (context, snapshot) {
                return Text("Stream:登录状态: ${snapshot.data}");
              },
            ),

            const SizedBox(height: 20,),
            FilledButton(onPressed: (){
              EventBus.emit(UserLoggedIn(NumUtils.random(min: 1000,max: 999999).toString()));
            }, child: const Text("全局EventBus：发送")),

            const SizedBox(height: 20,),
            Expanded(child: Text("当前用户id: ${currentUser?.userId}"))

          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // EventNotifier.removeListener<String?>("login", _manualLoginListener);
    super.dispose();
  }
}

class UserLoggedIn {
  final String userId;
  UserLoggedIn(this.userId);
}

