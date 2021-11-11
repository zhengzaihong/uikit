import 'package:flutter/material.dart';

import 'datamode.dart';
import 'form_model.dart';

class ViewHelper {

 static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static GlobalKey<FormState> getGloblkey(){
    return _formKey;
  }

  static final List<DataMode> _dataModes = [];

  static List<DataMode> getDataModes(){
    return _dataModes;
  }

  static void validate({Function(List<DataMode> datas,bool status)? callBack}){
    bool hasError = true;
    if( _formKey.currentState?.validate()??false){
      hasError = true;
      callBack?.call(getDataModes(),hasError);
    }else{
      hasError=false;
      callBack?.call(getDataModes(),hasError);
    }
  }

  static void clear(){
    getDataModes().forEach((element) {
      element.clear();
    });
  }

}
