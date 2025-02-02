import 'package:eduardo_personal_app/model/workout.dart';
import 'package:flutter/cupertino.dart';

import 'exercise.dart';

class WorkoutPlan with ChangeNotifier{
  final String workoutName;
  late final List<Exercise> exercises = [
    Exercise('Squats', 0, ExerciseType.repetitions),
    Exercise('Jogging', 0, ExerciseType.miles),
    Exercise('Bench Press', 0, ExerciseType.seconds),
    Exercise('Swimming', 0, ExerciseType.laps),
  ];
  final List<Workout> _sampleData = [];
  int get num => _sampleData.length;

  WorkoutPlan(this.workoutName);

  addOutput(Workout workout){
    _sampleData.add(workout);
    notifyListeners();
  }

  getNum() {
    return num;
  }

  List<Exercise> get getExercises => [...exercises];
  List<Workout> get getWorkouts => [..._sampleData];
}