import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/exercise_result.dart';
import '../model/workout_plan.dart';

class WorkoutDetails extends StatelessWidget {
  final List<ExerciseResult> exerciseResult;

  const WorkoutDetails({super.key, required this.exerciseResult});

  @override
  Widget build(BuildContext context) {
    final workoutExercises = context.watch<WorkoutPlan>();
    return Scaffold(
      appBar: AppBar(title: Text('Workout History')),
      body: SafeArea(
        child: Column(
          children: [
            UserPerformanceWidget(),
            SizedBox(height: 8,),
            exerciseResult.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            itemCount: exerciseResult.length,
            itemBuilder: (context, index) {
              final result = exerciseResult[index];
              final _valueAchieved = (result.actuallyAchievedOutput*100/result.exercise.target_output)/100;
              return ListTile(
                  title: Text('Exercise Name: ${result.exercise.name}'),
                  subtitle:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Target: ${result.exercise.target_output} ${result.exercise.unit.label} \n'
                                'Actual output: ${result.actuallyAchievedOutput} ${result.exercise.unit.label}'

                        ),
                        SizedBox(height: 5),
                      ]
                  )
              );
            },
          )
              : Center(child: Text('No workout history Available')),
          ],
        )
      ),
    );
  }
}