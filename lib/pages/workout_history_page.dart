import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:eduardo_personal_app/pages/workout_history_page.dart';
import 'package:eduardo_personal_app/model/sample_data.dart';
import 'package:flutter/material.dart';


class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout List')),
      body: ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (context, index) => _WorkoutListItem(sampleData[index], sampleData[index].dateTimeWhenWasDone),
      ),
    );
  }
}

class _WorkoutListItem extends StatelessWidget {
  final Workout workout;
  final DateTime dateTime;

  const _WorkoutListItem(this.workout, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(workout.name),
        subtitle: Text('Date Completed: ${workout.dateTimeWhenWasDone.month}-'
            '${workout.dateTimeWhenWasDone.day}-'
            '${workout.dateTimeWhenWasDone.year}'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => WorkoutHistoryPage(
                    exerciseResult: workout.exerciseResults)),
          );
        }
      )
    );
  }
}

