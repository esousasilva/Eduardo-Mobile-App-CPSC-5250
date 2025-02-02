import 'dart:math';

import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/pages/laps_record_widget.dart';
import 'package:eduardo_personal_app/pages/miles_record_widget.dart';
import 'package:eduardo_personal_app/pages/repetitions_record_widget.dart';
import 'package:eduardo_personal_app/pages/seconds_record_widget.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';
import 'package:provider/provider.dart';
import '../model/workout.dart';

enum RepetitionUnitValues {
  five('5', 5),
  ten('10', 10),
  fifteen('15', 15),
  twenty('20', 20),
  twentyFive('25', 25),
  thirty('30', 30);

  const RepetitionUnitValues(this.label, this.unit);
  final String label;
  final int unit;
}

class WorkoutRecordingPage extends StatefulWidget {
  const WorkoutRecordingPage({super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  final TextEditingController repetitionUnitController = TextEditingController();
  List<_WorkoutRecordingItemState> workoutItemStates = [];

  @override
  Widget build(BuildContext context) {
    final workoutExercises = context.watch<WorkoutPlan>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Recording'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Text('Exercises List', style: TextStyle(fontSize: 21)),
            SizedBox(height: 15),
            UserPerformanceWidget(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: workoutExercises.exercises.length,
              itemBuilder: (context, index) {
                final item = WorkoutRecordingItem(
                  exercise: workoutExercises.exercises[index],
                  onStateCreated: (state) => workoutItemStates.add(state),
                );
                return item;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                workoutExercises.getNum();
                // Collect final values from each WorkoutRecordingItem state
                List<ExerciseResult> exerciseResults = workoutItemStates
                    .map((state) => state.getExerciseResult())
                    .toList();

                // Save the collected exercise results
                final newWorkout = Workout(
                  'Custom Workout',
                  exerciseResults,
                  DateTime.now(),
                );

                workoutExercises.addOutput(newWorkout);
                Navigator.of(context).pop();
              },
              child: Text(
                'Save Workout',
                style: TextStyle(fontSize: 19, color: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WorkoutRecordingItem extends StatefulWidget {
  final Exercise exercise;
  final Function(_WorkoutRecordingItemState) onStateCreated;

  const WorkoutRecordingItem({
    required this.exercise,
    required this.onStateCreated,
    super.key,
  });

  @override
  State<WorkoutRecordingItem> createState() {
    final state = _WorkoutRecordingItemState();
    onStateCreated(state);
    return state;
  }
}

class _WorkoutRecordingItemState extends State<WorkoutRecordingItem> {
  int actuallyAchievedOutput = 0; // Stores the last slider value

  void updateValue(int value) {
    setState(() {
      actuallyAchievedOutput = value; // Store the last changed value
    });
  }

  // Provide a method to retrieve the saved value
  ExerciseResult getExerciseResult() {
    return ExerciseResult(widget.exercise, actuallyAchievedOutput);
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedWidget;

    switch (widget.exercise.unit.label) {
      case 'Seconds':
        selectedWidget = SecondsRecordWidget(
          onValueChanged: (value) => updateValue(value.inSeconds),
        );
        break;
      case 'Repetitions':
        selectedWidget = RepetitionsRecordWidget(
          onValueChanged: (value) => updateValue(value.toInt()),
        );
        break;
      case 'Laps':
        selectedWidget = LapsRecordWidget(
          onValueChanged: (value) => updateValue(value.toInt()),
        );
        break;
      case 'Miles':
        selectedWidget = MilesRecordWidget(
          onValueChanged: (value) => updateValue(value.toInt()),
        );
        break;
      default:
        selectedWidget = selectedWidget = MilesRecordWidget(
          onValueChanged: (value) => updateValue(value.toInt()),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.exercise.name,
            style: TextStyle(fontSize: 20),
          ),
          selectedWidget,
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
