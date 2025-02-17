import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';

class WorkoutViewModel extends ChangeNotifier {
  List<Workout> _workoutHistory = [];
  List<Exercise> _exercises = [
    Exercise('Squats', ExerciseType.repetitions),
    Exercise('Jogging', ExerciseType.miles),
    Exercise('Bench Press', ExerciseType.seconds),
    Exercise('Swimming', ExerciseType.laps),
  ];

  List<Workout> get workoutHistory => _workoutHistory;
  List<Exercise> get exercises => _exercises;

  void addWorkout(String name, List<ExerciseResult> results) {
    final workout = Workout(name, results, DateTime.now());
    _workoutHistory.add(workout);
    notifyListeners();
  }
}
