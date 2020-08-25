import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wvs_warm_up/const_exercise_information.dart';
import 'package:wvs_warm_up/models/sport.dart';

class ChooseSportsProvider with ChangeNotifier {
  TextEditingController textEditingController;

  List<Sport> _currentSportsList;

  List<Sport> get currentSportsList => _currentSportsList;

  void resetCurrentSportsList() {
    _currentSportsList = [...sports];
    notifyListeners();
  }

  ChooseSportsProvider() {
    initChooseSportsPage();
  }

  void initChooseSportsPage() {
    setDefaultValues();
  }

  void setDefaultValues() {
    textEditingController = TextEditingController(text: '');
    _currentSportsList = [...sports];
  }

  void textFieldOnChange(String newText) {
    _currentSportsList.clear();

    for (var sport in sports) {
      if (sport.name.trim().toLowerCase().contains(newText)) {
        _currentSportsList.add(sport);
      } else {
        _currentSportsList.remove(sport);
      }
    }
    notifyListeners();
  }

  void onClearButtonPressed() {
    textEditingController.clear();
    _currentSportsList = [...sports];
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }
}
