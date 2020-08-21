import 'package:flutter/cupertino.dart';
import 'package:wvs_warm_up/enums/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData){
  var orientation = mediaQueryData.orientation;
  double deviceWidth = 0;

  if(orientation == Orientation.landscape){
    deviceWidth = mediaQueryData.size.height;
  }else {
    deviceWidth = mediaQueryData.size.width;
  }

  //setting breakpoints...

  if(deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  if(deviceWidth > 600) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}

Size getActualDeviceSize(MediaQueryData mediaQueryData) {
  Size actualDeviceSize  = Size(0,0);
  if(mediaQueryData.orientation == Orientation.landscape) {
    actualDeviceSize = Size(mediaQueryData.size.height, mediaQueryData.size.width);
  }else {
    actualDeviceSize = Size(mediaQueryData.size.width, mediaQueryData.size.height);
  }
  return actualDeviceSize;
}