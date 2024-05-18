import 'package:flutter/material.dart';

void redirectTo({required Widget page, required BuildContext context, bool? replacement}) {
  if(replacement != null && replacement == false){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }else{
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

void showMessage({required GlobalKey<ScaffoldState> scaffoldKey,required String title}){
    final snackBar = SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 10),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
         ScaffoldMessenger.of(scaffoldKey.currentContext!).hideCurrentSnackBar();
      },
    ),
  );
  if (scaffoldKey.currentContext != null) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(snackBar);
  }
}
