import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/pages/exercise_target_input_widget.dart';
import 'package:eduardo_personal_app/pages/laps_record_widget.dart';
import 'package:eduardo_personal_app/pages/miles_record_widget.dart';
import 'package:eduardo_personal_app/pages/repetitions_record_widget.dart';
import 'package:eduardo_personal_app/pages/seconds_record_widget.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/workout_viewmodel.dart';

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
  List<_WorkoutRecordingItemState> workoutItemStates = [];

  @override
  Widget build(BuildContext context) {
    final workoutViewModel = context.watch<WorkoutViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Workout Recording')),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 15),
            Center(
              child: Text('Exercise List', style: TextStyle(fontSize: 21)),
            ),
            SizedBox(height: 15),
            UserPerformanceWidget(),
            SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65, // Adjust height dynamically
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: workoutViewModel.exercises.length,
                itemBuilder: (context, index) {
                  return WorkoutRecordingItem(
                    exercise: workoutViewModel.exercises[index],
                    onStateCreated: (state) => workoutItemStates.add(state),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                List<ExerciseResult> exerciseResults = workoutItemStates
                    .map((state) => state.getExerciseResult())
                    .toList();

                final workoutViewModel = context.read<WorkoutViewModel>();
                await workoutViewModel.addWorkout('Custom Workout', exerciseResults);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Workout saved!'))
                );

                Navigator.of(context).pop();
              },
              child: Text(
                'Save Workout',
                style: TextStyle(fontSize: 19, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
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
    exercise.target_output = 0;
    final state = _WorkoutRecordingItemState();
    onStateCreated(state);
    return state;
  }
}

class _WorkoutRecordingItemState extends State<WorkoutRecordingItem> {
  int actuallyAchievedOutput = 0; // Stores the last slider value
  int targetInput = 0;

  void updateValue(int value) {
    setState(() {
      actuallyAchievedOutput = value; // Store the last changed value
    });
  }

  void updateTargetInput(int value) {
    setState(() {
      widget.exercise.target_output = value; // Store the last changed value
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
          Text(
            'Target: ',
            style: TextStyle(fontSize: 20),
          ),
          ExerciseTargetInputWidget(onValueChanged: (value) => updateTargetInput(value.toInt()))
        ],
      ),
    );
  }
}
