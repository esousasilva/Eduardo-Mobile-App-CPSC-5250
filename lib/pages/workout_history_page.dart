import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:eduardo_personal_app/pages/workout_details.dart';
import 'package:eduardo_personal_app/pages/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/sample_data.dart';

import '../model/exercise_result.dart';

class WorkoutHistoryPage extends StatelessWidget {
  final ExerciseResult exerciseResult;
  final DateTime dateTime;

  const WorkoutHistoryPage({super.key, required this.exerciseResult, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: WorkoutDetails(exerciseResult: exerciseResult, dateTime: dateTime),
            ),
          ),
        ],
      )
    );
  }
}
