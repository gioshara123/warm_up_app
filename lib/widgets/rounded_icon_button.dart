import 'package:flutter/material.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/services/ui_services.dart';

class RoundedIconButton extends StatelessWidget {
  final Widget icon;
  final Function onPressed;

  const RoundedIconButton({Key key,@required this.icon,@required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize =getActualDeviceSize(MediaQuery.of(context));

    return RawMaterialButton(
      padding: EdgeInsets.symmetric(vertical: actualDeviceSize.height * 1/50),
      onPressed: onPressed,
      child: icon,
      splashColor: cWHITE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0,),
        side: BorderSide(color: cSECONDARY_COLOR),
      ),
    );
  }
}
