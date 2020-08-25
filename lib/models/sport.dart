import 'package:wvs_warm_up/models/exercises.dart';

class Sport {
  String imageLocalPath;
  String name;
  Exercises exercise;
  int id;

  Sport({this.name, this.imageLocalPath, this.exercise, this.id});
}
