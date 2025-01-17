import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';

class Workout {
  final List<ExerciseResult> exerciseResults;

  final List<DateTime> dateTimeWhenWasDone;

  Workout(this.exerciseResults, this.dateTimeWhenWasDone);
}