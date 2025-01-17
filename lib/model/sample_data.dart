import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'exercise.dart';

final sampleData = Workout([
  ExerciseResult(Exercise('PushUps', 15, 'Repetitions'), 13),
  ExerciseResult(Exercise('Squats', 30, 'Repetitions'), 35),
  ExerciseResult(Exercise('Jogging', 20, 'Miles'), 10),
  ExerciseResult(Exercise('Plank', 30, 'Seconds (Held)'), 60),
  ExerciseResult(Exercise('Bench press', 20, 'Repetitions (40lb per rep)'), 15),
],[
  DateTime.utc(2024, 5, 2),
  DateTime.utc(2024, 4, 9),
  DateTime.utc(2024, 6, 10),
  DateTime.utc(2024, 7, 20),
  DateTime.utc(2024, 3, 29),
]
);