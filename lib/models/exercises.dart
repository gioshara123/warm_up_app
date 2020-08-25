import 'package:wvs_warm_up/enums/warm_up_exercise.dart';

class Exercises {
  int exerciseLength;
  List<String> exerciseGifs;
  List<int> exerciseWorkTimes;
  List<String> exerciseHints;
  List<String> exerciseNames;
  List<WarmUpExercise> warmUpModes;
  List<String> exerciseRepetition;
  Exercises(
      {this.exerciseGifs,
      this.exerciseLength,
      this.exerciseWorkTimes,
      this.exerciseHints,
      this.exerciseNames,
      this.warmUpModes,
      this.exerciseRepetition});
}
