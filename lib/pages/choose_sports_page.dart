import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/models/device_information.dart';
import 'package:wvs_warm_up/models/sport.dart';
import 'package:wvs_warm_up/page_arguments/warm_up_page_arguments.dart';
import 'package:wvs_warm_up/pages/warm_up_page.dart';
import 'package:wvs_warm_up/providers/choose_sports_provider.dart';
import 'package:wvs_warm_up/services/ui_services.dart';
import 'package:wvs_warm_up/widgets/no_glow_behaviour.dart';
import 'package:wvs_warm_up/widgets/responsive_widget.dart';
import 'package:wvs_warm_up/widgets/rounded_rectangle_text_field.dart';
import '../const_exercise_information.dart';

class ChooseSportsPage extends StatelessWidget {
  static const String ID = "./";

  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final TextStyle _sportNameStyle =
        TextStyle(fontSize: actualDeviceSize.width * 1 / 18);

    return ChangeNotifierProvider<ChooseSportsProvider>(
      create: (BuildContext context) => ChooseSportsProvider(),
      child: Consumer<ChooseSportsProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: actualDeviceSize.height,
              child: Column(
                children: <Widget>[
                  _wvsWarmUpLogoBuilder(actualDeviceSize),
                  SizedBox(
                    height: 5.0,
                  ),
                  _textFieldBuilder(provider, actualDeviceSize),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: provider.currentSportsList.isEmpty
                        ? Center(
                            child: Text(
                              'KEIN ERGEBNIS!',
                              style: TextStyle(
                                  fontSize: cH1(actualDeviceSize.width),
                                  color: cWHITE,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: GridView.builder(
                              itemCount: provider.currentSportsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 1,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (context, index) {
                                final Sport sport =
                                    provider.currentSportsList[index];
                                final Function onSportCardPressed = () async {
                                  provider.resetCurrentSportsList();
                                  provider.textEditingController.clear();
                                  FocusScope.of(context).unfocus();
                                  Navigator.pushNamed(
                                      context, AnimatedWarmUpPageWidget.ID,
                                      arguments:
                                          WarmUpPageArguments(sport: sport));
                                };

                                if (index % 2 == 0) {
                                  return InkWell(
                                      onTap: onSportCardPressed,
                                      child: _sportCardIconTextBuilder(sport,
                                          _sportNameStyle, actualDeviceSize));
                                }
                                return InkWell(
                                    onTap: onSportCardPressed,
                                    child: _sportCardTextIconBuilder(sport,
                                        _sportNameStyle, actualDeviceSize));
                              },
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _wvsWarmUpLogoBuilder(Size actualDeviceSize) {
    return SafeArea(
      child: Container(
        width: actualDeviceSize.width * 1 / 2.5,
        height: actualDeviceSize.width * 1 / 2.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
              'images/wvs_warm_up_logo.png',
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldBuilder(
      ChooseSportsProvider provider, Size actualDeviceSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: actualDeviceSize.width * 1 / 8),
      child: RoundedRectangleTextField(
        controller: provider.textEditingController,
        onChanged: (String newText) => provider.textFieldOnChange(newText),
        suffixIcon: provider.textEditingController.text.isEmpty
            ? null
            : InkWell(
                onTap: () => provider.onClearButtonPressed(),
                child: Icon(
                  Icons.close,
                  color: cWHITE,
                  size: actualDeviceSize.width * 1 / 15,
                ),
              ),
        hintText: 'suchen...',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Icon(
            Icons.search,
            color: cWHITE,
            size: actualDeviceSize.width * 1 / 15,
          ),
        ),
      ),
    );
  }

  Widget _sportCardIconTextBuilder(
      Sport sport, TextStyle sportNameStyle, Size actualDeviceSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: cWHITE,
      ),
      child: ResponsiveWidget(
          uiBuilder: (context, DeviceInformation deviceInformation) {
        return Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5.0),
              width: actualDeviceSize.width * 1 / 6,
              height: actualDeviceSize.width * 1 / 6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('${sport.imageLocalPath}'),
              )),
            ),
            SizedBox(
              width: 2.0,
            ),
            Container(
              width: deviceInformation.localWidgetSize.width / 2,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${sport.name}',
                  textAlign: TextAlign.center,
                  style: sportNameStyle,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _sportCardTextIconBuilder(
      Sport sport, TextStyle sportNameStyle, Size actualDeviceSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: cWHITE,
      ),
      child: ResponsiveWidget(
          uiBuilder: (context, DeviceInformation deviceInformation) {
        return Row(
          children: <Widget>[
            SizedBox(
              width: 2.0,
            ),
            Container(
              width: deviceInformation.localWidgetSize.width / 2,
              child: FittedBox(
                child: Text(
                  '${sport.name}',
                  textAlign: TextAlign.center,
                  style: sportNameStyle,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              width: actualDeviceSize.width * 1 / 6,
              height: actualDeviceSize.width * 1 / 6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('${sport.imageLocalPath}'),
              )),
            ),
          ],
        );
      }),
    );
  }
}
