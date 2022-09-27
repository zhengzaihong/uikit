import 'package:flutter/material.dart';
import 'calendar_config.dart';
import 'calendar_popup_view.dart';


///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/12/2
/// create_time: 16:57
/// describe: 日历选择帮助类
///
class CalendarHelper{

  ///样式配置文件
  static final _calendarConfig = CalendarConfig();
  static CalendarConfig getConfig() => _calendarConfig;


  /// startDate 默认选中日历的开始日期
  /// endDate 默认选中日历的结束日期
  /// onClickOutSide 点击非日历区域是否关闭
  /// Function 选择日期后的回调
  /// aspectRatio 添加宽高比，设置的calendarHeight将失效。
  ///
  static void showDateDialog(BuildContext context,
      {
        DateTime? startDate,
        DateTime? endDate,
        bool onClickOutSide = false,
        Function(DateTime startTime,
        DateTime endTime)? callBack,
        Function()? closeCallBack,
        double? aspectRatio,
      }) {

    showDialog<dynamic>(
        context: context,
        builder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: GestureDetector(
              onTap: (){
                if(onClickOutSide){
                  Navigator.of(context).pop();
                }
              },
              behavior: HitTestBehavior.opaque,
              child:Center(child:
              aspectRatio==null?SizedBox(
                height: getConfig().calendarHeight,
                width: getConfig().calendarWidth,
                child: CalendarPopupView(
                  calendarConfig: getConfig(),
                  barrierDismissible: false,
                  minimumDate: getConfig().maximumDate,
                  maximumDate: getConfig().maximumDate,
                  initialEndDate: endDate,
                  initialStartDate: startDate,
                  onApplyClick: (DateTime startData, DateTime endData) {
                    if(null!=callBack){
                      callBack.call(startData,endData);
                    }
                  },
                  onCancelClick: () {
                    closeCallBack?.call();
                  },
                ),
              ):
               SizedBox(
                 width: getConfig().calendarWidth,
                 child: AspectRatio(
                   aspectRatio: aspectRatio,
                   child: CalendarPopupView(
                     calendarConfig: getConfig(),
                     barrierDismissible: false,
                     minimumDate: getConfig().maximumDate,
                     maximumDate: getConfig().maximumDate,
                     initialEndDate: endDate,
                     initialStartDate: startDate,
                     onApplyClick: (DateTime startData, DateTime endData) {
                       if(null!=callBack){
                         callBack.call(startData,endData);
                       }
                     },
                     onCancelClick: () {
                       closeCallBack?.call();
                     },
                   ),
                 ),
               )),
            ),
          );
        },
    );
  }


}