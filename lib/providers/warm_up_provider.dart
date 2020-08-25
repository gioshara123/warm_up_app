import 'package:flutter/cupertino.dart';

class WarmUpProvider with ChangeNotifier {

  int _warmUpPageIndex;
  double _timerBarLevel;

  final TickerProviderStateMixin tickerProviderStateMixin;
  AnimationController animationController;

  set timerBarLevel(double value) {
    _timerBarLevel = value;
    notifyListeners();
  }

  double get timerBarLevel => _timerBarLevel;

  set warmUpPageIndex(int value) {
    _warmUpPageIndex = value;
    notifyListeners();
  }

  int get warmUpPageIndex => _warmUpPageIndex;

  WarmUpProvider({this.tickerProviderStateMixin}){
    initWarmUpPage();
  }

  void initWarmUpPage() {
    setDefaultValues();
  }

  void setDefaultValues() {
    print(tickerProviderStateMixin);
    _timerBarLevel = 100;
    _warmUpPageIndex = 0;
    animationController = AnimationController(vsync: tickerProviderStateMixin, duration: Duration(seconds:1),);
  }

  void onPageChanged(int index) async{
    warmUpPageIndex = index;

  }
}