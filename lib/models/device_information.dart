import 'package:flutter/cupertino.dart';
import 'package:wvs_warm_up/enums/device_screen_type.dart';

class DeviceInformation {
  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;


  DeviceInformation({this.orientation, this.deviceScreenType, this.screenSize, this.localWidgetSize});

  @override
  String toString() {
    return 'DeviceInformation{orientation: $orientation, deviceScreenType: $deviceScreenType, screenSize: $screenSize, localWidgetSize: $localWidgetSize}';
  }
}