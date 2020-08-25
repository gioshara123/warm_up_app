import 'package:flutter/material.dart';
import 'package:wvs_warm_up/models/device_information.dart';
import 'package:wvs_warm_up/services/ui_services.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, DeviceInformation deviceInformation) uiBuilder;

  const ResponsiveWidget({Key key, @required this.uiBuilder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxConstraints) {
      final DeviceInformation deviceInformation = DeviceInformation(
        orientation: mediaQueryData.orientation,
        deviceScreenType: getDeviceType(mediaQueryData),
        screenSize: mediaQueryData.size,
        localWidgetSize:
            Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return uiBuilder(context, deviceInformation);
    });
  }
}
