import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/pages/choose_sports_page.dart';
import 'package:wvs_warm_up/pages/warm_up_page.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => WvsWarmUpApp(),
      enabled: false,
    ),
  );
}

class WvsWarmUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale, // <--- /!\ Add the locale
      builder: DevicePreview.appBuilder, // <--- /!\ Add the builder
      routes: {
        ChooseSportsPage.ID : (context)=>ChooseSportsPage(),
        WarmUpPage.ID : (context)=>WarmUpPage(),
      },
      initialRoute: ChooseSportsPage.ID,
      theme: ThemeData(
        primaryColor: cPRIMARY_COLOR,
        scaffoldBackgroundColor: cBLACK,
      ),
    );
  }
}
