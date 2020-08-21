import 'package:wvs_warm_up/enums/warm_up_exercise.dart';

class Exercise {
  int exerciseLength;
  List<String> exerciseGifs;
  List<int> exerciseWorkTimes;
  List<String> exerciseHints;
  List<String> exerciseNames;
  List<WarmUpExercise> warmUps;
  List<String> exerciseRepetition;
  Exercise(
      {this.exerciseGifs,
      this.exerciseLength,
      this.exerciseWorkTimes,
      this.exerciseHints,
      this.exerciseNames,
      this.warmUps,
      this.exerciseRepetition});
}
