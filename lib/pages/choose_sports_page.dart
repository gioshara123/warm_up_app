import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/providers/choose_sports_provider.dart';
import 'package:wvs_warm_up/services/ui_services.dart';
import 'package:wvs_warm_up/wigdets/rounded_rectangle_text_field.dart';

class ChooseSportsPage extends StatelessWidget {
  static const String ID = "./";
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));

    return ChangeNotifierProvider<ChooseSportsProvider>(
      create: (BuildContext context) => ChooseSportsProvider(),
      child: Consumer<ChooseSportsProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                    controller: provider.textEditingController,
                    suffixIcon: provider.textEditingController.text.isEmpty
                        ? null
                        : InkWell(
                            onTap: () =>
                                provider.textEditingController.text = '',
                            child: Icon(Icons.close),
                          ),
                    hintText: 'suchen...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: cWHITE,
                        size: actualDeviceSize.width * 1 / 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
