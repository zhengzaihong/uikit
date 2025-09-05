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
  @override
  void initState() {
    super.initState();
    // target 通知自动解绑
    listenTargetStream<String?>("login", (v) {
      debugPrint("---v:${v}");
      setState(() {
        targetValue = v;
      });
    });
    //手动方式--注意dispose 需要及时： EventNotifier.remove("login");
    //注意这里不会覆盖之前的 target:login,如果有target只是注册监听
    EventNotifier.obtain("login", listener:(v){
      debugPrint("-1--v:${v}");
      setState(() {
        targetValue = v.toString();
      });
    });

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
    //手动移除，推荐使用自动方式
    // EventNotifier.remove("login");
    super.dispose();
  }
}

class UserLoggedIn {
  final String userId;
  UserLoggedIn(this.userId);
}

