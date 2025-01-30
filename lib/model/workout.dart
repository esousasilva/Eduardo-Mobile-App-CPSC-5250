import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';

class Workout {
  final String name;

  final List<ExerciseResult> exerciseResults;

  final DateTime dateTimeWhenWasDone;

  Workout(this.name, this.exerciseResults, this.dateTimeWhenWasDone);
}