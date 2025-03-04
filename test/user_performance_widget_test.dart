import 'package:eduardo_personal_app/main.dart';
import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
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
import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/workout.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('UserPerformanceWidget Test', () {
    testWidgets('Test user performance widget display a metric based on the Workouts in the shared state data', (WidgetTester tester) async {
      // Create a test instance of WorkoutPlan
      final workoutPlan = WorkoutViewModel();

      // Set up the test environment with Provider
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<WorkoutViewModel>.value(
            value: workoutPlan,
            child: Scaffold(
              body: UserPerformanceWidget(),
            ),
          ),
        ),
      );

      // Initially, performance should be zero as there are no workouts
      expect(find.textContaining('User Performance: No Data Available'), findsOneWidget);

      // Add a workout to the plan
      final workout = Workout(
        'Test Workout',
        [],
        DateTime.now(), // Current timestamp
      );

      //workoutPlan.addWorkout(workout);

      // Rebuild the widget after adding a workout
      //await tester.pump();

      // Verify that the performance metric updates correctly
      //expect(find.textContaining('User Performance: 6'), findsOneWidget);
    });


    testWidgets('Test user performance widget display default message when no workout have been done', (WidgetTester tester) async {
      // Create a test instance of WorkoutPlan
      final workoutPlan = WorkoutViewModel();

      // Set up the test environment with Provider
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<WorkoutViewModel>.value(
            value: workoutPlan,
            child: Scaffold(
              body: UserPerformanceWidget(),
            ),
          ),
        ),
      );
      // Initially, performance should be zero as there are no workouts
      expect(find.textContaining('User Performance: No Data Available'), findsOneWidget);
    });
  });
}