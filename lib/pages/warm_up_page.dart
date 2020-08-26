import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/enums/warm_up_mode.dart';
import 'package:wvs_warm_up/models/exercise.dart';
import 'package:wvs_warm_up/models/exercises.dart';
import 'package:wvs_warm_up/page_arguments/warm_up_page_arguments.dart';
import 'package:wvs_warm_up/providers/warm_up_provider.dart';
import 'package:wvs_warm_up/services/sounds_services.dart';
import 'package:wvs_warm_up/services/ui_services.dart';
import 'package:wvs_warm_up/tabs/warm_up_tab.dart';
import 'package:wvs_warm_up/widgets/rounded_icon_button.dart';

class WarmUpPage extends StatelessWidget {
  final TickerProviderStateMixin tickerProviderStateMixin;

  const WarmUpPage({Key key, this.tickerProviderStateMixin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final WarmUpPageArguments warmUpPageArguments =
        ModalRoute.of(context).settings.arguments;
    final String sportName = warmUpPageArguments.sport.name;
    final Exercises exercises = warmUpPageArguments.sport.exercise;
    final TextStyle primaryTextStyle = TextStyle(
        color: cWHITE,
        fontSize: cH1(
          actualDeviceSize.width,
        ),
        letterSpacing: 10.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline);

    final TextStyle timerValueTextStyle = TextStyle(
      fontSize: cH1(actualDeviceSize.width),
      color: cWHITE,
    );
    return ChangeNotifierProvider<WarmUpProvider>(
      create: (BuildContext context) => WarmUpProvider(
          tickerProviderStateMixin: tickerProviderStateMixin,
          exercises: exercises,
          context: context),
      child: Consumer<WarmUpProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${provider.timerValue}',
                        style: timerValueTextStyle,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: cSECONDARY_COLOR,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: actualDeviceSize.width * 1 / 15),
                        child: FittedBox(
                          child: Text(
                            '$sportName'.toUpperCase(),
                            style: primaryTextStyle,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(
                          right: actualDeviceSize.width * 1 / 30),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: cWHITE,
                        size: actualDeviceSize.width * 1 / 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: Container(
                  child: PageView.builder(
                    controller: provider.pageController,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: exercises.exerciseLength,
                    onPageChanged: (int index) => provider.onPageChanged(index),
                    itemBuilder: (context, index) {
                      final Exercise exercise =
                          Exercise.fromExercises(exercises, index);
                      return WarmUpTab(
                        exercise: exercise,
                        exerciseLength: exercises.exerciseLength,
                        provider: provider,
                      );
                    },
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: <Widget>[
                  for (int i = 0; i < exercises.exerciseLength; i++)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _pageViewNumberBuilder(i, provider,
                            exercises.exerciseLength, actualDeviceSize),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: actualDeviceSize.width * 1 / 70,
                              vertical: 0),
                          width: provider.warmUpPageCurrentIndex == i
                              ? actualDeviceSize.width * 1 / 8
                              : actualDeviceSize.width * 1 / 29,
                          height: provider.warmUpPageCurrentIndex == i
                              ? actualDeviceSize.width * 1 / 27
                              : actualDeviceSize.width * 1 / 27,
                          decoration: BoxDecoration(
                            shape: provider.warmUpPageCurrentIndex == i
                                ? BoxShape.rectangle
                                : BoxShape.circle,
                            color: provider.warmUpPageCurrentIndex == i
                                ? cSECONDARY_COLOR
                                : cSECONDARY_COLOR.withOpacity(0.5),
                            borderRadius: provider.warmUpPageCurrentIndex == i
                                ? BorderRadius.circular(5.0)
                                : null,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RoundedIconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: cSECONDARY_COLOR,
                            size: actualDeviceSize.width * 1 / 15,
                          ),
                          onPressed: () => provider.onPreviousExerciseChange(),
                        ),
                      ),
                      SizedBox(
                        width: actualDeviceSize.width * 1 / 30,
                      ),
                      provider.currentWarmUpMode == WarmUpMode.withTime
                          ? Expanded(
                              child: RoundedIconButton(
                                icon: Icon(
                                  provider.timerSubscription == null ||
                                          provider.timerSubscription.isPaused
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: cSECONDARY_COLOR,
                                  size: actualDeviceSize.width * 1 / 15,
                                ),
                                onPressed: provider.timerSubscription == null ||
                                        provider.timerSubscription.isPaused
                                    ? () => provider.onTimerRun()
                                    : () => provider.onTimerPause(),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        width: actualDeviceSize.width * 1 / 30,
                      ),
                      Expanded(
                        child: RoundedIconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: cSECONDARY_COLOR,
                            size: actualDeviceSize.width * 1 / 15,
                          ),
                          onPressed: () => provider.onNextExerciseChange(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _pageViewNumberBuilder(int pageIndex, WarmUpProvider provider,
      int exercisesLength, Size actualDeviceSize) {
    final TextStyle startAndEndPageIndexStyle = TextStyle(
        color: cSECONDARY_COLOR, fontSize: actualDeviceSize.width * 1 / 24);
    final TextStyle pageIndexStyle =
        TextStyle(color: cWHITE, fontSize: actualDeviceSize.width * 1 / 24);

    if (pageIndex == 0 || pageIndex + 1 == exercisesLength) {
      return Text(
        '${pageIndex + 1}',
        style: startAndEndPageIndexStyle,
      );
    }
    if (pageIndex == provider.warmUpPageCurrentIndex) {
      return Text(
        '${pageIndex + 1}/$exercisesLength',
        style: pageIndexStyle,
      );
    }

    return Text(
      '',
      style: pageIndexStyle,
    );
  }
}

class AnimatedWarmUpPageWidget extends StatefulWidget {
  static const String ID = './AnimatedWarmUpPageWidget';
  @override
  _AnimatedWarmUpPageWidgetState createState() =>
      _AnimatedWarmUpPageWidgetState();
}

class _AnimatedWarmUpPageWidgetState extends State<AnimatedWarmUpPageWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WarmUpPage(
      tickerProviderStateMixin: this,
    );
  }
}
