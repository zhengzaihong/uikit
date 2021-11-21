import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit/city_picker/city_result.dart';
import 'package:uikit/city_picker/picker_helper.dart';

class CityPickerExample extends StatelessWidget {
  const CityPickerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
              padding: const EdgeInsets.all(30),
              child: const Text("城市选择"),
            ))
      ]),
    ));
  }
}
