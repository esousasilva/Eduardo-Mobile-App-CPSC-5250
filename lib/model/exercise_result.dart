import 'exercise.dart';

class ExerciseResult {
  final Exercise exercise;
  final int achievedOutput;

  ExerciseResult(this.exercise, this.achievedOutput);

  // Convert ExerciseResult to a Map for storing in SQLite
  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise.toMap(), // Convert Exercise to Map
      'achievedOutput': achievedOutput,
    };
  }

  // Convert a Map back to ExerciseResult
  factory ExerciseResult.fromMap(Map<String, dynamic> map) {
    return ExerciseResult(
      Exercise.fromMap(map['exercise']), // Convert back to Exercise
      map['achievedOutput'],
    );
  }
}
