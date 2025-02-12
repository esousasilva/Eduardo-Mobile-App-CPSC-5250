import 'package:flutter/material.dart';
import '../model/exercise_result.dart';

class WorkoutDetails extends StatelessWidget {
  final List<ExerciseResult> exerciseResult;

  const WorkoutDetails({super.key, required this.exerciseResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout History')),
      body: SafeArea(
        child: exerciseResult.isNotEmpty ? ListView.builder(
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
      ),
    );
  }
}