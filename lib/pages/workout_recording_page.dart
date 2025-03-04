import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/pages/exercise_target_input_widget.dart';
import 'package:eduardo_personal_app/pages/laps_record_widget.dart';
import 'package:eduardo_personal_app/pages/miles_record_widget.dart';
import 'package:eduardo_personal_app/pages/repetitions_record_widget.dart';
import 'package:eduardo_personal_app/pages/seconds_record_widget.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final List<Exercise> listOfExercises;
  final bool imported;
  const WorkoutRecordingPage({required this.listOfExercises, required this.imported, super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  List<_WorkoutRecordingItemState> workoutItemStates = [];
  late TextEditingController _workoutNameController;

  @override
  void initState() {
    super.initState();
    _workoutNameController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _workoutNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final workoutViewModel = context.watch<WorkoutViewModel>();

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
            TextField(
              controller: _workoutNameController,
              decoration: const InputDecoration(labelText: 'Enter the Workout Name'),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.55, // Adjust height dynamically
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: widget.listOfExercises.length,
                itemBuilder: (context, index) {
                  return WorkoutRecordingItem(
                    exercise: widget.listOfExercises[index],
                    imported: widget.imported,
                    onStateCreated: (state) => workoutItemStates.add(state),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.go('/history');
                    },
                    child: Text('Cancel')
                ),
                ElevatedButton(
                  onPressed: () async {
                    List<ExerciseResult> exerciseResults = workoutItemStates
                        .map((state) => state.getExerciseResult())
                        .toList();

                    final workoutViewModel = context.read<WorkoutViewModel>();
                    await workoutViewModel.addWorkout(_workoutNameController.text, exerciseResults);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Workout saved!'))
                    );

                    context.go('/history');
                  },
                  child: Text(
                    'Save Workout',
                    style: TextStyle(fontSize: 19, color: Colors.green),
                  ),
                ),
              ],
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
  final bool imported;
  final Function(_WorkoutRecordingItemState) onStateCreated;

  const WorkoutRecordingItem({
    required this.exercise,
    required this.onStateCreated,
    required this.imported,
    super.key,
  });

  @override
  State<WorkoutRecordingItem> createState() {
    //exercise.target_output = 0;
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

    if(widget.imported){
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
              'Target: ${widget.exercise.target_output}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    } else {
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
}
