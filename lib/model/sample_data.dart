import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'exercise.dart';

final sampleData = [Workout('Workout 1', [
  ExerciseResult(Exercise('PushUps', 15, 'Repetitions'), 13),
  ExerciseResult(Exercise('Bench press', 20, 'Repetitions (40lb per rep)'), 17),
],
  DateTime.utc(2024, 7, 2)
),
  Workout('Workout 2', [
    ExerciseResult(Exercise('Squats', 30, 'Repetitions'), 30),
    ExerciseResult(Exercise('Jogging', 20, 'Miles'), 10),
    ExerciseResult(Exercise('Plank', 30, 'Seconds (Held)'), 8),
    ExerciseResult(Exercise('Bench press', 20, 'Repetitions (40lb per rep)'), 17),
  ],
      DateTime.utc(2024, 4, 2)
  ),
  Workout('Workout 3', [
    ExerciseResult(Exercise('PushUps', 15, 'Repetitions'), 13),
    ExerciseResult(Exercise('Squats', 30, 'Repetitions'), 30),
    ExerciseResult(Exercise('Jogging', 20, 'Miles'), 10),
    ExerciseResult(Exercise('Plank', 30, 'Seconds (Held)'), 8),
  ],
      DateTime.utc(2024, 20, 2)
  ),
  Workout('Workout 4', [
    ExerciseResult(Exercise('PushUps', 15, 'Repetitions'), 13),
    ExerciseResult(Exercise('Squats', 30, 'Repetitions'), 30),
    ExerciseResult(Exercise('Jogging', 20, 'Miles'), 10),
    ExerciseResult(Exercise('Plank', 30, 'Seconds (Held)'), 8),
  ],
      DateTime.utc(2024, 20, 2)
  )
];