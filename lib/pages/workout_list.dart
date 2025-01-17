import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/pages/workout_history_page.dart';
import 'package:eduardo_personal_app/model/sample_data.dart';
import 'package:flutter/material.dart';


class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sampleData.exerciseResults.length,
      itemBuilder: (context, index) => _WorkoutListItem(sampleData.exerciseResults[index], sampleData.dateTimeWhenWasDone[index]),
    );
  }
}

class _WorkoutListItem extends StatelessWidget {
  final ExerciseResult exerciseResult;
  final DateTime dateTime;

  const _WorkoutListItem(this.exerciseResult, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Exercise Name: ${exerciseResult.exercise.name}'),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => WorkoutHistoryPage(exerciseResult: exerciseResult, dateTime: dateTime,)
          ),
        );
      },
    );
  }
}

