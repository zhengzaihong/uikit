import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'city_result.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/11/18
/// create_time: 20:44
/// describe: 城市picker
///

///选择后的回调
typedef ResultBlock = void Function(CityResult result);

///自定义顶部按钮的样式，确定和取消
typedef TopMenueStyle = Widget Function(
    ResultBlock block, _CityPickerViewState pickerViewState);

class CityPickerView extends StatefulWidget {
  /// json数据可以从外部传入，如果外部有值，取外部值
  final List? params;

  /// 结果返回
  final ResultBlock? onResult;
  final TopMenueStyle? topMenueStyle;
  final TextStyle? listTextStyle;
  final double listHeight;

  final Widget sureWidget;
  final Widget cancleWidget;

  final double buttonBarHeight;
  final BoxDecoration buttonBarBoxdec;

  const CityPickerView({
    key,
    this.onResult,
    this.params,
    this.topMenueStyle,
    this.buttonBarHeight = 44,
    this.listHeight = 200,
    this.buttonBarBoxdec =  const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
    this.listTextStyle = const TextStyle(color: Colors.black87, fontSize: 16),
    this.sureWidget = const Text(
      '确定',
    ),
    this.cancleWidget = const Text(
      '取消',
    ),
  }) : super(key: key);

  @override
  _CityPickerViewState createState() => _CityPickerViewState();
}

class _CityPickerViewState extends State<CityPickerView> {
  List datas = [];
  int? provinceIndex;
  int? cityIndex;
  int? areaIndex;

  FixedExtentScrollController? provinceScrollController;
  FixedExtentScrollController? cityScrollController;
  FixedExtentScrollController? areaScrollController;

  CityResult result = CityResult();

  bool isShow = false;

  List get provinces {
    if (datas.isNotEmpty) {
      if (provinceIndex == null) {
        provinceIndex = 0;
        result.province = provinces[provinceIndex!]['label'];
        result.provinceCode = provinces[provinceIndex!]['value'].toString();
      }
      return datas;
    }
    return [];
  }

  List get citys {
    if (provinces.isNotEmpty) {
      return provinces[provinceIndex!]['children'] ?? [];
    }
    return [];
  }

  List get areas {
    if (citys.isNotEmpty) {
      if (cityIndex == null) {
        cityIndex = 0;
        result.city = citys[cityIndex!]['label'];
        result.cityCode = citys[cityIndex!]['value'].toString();
      }
      List list = citys[cityIndex!]['children'] ?? [];
      if (list.isNotEmpty) {
        if (areaIndex == null) {
          areaIndex = 0;
          result.area = list[areaIndex!]['label'];
          result.areaCode = list[areaIndex!]['value'].toString();
        }
      }
      return list;
    }
    return [];
  }

  /// 保存选择结果
  _saveInfoData() {
    var prs = provinces;
    var cts = citys;
    var ars = areas;
    if (provinceIndex != null && prs.isNotEmpty) {
      result.province = prs[provinceIndex!]['label'];
      result.provinceCode = prs[provinceIndex!]['value'].toString();
    } else {
      result.province = '';
      result.provinceCode = '';
    }

    if (cityIndex != null && cts.isNotEmpty) {
      result.city = cts[cityIndex!]['label'];
      result.cityCode = cts[cityIndex!]['value'].toString();
    } else {
      result.city = '';
      result.cityCode = '';
    }

    if (areaIndex != null && ars.isNotEmpty) {
      result.area = ars[areaIndex!]['label'];
      result.areaCode = ars[areaIndex!]['value'].toString();
    } else {
      result.area = '';
      result.areaCode = '';
    }
  }

  @override
  void dispose() {
    provinceScrollController?.dispose();
    cityScrollController?.dispose();
    areaScrollController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    provinceScrollController = FixedExtentScrollController();
    cityScrollController = FixedExtentScrollController();
    areaScrollController = FixedExtentScrollController();

    ///读取city.json数据
    if (widget.params == null) {
      _loadCitys().then((value) {
        setState(() {
          isShow = true;
        });
      });
    } else {
      datas = widget.params!;
      assert(datas.isNotEmpty);
      setState(() {
        isShow = true;
      });
    }
  }

  Future _loadCitys() async {
    var cityStr =
        await rootBundle.loadString('packages/uikit/assets/citys.json');
    datas = json.decode(cityStr) as List;
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.topMenueStyle == null
              ? _firstView()
              : widget.topMenueStyle!.call(widget.onResult!, this),
          _contentView(),
        ],
      ),
    );
  }

  Widget _firstView() {
    return Container(
      height: widget.buttonBarHeight,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              child: widget.cancleWidget,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: widget.sureWidget,
              onPressed: () {
                if (widget.onResult != null) {
                  widget.onResult!(result);
                }
                Navigator.pop(context);
              },
            ),
          ]),
      decoration: widget.buttonBarBoxdec,
    );
  }

  Widget _contentView() {
    return SizedBox(
      height: widget.listHeight,
      child: isShow
          ? Row(
              children: <Widget>[
                Expanded(child: _provincePickerView()),
                Expanded(child: _cityPickerView()),
                Expanded(child: _areaPickerView()),
              ],
            )
          : const Center(
              child: CupertinoActivityIndicator(
                animating: true,
              ),
            ),
    );
  }

  Widget _provincePickerView() {
    return CupertinoPicker(
      scrollController: provinceScrollController,
      children: provinces.map((item) {
        return Center(
          child: Text(
            item['label'],
            style: widget.listTextStyle,
            maxLines: 1,
          ),
        );
      }).toList(),
      onSelectedItemChanged: (index) {
        provinceIndex = index;
        if (cityIndex != null) {
          cityIndex = 0;
          if (cityScrollController!.positions.isNotEmpty) {
            cityScrollController?.jumpTo(0);
          }
        }
        if (areaIndex != null) {
          areaIndex = 0;
          if (areaScrollController!.positions.isNotEmpty) {
            areaScrollController!.jumpTo(0);
          }
        }
        _saveInfoData();
        setState(() {});
      },
      itemExtent: 36,
    );
  }

  Widget _cityPickerView() {
    return Container(
      child: citys.isEmpty
          ? Container()
          : CupertinoPicker(
              scrollController: cityScrollController,
              children: citys.map((item) {
                return Center(
                  child: Text(
                    item['label'],
                    style: widget.listTextStyle,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onSelectedItemChanged: (index) {
                cityIndex = index;
                if (areaIndex != null) {
                  areaIndex = 0;
                  if (areaScrollController!.positions.isNotEmpty) {
                    areaScrollController!.jumpTo(0);
                  }
                }
                _saveInfoData();
                setState(() {});
              },
              itemExtent: 36,
            ),
    );
  }

  Widget _areaPickerView() {
    return SizedBox(
      width: double.infinity,
      child: areas.isEmpty
          ? Container()
          : CupertinoPicker(
              scrollController: areaScrollController,
              children: areas.map((item) {
                return Center(
                  child: Text(
                    item['label'],
                    style: widget.listTextStyle,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onSelectedItemChanged: (index) {
                areaIndex = index;
                _saveInfoData();
                setState(() {});
              },
              itemExtent: 36,
            ),
    );
  }
}
