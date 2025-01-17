import 'package:eduardo_personal_app/model/workout.dart';
import 'package:flutter/material.dart';
import '../model/exercise_result.dart';



class WorkoutDetails extends StatelessWidget {
  final ExerciseResult exerciseResult;
  final DateTime dateTime;

  const WorkoutDetails({super.key, required this.exerciseResult, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Exercise Name: ${exerciseResult.exercise.name}'),
        Text('Target: ${exerciseResult.exercise.target_output}'),
        Text('Unit: ${exerciseResult.exercise.unit}'),
        Text('Actual Achieved: ${exerciseResult.actuallyAchievedOutput}'),
        Text('When was achieved: ${dateTime.month}-${dateTime.day}-${dateTime.year}')
      ]
    );
  }
}
