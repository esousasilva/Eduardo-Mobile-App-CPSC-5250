import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';

class UserPerformanceWidget extends StatelessWidget {
  const UserPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutPlan>(
      builder: (context, workoutExercises, child) {
        final recentWorkouts = workoutExercises.getWorkouts.where((w) =>
            w.dateTimeWhenWasDone.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();

        int num;
        if (workoutExercises.getWorkouts.isNotEmpty) {
          num = workoutExercises.getWorkouts.first.dateTimeWhenWasDone.month;
        } else {
          num = 1;
        }

        double performance = (recentWorkouts.length * num * pi);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('User Performance: ${performance.truncate()}'),
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
