import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/exercise_result.dart';
import '../model/workout_plan.dart';

class WorkoutDetails extends StatefulWidget {
  final List<ExerciseResult> exerciseResult;

  WorkoutDetails({super.key, required this.exerciseResult});

  @override
  _WorkoutDetailsState createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  int successfulExercises = 0;

  @override
  void initState() {
    super.initState();
    _calculateSuccessfulExercises();
  }

  void _calculateSuccessfulExercises() {
    successfulExercises = widget.exerciseResult
        .where((result) =>
    result.exercise.target_output > 0 &&
        (result.actuallyAchievedOutput / result.exercise.target_output) >= 1.0)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    bool isComplete = true;
    return Scaffold(
      appBar: AppBar(title: Text('Workout History')),
      body: SafeArea(
        child: Column(
          children: [
            UserPerformanceWidget(),
            SizedBox(height: 10,),
            Text('Successful Exercises: $successfulExercises/${widget.exerciseResult.length}'),
            SizedBox(height: 8),
            widget.exerciseResult.isNotEmpty
                ? Expanded( // Wrap ListView with Expanded to avoid layout issues
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.exerciseResult.length,
                itemBuilder: (context, index) {
                  final result = widget.exerciseResult[index];
                  final double valueAchieved = result.exercise.target_output == 0
                      ? 0
                      : result.actuallyAchievedOutput / result.exercise.target_output;
                  if(valueAchieved < 1){
                    isComplete = false;
                  }

                  return ListTile(
                    title: Row (
                      children: [
                        Text('Exercise Name: ${result.exercise.name}'),
                        Icon(
                          isComplete ? Icons.check_circle_rounded : Icons.close,
                          color: isComplete ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target: ${result.exercise.target_output} ${result.exercise.unit.label} \n'
                              'Actual output: ${result.actuallyAchievedOutput} ${result.exercise.unit.label}',
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 250,
                          height: 10,
                          child: LinearProgressIndicator(
                            value: valueAchieved,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
                : Center(child: Text('No workout history Available')),
          ],
        ),
      ),
    );
  }
}
