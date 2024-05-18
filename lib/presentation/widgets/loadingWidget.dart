//loading widget
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingWidget({Color color = Colors.black, double size = 35}) {
  return Center(child: SpinKitFadingCircle(color: color, size: size));
}