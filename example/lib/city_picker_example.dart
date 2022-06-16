import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uikit_forzzh/city_picker/city_result.dart';
import 'package:flutter_uikit_forzzh/city_picker/picker_helper.dart';

class CityPickerExample extends StatelessWidget {
  const CityPickerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("城市选择器"),
      ),
      body: Column(children: [
        InkWell(
            onTap: () async {
              var cityStr = await rootBundle.loadString('assets/city.json');
              List datas = json.decode(cityStr) as List;
              CityResult res =
              // await PickerHelper.showPicker(context);
              await PickerHelper.showPicker(context, datas: datas);
              print("--${res.provinceCode}-----${res.cityCode}----" +
                  "${res.areaCode}");
            },
            child: Container(
              color: Colors.blueGrey,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: const Text("城市选择"),
            )),


        InkWell(
            onTap: () async {

              await PickerHelper.showPicker(context,
                  textStyle:
                  const TextStyle(color: Colors.lightBlue, fontSize: 12),
                  topMenueStyle: (onResult,pickerViewState){
                    return Container(
                      height: 44,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            TextButton(
                              child: const Text('cancle',style: TextStyle(color: Colors.grey)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),

                            TextButton(
                              child: const Text('sure',style: TextStyle(color: Colors.lightBlue)),
                              onPressed: () {
                                onResult(pickerViewState.result);
                                Navigator.pop(context);
                              },
                            ),

                          ]),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),
                      ),
                    );

                  }).then((value){
                print("----------------------${value.toString()}");
              });
            },
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: const Text("自定义样式城市选择"),
            ))
      ]),
    );
  }
}
