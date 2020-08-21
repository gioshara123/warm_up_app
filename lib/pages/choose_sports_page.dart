import 'package:flutter/material.dart';
import 'package:wvs_warm_up/services/ui_services.dart';
import 'package:wvs_warm_up/wigdets/rounded_rectangle_text_field.dart';

class ChooseSportsPage extends StatelessWidget {
  static const String ID = "./";
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));

    return Scaffold(
      body: Container(
        width: actualDeviceSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Container(
                width: actualDeviceSize.width * 1 / 2,
                height: actualDeviceSize.width * 1 / 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'images/wvs_warm_up_logo.png',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: actualDeviceSize.width * 1 / 8),
              child: RoundedRectangleTextField(
                hintText: 'suchen...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
