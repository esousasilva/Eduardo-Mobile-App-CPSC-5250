import 'package:eduardo_personal_app/main.dart';
import 'package:eduardo_personal_app/pages/laps_record_widget.dart';
import 'package:eduardo_personal_app/pages/miles_record_widget.dart';
import 'package:eduardo_personal_app/pages/repetitions_record_widget.dart';
import 'package:eduardo_personal_app/pages/seconds_record_widget.dart';
import 'package:eduardo_personal_app/pages/user_performance_widget.dart';
import 'package:eduardo_personal_app/pages/workout_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/pages/workout_recording_page.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';
import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  testWidgets('shows multiple entries when there are multiple workouts', (WidgetTester tester) async {
    // Create a test instance of WorkoutPlan with multiple workouts
    final workoutPlan = WorkoutPlan('Test plan');

    // Adding multiple workouts
    workoutPlan.addOutput(Workout('Workout 1', [], DateTime.now().subtract(Duration(days: 2))));
    workoutPlan.addOutput(Workout('Workout 2', [], DateTime.now().subtract(Duration(days: 1))));
    workoutPlan.addOutput(Workout('Workout 3', [], DateTime.now()));

    // Set up the test environment with Provider
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<WorkoutPlan>.value(
          value: workoutPlan,
          child: Scaffold(
            body: WorkoutHistoryPage(),
          ),
        ),
      ),
    );

    // Verify the app bar title includes the correct count of workouts
    expect(find.text('Workout List (3)'), findsOneWidget);

    // Verify that each workout title is displayed in the list
    expect(find.text('Workout 1'), findsOneWidget);
    expect(find.text('Workout 2'), findsOneWidget);
    expect(find.text('Workout 3'), findsOneWidget);
  });
}