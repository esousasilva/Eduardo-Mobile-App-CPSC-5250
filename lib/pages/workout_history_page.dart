import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:eduardo_personal_app/pages/workout_recording_page.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/pages/workout_details.dart';
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
            SizedBox(height: 10,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: workoutViewModel.workoutHistory.length,
              itemBuilder: (context, index) {
                final workout = workoutViewModel.workoutHistory[index];
                return ListTile(
                  title: Text(workout.name),
                  subtitle: Text('Date: ${workout.dateTimeWhenWasDone}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetails(exerciseResult: workout.exerciseResults),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const WorkoutRecordingPage()),
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