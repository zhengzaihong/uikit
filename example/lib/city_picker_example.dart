import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit_plus/uikit_lib.dart';

class CityPickerExample extends StatefulWidget {

  const CityPickerExample({Key? key}) : super(key: key);

  @override
  State<CityPickerExample> createState() => _CityPickerExampleState();
}

class _CityPickerExampleState extends State<CityPickerExample> {

  var location = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            RouteUtils.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.red,),
        ),
        title: const Text("城市选择器"),
      ),
      body: Column(children: [
        FilledButton.tonal(
            onPressed: () async {
              var cityStr = await rootBundle.loadString('assets/city.json');
              PickerHelper.showPicker(context,
                  data: json.decode(cityStr),
                onResult: (res){
                    StringBuffer buffer = StringBuffer("名称：${res.province}-${res.city}-${res.area}");
                    buffer.write("\n");
                    buffer.write("编码：${res.provinceCode}-${res.cityCode}-${res.areaCode}");
                    setState(() {
                      location = buffer.toString();
                    });
                }
              );
            },
            child: const Text("城市选择")),
        vGap(20),
        FilledButton.tonal(
            onPressed: () async {

              // await PickerHelper.showPicker(context,
              //     textStyle:
              //     const TextStyle(color: Colors.lightBlue, fontSize: 12),
              //     topMenuStyle: (onResult,pickerViewState){
              //       return Container(
              //         height: 44,
              //         child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //
              //               TextButton(
              //                 child: const Text('cancel',style: TextStyle(color: Colors.grey)),
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //
              //               TextButton(
              //                 child: const Text('sure',style: TextStyle(color: Colors.lightBlue)),
              //                 onPressed: () {
              //                   onResult(pickerViewState.result);
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //
              //             ]),
              //         decoration: BoxDecoration(
              //           border: Border(
              //               bottom: BorderSide(color: Colors.grey.setAlpha(0.1), width: 1)),
              //         ),
              //       );
              //
              //     }).then((value){
              //   debugPrint("----------------------${value.toString()}");
              // });
            },
            child: const Text("自定义样式城市选择")),


        Text(location)
      ]),
    );
  }
}
