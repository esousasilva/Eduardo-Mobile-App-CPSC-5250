import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WorkoutHistoryPage extends StatelessWidget {
  const WorkoutHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutViewModel = context.watch<WorkoutViewModel>();
    workoutViewModel.loadWorkouts();
    return Scaffold(
      appBar: AppBar(title: Text('Workout List')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserPerformanceWidget(),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: workoutViewModel.workoutHistory.length,
              itemBuilder: (context, index) {
                final workout = workoutViewModel.workoutHistory[index];
                return Container(
                  width: double.infinity, // Ensure it takes full width
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text('Name:${workout.name}, ID: ${workout.id}'),
                          subtitle: Text('Date: ${workout.dateTimeWhenWasDone}'),
                          onTap: () {
                            context.pushNamed('/workout_detail', extra: workout.exerciseResults);
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (){
                            workoutViewModel.deleteWorkout(workout.id);
                          },
                          child: Icon(
                            Icons.delete,
                          )
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Choose your source'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  context.go('/start_workout', extra: {
                                    'listOfExercises': workoutViewModel.exercises,
                                    'imported': false
                                  });
                                },
                                child: Text('Hard-coded')
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.go('/start_workout', extra: {
                                    'listOfExercises': workoutViewModel.importedExercises,
                                    'imported': true
                                  });
                                },
                                child: Text('Imported')
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text('Cancel')
                          )
                        ],
                      );
                    }
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 15),
                ),
                child: Text('Start New Workout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
