import 'package:flutter/material.dart';
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
        leading: const BackButton(),
        title: const Text("城市选择器"),
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('不传入 data 时自动加载组件内置城市数据'),
        ),
        FilledButton.tonal(
            onPressed: () {
              PickerHelper.showPicker(context,
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
