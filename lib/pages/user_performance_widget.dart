import 'dart:math';
import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';

class UserPerformanceWidget extends StatelessWidget {
  const UserPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutViewModel>(
      builder: (context, workoutExercises, child) {
        final recentWorkouts = workoutExercises.workoutHistory.where((w) =>
            w.dateTimeWhenWasDone.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();

        int num;
        if (workoutExercises.workoutHistory.isNotEmpty) {
          num = workoutExercises.workoutHistory.first.dateTimeWhenWasDone.month;
        } else {
          num = 1;
        }

        double performance = (recentWorkouts.length * num * pi);
        String userPerformanceMessage;
        if(performance.truncate() == 0){
          userPerformanceMessage = 'No Data Available';
        }else {
          userPerformanceMessage = performance.truncate().toString();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('User Performance: $userPerformanceMessage'),
            Text(
              'Note: The user performance is based on the workouts performed in the last 7 days.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
