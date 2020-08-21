import 'package:flutter/material.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/services/ui_services.dart';

class RoundedRectangleTextField extends StatelessWidget {
  final String hintText;

  const RoundedRectangleTextField({Key key, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final TextStyle textFieldStyle =
        TextStyle(fontSize: actualDeviceSize.width * 1 / 20, color: cWHITE);
    return TextField(
      style: textFieldStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textFieldStyle,
        filled: true,
        fillColor: cSECONDARY_COLOR,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
