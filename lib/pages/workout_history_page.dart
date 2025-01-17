import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:flutter/material.dart';

import '../model/exercise_result.dart';

class WorkoutHistoryPage extends StatelessWidget {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _sampleData = Workout([
      ExerciseResult(Exercise('PushUps', 15, 'Repetitions'), 13),
      ExerciseResult(Exercise('Squats', 30, 'Repetitions'), 35),
      ExerciseResult(Exercise('Jogging', 20, 'Miles'), 10),
      ExerciseResult(Exercise('Plank', 30, 'Seconds (Held)'), 60),
      ExerciseResult(Exercise('Bench press', 20, 'Repetitions (40lb per rep)'), 15),
      ],[
        DateTime.utc(2024, 5, 2),
        DateTime.utc(2024, 4, 9),
        DateTime.utc(2024, 6, 10),
        DateTime.utc(2024, 7, 20),
        DateTime.utc(2024, 3, 29),
      ]
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout History'),
      ),
      body: ListView.builder(
        itemCount: _sampleData.exerciseResults.length,
        itemBuilder: (context, index) {
          final exercise = _sampleData.exerciseResults[index];
          final dateTime = _sampleData.dateTimeWhenWasDone[index];


          return ListTile(
            title: Text(exercise.exercise.name),
            subtitle: Text('Target: ${exercise.exercise.target_output} in '
                '${exercise.exercise.unit} \nActual done: '
                '${exercise.actuallyAchievedOutput}\nWhen: '
                '${dateTime.month}-${dateTime.day}-${dateTime.year}'),
          );
        },
      )
    );
  }
}
