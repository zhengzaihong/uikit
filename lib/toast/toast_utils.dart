import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uikit/toast/toast_config.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/23
/// create_time: 15:14
/// describe: toast工具
///
class Toast {

  /// 弹出浮层
  static OverlayEntry? _overlayEntry;

  /// 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static DateTime? _startedTime;

  static bool _showing=false;

  ///一个默认的样式,外部可自定义
  static final ToastConfig _toastConfig= ToastConfig(buildToastWidget: (context,msg){
    return  Container(
        width: MediaQuery.of(context).size.width/3,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lightBlue.withAlpha(200),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(msg,style: const TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,fontSize: 12)));
  });


  static ToastConfig get getToastConfig =>_toastConfig;


  ///显示一个吐司
  static void show({
    required BuildContext context,
    required String msg,
  }) async {

    ///防止多次弹出，外部设置间隔时间 默认2秒
    if(_startedTime!=null &&
        DateTime.now().difference(_startedTime!).inMilliseconds<_toastConfig.intervalTime){
      return;
    }

    _startedTime = DateTime.now();
    ///获取OverlayState
    OverlayState? overlayState = Overlay.of(context);
    _showing = true;

    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: _calToastPosition(context),
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: AnimatedOpacity(
                  opacity: _showing ? 1.0 : 0.0, //目标透明度
                  duration: _showing
                      ? const Duration(milliseconds: 100)
                      : const Duration(milliseconds: 400),
                  child: _toastConfig.buildToastWidget(context,msg),
                ),
              )),
        ));
    overlayState!.insert(_overlayEntry!);

    await Future.delayed(Duration(milliseconds: _toastConfig.showTime));

    ///移除浮层
    if (DateTime.now().difference(_startedTime!).inMilliseconds >= _toastConfig.showTime) {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
      await Future.delayed(const Duration(milliseconds: 400));
      _overlayEntry?.remove();
    }

  }

  ///设置toast位置
  static double _calToastPosition(context) {
    double backResult;
    ToastPosition position = _toastConfig.position;
    if (position == ToastPosition.top) {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (position == ToastPosition.center) {
      backResult = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }
}

