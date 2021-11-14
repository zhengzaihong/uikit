import 'package:flutter/material.dart';

class DataMode{
  dynamic tag;
  String value;
  TextEditingController? controller;

  DataMode(this.tag,this.value,{this.controller}){
    if(null != controller){
      controller!.addListener(() {
        value = controller!.value.text;
      });
    }

  }


  void clear(){
    controller?.clear();
  }

  @override
  String toString() {
    return 'DataMode{tag: $tag, value: $value}';
  }
}