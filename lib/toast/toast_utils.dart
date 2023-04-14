
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/23
/// create_time: 15:14
/// describe: toast工具,整体优化，改动较大 0.1.2 之后版本
///

typedef BuildToastStyle = Widget Function(BuildContext context,String msg);

///toast的显示位置
enum ToastPosition {
  center,
  bottom,
  top,
}


class Toast {

  Toast._();

  ///如果不关心，context调用，需在入口函数的 MaterialApp( navigatorKey: Toast.navigatorState ) 添加绑定
  static final navigatorState = GlobalKey<NavigatorState>();

  /// toast显示时间 单位 毫秒
  int showTime   =2000 ;

  /// 两次toast的间隔时间
  int intervalTime=2000  ;

  ///显示位置
  ToastPosition globalPosition = ToastPosition.center;

  ///构建toast样式
  BuildToastStyle? globalBuildToastStyle;
  /// 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  DateTime? _startedTime;

  factory Toast() => _instance;
  static final Toast _instance = Toast._internal();
  static Toast get instance => _instance;

  static final List<OverlayEntryManger> _overlayEntryMangers = [];

  Toast._internal() {
    globalBuildToastStyle ??=  (context, msg) => Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 60,
        margin: const EdgeInsets.only(left: 20,right: 20),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(msg,
            style: const TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 14)));
  }
  ///显示一个吐司
  static Future<OverlayEntryManger?> show(
    String msg,
    {
      BuildContext? context,
      BuildToastStyle? buildToastStyle,
      ToastPosition? position,
      int? showTime,
    }) async {

    ///防止多次弹出，外部设置间隔时间 默认2秒
    if (_instance._startedTime != null &&
        DateTime
            .now()
            .difference(_instance._startedTime!)
            .inMilliseconds <
            _instance.intervalTime) {
      return null;
    }

    buildToastStyle = buildToastStyle ??  _instance.globalBuildToastStyle;
    _instance._startedTime = DateTime.now();
     var _overlayEntry = OverlayEntry(
        builder: (BuildContext context) =>
            Positioned(
              top: _calToastPosition(context,position??_instance.globalPosition),
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child:buildToastStyle?.call(context, msg)
                  )),
            ));
    ///获取OverlayState
    if(context==null){
      ///创建和显示顶层OverlayEntry
      navigatorState.currentState?.overlay?.insert(_overlayEntry);
    }else{
      var overlayState =Overlay.of(context);
      overlayState?.insert(_overlayEntry);
    }
    var manger = OverlayEntryManger(_overlayEntry);
    _overlayEntryMangers.add(manger);
    manger.start(showTime??_instance.showTime, _instance._startedTime!).then((value){
      _overlayEntryMangers.remove(value);
    });
    return manger;
  }

  ///设置toast位置
  static double _calToastPosition(context,ToastPosition position){
    double backResult;
    if (position == ToastPosition.top) {
      backResult = MediaQuery
          .of(context)
          .size
          .height * 1 / 4;
    } else if (position == ToastPosition.center) {
      backResult = MediaQuery
          .of(context)
          .size
          .height * 2 / 5;
    } else {
      backResult = MediaQuery
          .of(context)
          .size
          .height * 3 / 4;
    }
    return backResult;
  }

  ///取消toast 显示
  static void cancelAll() async {
    for (var element in _overlayEntryMangers) {
      element.cancel();
    }
  }
  static void cancel(OverlayEntryManger? manger) async {
    manger?.cancel();
  }
}


class OverlayEntryManger{

  OverlayEntry? overlayEntry;

  OverlayEntryManger(this.overlayEntry);

  Future<OverlayEntryManger> start(int showTime,DateTime startedTime) async{

    await Future.delayed(Duration(milliseconds: showTime));
    ///移除浮层
    cancel();
    return Future.value(this);
  }

  void cancel(){
    overlayEntry?.remove();
  }
}