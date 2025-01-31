import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/sample_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';



class WorkoutRecordingPage extends StatelessWidget {
  const WorkoutRecordingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final workoutExercises = WorkoutPlan('Workout1Default');
    return Scaffold(
        appBar: AppBar(
          title: Text('Workout Creation'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: workoutExercises.exercises.length,
                  itemBuilder: (context, index) => _WorkoutRecordingPage(workoutExercises.exercises[index]))
            ],
          ),
        )
    );
  }
}
class _WorkoutRecordingPage extends StatelessWidget {
  final Exercise exercise;
  const _WorkoutRecordingPage(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(exercise.name)
      ),
    );
  }
}