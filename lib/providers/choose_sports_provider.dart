import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ChooseSportsProvider with ChangeNotifier {
  TextEditingController textEditingController;

  ChooseSportsProvider() {
    initChooseSportsPage();
  }

  void initChooseSportsPage() {
    setDefaultValues();
  }

  void setDefaultValues() {
    textEditingController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  void textFieldOnChange(String newText) {
    notifyListeners();
  }

  void onClearButtonPressed() {
    textEditingController.clear();
    notifyListeners();
  }
}
