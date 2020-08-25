import 'package:wvs_warm_up/enums/warm_up_exercise.dart';
import 'package:wvs_warm_up/models/exercises.dart';

class Exercise {
  final int exerciseWorkTime;
  final String exerciseHint;
  final String exerciseRepetition;
  final String exerciseGif;
  final String exerciseName;
  final WarmUpExercise warmUpExerciseMode;

  @override
  String toString() {
    return 'Exercise{exerciseWorkTime: $exerciseWorkTime, exerciseHint: $exerciseHint, exerciseRepetition: $exerciseRepetition, exerciseGif: $exerciseGif, exerciseName: $exerciseName, warmUpExerciseMode: $warmUpExerciseMode}';
  }
  factory Exercise.fromExercises(Exercises exercises,int index) {
    return Exercise(
      exerciseName: exercises.exerciseNames[index],
      exerciseHint: exercises.exerciseHints[index],
      exerciseGif: exercises.exerciseGifs[index],
      exerciseRepetition: exercises.exerciseRepetition[index],
      exerciseWorkTime: exercises.exerciseWorkTimes[index],
      warmUpExerciseMode: exercises.warmUpModes[index],
    );
  }
  Exercise({this.exerciseWorkTime, this.exerciseHint, this.exerciseRepetition, this.exerciseGif, this.exerciseName, this.warmUpExerciseMode});

}