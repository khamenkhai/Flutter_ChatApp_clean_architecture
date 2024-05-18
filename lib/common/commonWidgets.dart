import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



loadingWidget({Color color = Colors.white,double size = 50}){
  return Center(
    child: SpinKitFadingCircle(
    color: color,
    size: size,
    ),
  );
}