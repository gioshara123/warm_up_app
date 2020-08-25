import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wvs_warm_up/const.dart';
import 'package:wvs_warm_up/models/exercise.dart';
import 'package:wvs_warm_up/models/exercises.dart';
import 'package:wvs_warm_up/page_arguments/warm_up_page_arguments.dart';
import 'package:wvs_warm_up/providers/warm_up_provider.dart';
import 'package:wvs_warm_up/services/ui_services.dart';

class WarmUpPage extends StatelessWidget {
  final TickerProviderStateMixin tickerProviderStateMixin;

  const WarmUpPage({Key key, this.tickerProviderStateMixin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(tickerProviderStateMixin);
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final WarmUpPageArguments warmUpPageArguments =
        ModalRoute.of(context).settings.arguments;
    final String sportName = warmUpPageArguments.sport.name;
    final Exercises exercises = warmUpPageArguments.sport.exercise;
    final TextStyle sportNameStyle =
        TextStyle(color: cWHITE, fontSize: actualDeviceSize.width * 1 / 18);
    final TextStyle pageIndexStyle =
        TextStyle(color: cWHITE, fontSize: actualDeviceSize.width * 1 / 18);

    return ChangeNotifierProvider<WarmUpProvider>(
      create: (BuildContext context) =>
          WarmUpProvider(tickerProviderStateMixin: tickerProviderStateMixin),
      child: Consumer<WarmUpProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SafeArea(
                child: Text(
                  '$sportName',
                  style: sportNameStyle,
                ),
              ),
              Expanded(
                child: Container(
                  child: PageView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: exercises.exerciseLength,
                    onPageChanged: (int index) =>
                        provider.onPageChanged(index),
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
              Container(
                width: actualDeviceSize.width,
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < exercises.exerciseLength; i++)
                      Column(
                        children: <Widget>[
                          provider.warmUpPageIndex == i
                              ? Text(
                                  '${i + 1}/${exercises.exerciseLength}',
                                  style: pageIndexStyle,
                                )
                              : Text(
                                  '',
                                  style: pageIndexStyle,
                                ),
                          AnimatedBuilder(
                            builder: (BuildContext context, Widget child) {
                              return Transform.rotate(
                                angle: provider.animationController.value * pi,
                                child: child,
                              );
                            },
                            animation: Tween(begin: 0, end: pi * 1)
                                .animate(provider.animationController),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: actualDeviceSize.width * 1 / 70,
                                  vertical: 1.5),
                              width: provider.warmUpPageIndex == i
                                  ? actualDeviceSize.width * 1 / 8
                                  : actualDeviceSize.width * 1 / 29,
                              height: provider.warmUpPageIndex == i
                                  ? actualDeviceSize.width * 1 / 27
                                  : actualDeviceSize.width * 1 / 27,
                              decoration: BoxDecoration(
                                shape: provider.warmUpPageIndex == i
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                                color: provider.warmUpPageIndex == i
                                    ? cSECONDARY_COLOR
                                    : cSECONDARY_COLOR.withOpacity(0.5),
                                //borderRadius: provider.warmUpPageIndex  == i ? BorderRadius.circular(5.0) : null,
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class WarmUpTab extends StatelessWidget {
  final Exercise exercise;
  final int exerciseLength;
  final WarmUpProvider provider;

  const WarmUpTab({Key key, this.exercise, this.exerciseLength, this.provider})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size actualDeviceSize = getActualDeviceSize(MediaQuery.of(context));
    final TextStyle _titleStyle =
        TextStyle(color: cWHITE, fontSize: actualDeviceSize.width * 1 / 18);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('${exercise.exerciseRepetition}',
                      style: _titleStyle)),
              Text(
                '${exercise.exerciseName}',
                style: _titleStyle,
              ),
              Container(
                width: actualDeviceSize.width,
                height: actualDeviceSize.height * 1 / 2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('${exercise.exerciseGif}'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: actualDeviceSize.width,
                height: actualDeviceSize.height * 1 / 39,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), color: cWHITE),
                child: Container(
                  width: provider.timerBarLevel,
                  height: actualDeviceSize.height * 1 / 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: cSECONDARY_COLOR,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tips:',
                  style: _titleStyle,
                ),
              ),
              for (var exerciseHint in exercise.exerciseHint.split(',')) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '- $exerciseHint',
                    style: _titleStyle,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
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
