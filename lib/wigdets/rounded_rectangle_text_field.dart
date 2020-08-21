import 'package:flutter/material.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/services/ui_services.dart';

class RoundedRectangleTextField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final Widget suffixIcon;

  const RoundedRectangleTextField(
      {Key key,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.suffixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final TextStyle textFieldStyle =
        TextStyle(fontSize: actualDeviceSize.width * 1 / 20, color: cWHITE);
    final TextStyle textFieldHintStyle = TextStyle(
        fontSize: actualDeviceSize.width * 1 / 20,
        color: cWHITE.withOpacity(0.6));

    return TextField(
      controller: controller,
      style: textFieldStyle,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: textFieldHintStyle,
        filled: true,
        fillColor: cSECONDARY_COLOR,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
