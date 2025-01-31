import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/sample_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';

class WorkoutCreationPage extends StatelessWidget {
  const WorkoutCreationPage({super.key});

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
                itemBuilder: (context, index) => _WorkoutCreationPage(workoutExercises.exercises[index]))
          ],
        ),
      )
    );
  }
}

class _WorkoutCreationPage extends StatelessWidget {
  final Exercise exercise;

  const _WorkoutCreationPage(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(exercise.name)
      ),
    );
  }
}

