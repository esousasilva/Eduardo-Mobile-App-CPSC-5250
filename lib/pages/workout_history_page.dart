import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:eduardo_personal_app/pages/workout_recording_page.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:eduardo_personal_app/pages/workout_details.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';
import 'package:provider/provider.dart';

class WorkoutHistoryPage extends StatefulWidget {
  const WorkoutHistoryPage({super.key});

  @override
  State<WorkoutHistoryPage> createState() => _WorkoutHistoryPageState();
}


class _WorkoutHistoryPageState extends State<WorkoutHistoryPage> {

  @override
  Widget build(BuildContext context) {
    final workoutExercises = context.watch<WorkoutPlan>();
    return Scaffold(
      appBar: AppBar(title: Text('Workout List (${workoutExercises.getWorkouts.length})')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserPerformanceWidget(),
            SizedBox(height: 10,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: workoutExercises.getWorkouts.length,
              itemBuilder: (context, index) => _WorkoutListItem(workoutExercises.getWorkouts[index], workoutExercises.getWorkouts[index].dateTimeWhenWasDone),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const WorkoutRecordingPage()),
                  );
                  setState(() {}); // Refresh the list after returning
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'My Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
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
                    builder: (context) => WorkoutDetails(
                        exerciseResult: workout.exerciseResults)),
              );
            }
        )
    );
  }
}
