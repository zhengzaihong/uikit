import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/18
/// create_time: 20:44
/// describe: 城市picker
///
///
class PickerHelper {
  /// 显示通用城市选择器
  static Future<CityResult?> showPicker(
      BuildContext context, {
        List<dynamic>? data,
        PickerStyle? style,
        PickerResultCallback? onResult,
      }) {
    return showModalBottomSheet<CityResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return GeneralPickerView(
          data: data,
          style: style,
          onResult: onResult,
        );
      },
    );
  }
}

/// 回调
typedef PickerResultCallback = void Function(CityResult result);

/// 样式配置
class PickerStyle {
  final TextStyle? itemTextStyle;
  final double? itemHeight;
  final double? pickerHeight;
  final Widget? confirmWidget;
  final Widget? cancelWidget;
  final Color? backgroundColor;
  final BoxDecoration? buttonBarDecoration;

  const PickerStyle({
    this.itemTextStyle,
    this.itemHeight,
    this.pickerHeight,
    this.confirmWidget,
    this.cancelWidget,
    this.backgroundColor,
    this.buttonBarDecoration,
  });
}

/// 通用选择器视图
class GeneralPickerView extends StatefulWidget {
  final List<dynamic>? data;
  final PickerStyle? style;
  final PickerResultCallback? onResult;

  const GeneralPickerView({super.key, this.data, this.style, this.onResult});

  @override
  State<GeneralPickerView> createState() => _GeneralPickerViewState();
}

class _GeneralPickerViewState extends State<GeneralPickerView> {
  List<dynamic> data = [];
  int provinceIndex = 0;
  int cityIndex = 0;
  int areaIndex = 0;

  FixedExtentScrollController? provinceController;
  FixedExtentScrollController? cityController;
  FixedExtentScrollController? areaController;

  CityResult result = CityResult();

  @override
  void initState() {
    super.initState();
    provinceController = FixedExtentScrollController();
    cityController = FixedExtentScrollController();
    areaController = FixedExtentScrollController();

    if (widget.data != null) {
      data = widget.data!;
    } else {
      _loadCityData();
    }
    _updateResult();
  }

  Future<void> _loadCityData() async {
    String jsonStr = await rootBundle.loadString('packages/uikit/assets/cityList.json');
    data = List<Map<String, dynamic>>.from(json.decode(jsonStr));
    setState(() {});
    _updateResult();
  }

  void _updateResult() {
    if (data.isEmpty) return;
    result.province = data[provinceIndex]['label'] ?? '';
    result.provinceCode = data[provinceIndex]['value']?.toString() ?? '';

    var cities = data[provinceIndex]['children'] ?? [];
    if (cities.isNotEmpty) {
      cityIndex = cityIndex >= cities.length ? 0 : cityIndex;
      result.city = cities[cityIndex]['label'] ?? '';
      result.cityCode = cities[cityIndex]['value']?.toString() ?? '';

      var areas = cities[cityIndex]['children'] ?? [];
      if (areas.isNotEmpty) {
        areaIndex = areaIndex >= areas.length ? 0 : areaIndex;
        result.area = areas[areaIndex]['label'] ?? '';
        result.areaCode = areas[areaIndex]['value']?.toString() ?? '';
      } else {
        result.area = '';
        result.areaCode = '';
      }
    } else {
      result.city = '';
      result.cityCode = '';
      result.area = '';
      result.areaCode = '';
    }
    setState(() {});
  }

  @override
  void dispose() {
    provinceController?.dispose();
    cityController?.dispose();
    areaController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? const PickerStyle();
    return Material(
      color: style.backgroundColor ?? Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButtonBar(style),
          SizedBox(
            height: style.pickerHeight ?? 200,
            child: Row(
              children: [
                _buildPicker(data, provinceController, (index) {
                  provinceIndex = index;
                  cityIndex = 0;
                  areaIndex = 0;
                  _updateResult();
                }),
                _buildPicker(data[provinceIndex]['children'] ?? [], cityController, (index) {
                  cityIndex = index;
                  areaIndex = 0;
                  _updateResult();
                }),
                _buildPicker(
                    (data[provinceIndex]['children']?[cityIndex]?['children'] ?? []), areaController,
                        (index) {
                      areaIndex = index;
                      _updateResult();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBar(PickerStyle style) {
    return Container(
      height: 44,
      decoration: style.buttonBarDecoration ??
          const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          style.cancelWidget == null?TextButton(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context),
          ):GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: style.cancelWidget,
          ),
          style.confirmWidget == null?TextButton(
            child:const Text('确定'),
            onPressed: () {
              widget.onResult?.call(result);
              Navigator.pop(context, result);
            },
          ):GestureDetector(
            onTap: (){
              widget.onResult?.call(result);
              Navigator.pop(context, result);
            },
            child: style.confirmWidget,
          ),
        ],
      ),
    );
  }

  Widget _buildPicker(List items, FixedExtentScrollController? controller, Function(int) onChange) {
    if (items.isEmpty) return const SizedBox.shrink();
    final style = widget.style;
    return Expanded(
      child: CupertinoPicker(
        scrollController: controller,
        itemExtent: style?.itemHeight ?? 36,
        children: items.map<Widget>((e) {
          return Center(
            child: Text(e['label'] ?? '', style: style?.itemTextStyle ?? const TextStyle(fontSize: 16)),
          );
        }).toList(),
        onSelectedItemChanged: onChange,
      ),
    );
  }
}

class CityResult {
  /// 省市区
  String? province = '';
  String? city = '';
  String? area = '';

  /// 对应的编码
  String? provinceCode = '';
  String? cityCode = '';
  String? areaCode = '';

  CityResult({
    this.province,
    this.city,
    this.area,
    this.provinceCode,
    this.cityCode,
    this.areaCode,
  });

  CityResult.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    city = json['city'];
    area = json['area'];
    provinceCode = json['provinceCode'];
    cityCode = json['cityCode'];
    areaCode = json['areaCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province'] = province;
    data['city'] = city;
    data['area'] = area;
    data['provinceCode'] = provinceCode;
    data['cityCode'] = cityCode;
    data['areaCode'] = areaCode;

    return data;
  }

  @override
  String toString() {
    return 'CityResult{province: $province, city: $city, area: $area, provinceCode: $provinceCode, cityCode: $cityCode, areaCode: $areaCode}';
  }
}
