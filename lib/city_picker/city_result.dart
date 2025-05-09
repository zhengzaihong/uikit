/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-21
/// create_time: 12:34
/// describe:
///
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
    final Map<String, dynamic> datas = <String, dynamic>{};
    datas['province'] = province;
    datas['city'] = city;
    datas['area'] = area;
    datas['provinceCode'] = provinceCode;
    datas['cityCode'] = cityCode;
    datas['areaCode'] = areaCode;

    return datas;
  }

  @override
  String toString() {
    return 'CityResult{province: $province, city: $city, area: $area, provinceCode: $provinceCode, cityCode: $cityCode, areaCode: $areaCode}';
  }
}
