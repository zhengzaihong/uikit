import 'package:flutter/material.dart';

//一些通用的组件
SizedBox vGap(double size){
  return SizedBox(height: size,);
}

SizedBox hGap(double size){
  return SizedBox(width: size,);
}


Widget hLine(
    {Color color = Colors.black,
    double height = 1,
    double width = double.infinity,  
    EdgeInsetsGeometry? margin}) {
  return Container(
    margin: margin,
    height: height,
    width: width,
    color: color,
  );
}

Widget vLine(
    {Color color = Colors.black,
    double width = 1,
    double height = double.infinity,  
    EdgeInsetsGeometry? margin}) {
  return Container(
    margin: margin,
    height: height,
    width: width,
    color: color,
  );
}