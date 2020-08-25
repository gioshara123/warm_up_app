import 'dart:async';
import 'package:countdown/countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wvs_warm_up/enums/warm_up_mode.dart';
import 'package:wvs_warm_up/enums/widget_state.dart';
import 'package:wvs_warm_up/models/exercises.dart';

class WarmUpProvider with ChangeNotifier {
  WidgetState _tipsState;

  WidgetState get tipsState => _tipsState;
  StreamSubscription<Duration> timerSubscription;

  String _timerValue;

  String get timerValue => _timerValue;

  set timerValue(String value) {
    _timerValue = value;
    notifyListeners();
  }

  int _warmUpPageCurrentIndex;
  double _timerBarLevel;

  PageController pageController;

  BuildContext context;

  WarmUpMode _currentWarmUpMode;
  Exercises exercises;

  set currentWarmUpMode(WarmUpMode value) {
    _currentWarmUpMode = value;
    notifyListeners();
  }

  WarmUpMode get currentWarmUpMode => _currentWarmUpMode;
  final TickerProviderStateMixin tickerProviderStateMixin;
  //AnimationController animationController;

  set timerBarLevel(double value) {
    _timerBarLevel = value;
    notifyListeners();
  }

  double get timerBarLevel => _timerBarLevel;

  set warmUpPageCurrentIndex(int value) {
    _warmUpPageCurrentIndex = value;
    notifyListeners();
  }

  int get warmUpPageCurrentIndex => _warmUpPageCurrentIndex;

  WarmUpProvider(
      {this.tickerProviderStateMixin, this.exercises, this.context}) {
    initWarmUpPage();
  }

  void initWarmUpPage() {
    setDefaultValues();
  }

  void onTipsStateChanged() {
    switch (_tipsState) {
      case WidgetState.Default:
        _tipsState = WidgetState.Changed;
        break;
      case WidgetState.Changed:
        _tipsState = WidgetState.Default;

        break;
    }
    notifyListeners();
  }

  void setDefaultValues() {
    _timerBarLevel = 0;
    _warmUpPageCurrentIndex = 0;
    _currentWarmUpMode = exercises.warmUpModes[0];
    _timerValue = "0:00";
    _tipsState = WidgetState.Default;

    //animationController = AnimationController(vsync: tickerProviderStateMixin, duration: Duration(seconds:1),);
    pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int index) async {
    warmUpPageCurrentIndex = index;
    currentWarmUpMode = exercises.warmUpModes[index];
    resetTimerValues();
  }

  void onNextExerciseChange() {
    if (warmUpPageCurrentIndex == exercises.exerciseLength - 1) {
      Navigator.pop(context);
    } else {
      print(warmUpPageCurrentIndex);
      warmUpPageCurrentIndex++;
      pageController.animateToPage(warmUpPageCurrentIndex,
          duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
      resetTimerValues();
    }
  }

  void onPreviousExerciseChange() {
    if (warmUpPageCurrentIndex == 0) {
      Navigator.pop(context);
    } else {
      warmUpPageCurrentIndex--;
      pageController.animateToPage(warmUpPageCurrentIndex,
          duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
      resetTimerValues();
    }
  }

  void resetTimerValues() {
    timerSubscription?.cancel();
    timerSubscription = null;
    _timerBarLevel = 0;
    _timerValue = "0:00";
    notifyListeners();
  }

  void onTimerRun() {
    print("onTimerRun");
    bool isPaused = timerSubscription?.isPaused ?? false;
    if (isPaused) {
      timerSubscription?.resume();
      notifyListeners();
      return;
    }
    int currentWorkTime = exercises.exerciseWorkTimes[warmUpPageCurrentIndex];
    final CountDown countDown = CountDown(Duration(seconds: currentWorkTime));
    timerSubscription = countDown.stream.listen(null)
      ..onData((Duration duration) {
        timerValue = getProperTime(duration);
        timerBarLevel = duration.inMilliseconds / (currentWorkTime * 1000);
      })
      ..onDone(() {
        resetTimerValues();
      });
    notifyListeners();
  }

  void onTimerPause() {
    timerSubscription?.pause();
    notifyListeners();
  }

  /***
   * Services
   */

  String getProperTime(Duration dur) {
    return '${dur.inMinutes}:${(dur.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
    pageController?.dispose();
    pageController = null;
    timerSubscription?.cancel();
    timerSubscription = null;
  }
}
