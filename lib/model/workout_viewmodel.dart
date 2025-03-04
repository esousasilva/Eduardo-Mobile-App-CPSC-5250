import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/services/database_service.dart';
import 'package:uuid/uuid.dart';

class WorkoutViewModel extends ChangeNotifier {
  List<Workout> _workoutHistory = [];
  List<Exercise> _exercises = [
    Exercise('Squats', 0, ExerciseType.repetitions),
    Exercise('Jogging', 0, ExerciseType.miles),
    Exercise('Bench Press', 0, ExerciseType.seconds),
    Exercise('Swimming', 0, ExerciseType.laps),
  ];

  List<Workout> get workoutHistory => _workoutHistory;
  List<Exercise> get exercises => _exercises;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;


  // Load saved workouts from the database
  Future<void> loadWorkouts() async {
    _workoutHistory = await _dbHelper.getWorkouts();
    notifyListeners();
  }

  // Add workout and save to SQLite
  Future<void> addWorkout(String name, List<ExerciseResult> results, {bool isDownloaded = false}) async {
    var uuid = Uuid();
    int id = uuid.hashCode;
    final workout = Workout(id, name, results, DateTime.now(), isDownloaded: isDownloaded);

    _workoutHistory.add(workout);
    await _dbHelper.insertWorkout(workout);
    notifyListeners();
  }

  Future<void> deleteWorkout(int id) async{
    await _dbHelper.deleteWorkout(id);
    notifyListeners();
  }
}
