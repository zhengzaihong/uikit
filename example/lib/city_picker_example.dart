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
                  // data: json.decode(cityStr),
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
        Text(location)
      ]),
    );
  }
}
