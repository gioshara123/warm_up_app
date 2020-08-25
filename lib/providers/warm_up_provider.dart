import 'package:flutter/cupertino.dart';
import 'package:wvs_warm_up/enums/warm_up_mode.dart';
import 'package:wvs_warm_up/models/exercises.dart';

class WarmUpProvider with ChangeNotifier {

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

  WarmUpProvider({this.tickerProviderStateMixin, this.exercises, this.context}){
    initWarmUpPage();
  }

  void initWarmUpPage() {
    setDefaultValues();
  }

  void setDefaultValues() {
    print(tickerProviderStateMixin);
    _timerBarLevel = 100;
    _warmUpPageCurrentIndex = 0;
    _currentWarmUpMode =  exercises.warmUpModes[0];
    //animationController = AnimationController(vsync: tickerProviderStateMixin, duration: Duration(seconds:1),);
    pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int index) async{
    warmUpPageCurrentIndex = index;
    currentWarmUpMode = exercises.warmUpModes[index];
  }
  void onNextExerciseChange() {
    if(warmUpPageCurrentIndex == exercises.exerciseLength -1) {
      Navigator.pop(context);
    }else{
      print(warmUpPageCurrentIndex);
      warmUpPageCurrentIndex++;
      pageController.animateToPage(warmUpPageCurrentIndex,duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    pageController = null;
  }
}