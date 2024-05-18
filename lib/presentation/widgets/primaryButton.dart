import 'package:flutter/material.dart';
import 'package:message_app/presentation/widgets/loadingWidget.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.loading = false,
      this.width = double.infinity,
      this.height = 50,
      this.mt = 0,
      this.mb = 0,
      this.ml = 20,
      this.mr = 20,
      this.borderRadius = 8,
      this.textColor = Colors.white});

  final String text;
  final Function() onTap;
  final double width, height;
  final double mt, mr, ml, mb;
  final bool loading;
  final double borderRadius;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: mr, left: ml, top: mt, bottom: mb),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        child: loading
            ? loadingWidget(color: Colors.white)
            : Text(
                text,
                style: TextStyle(color: textColor),
              ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }
}
