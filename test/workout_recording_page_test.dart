import 'package:eduardo_personal_app/main.dart';
import 'package:eduardo_personal_app/pages/laps_record_widget.dart';
import 'package:eduardo_personal_app/pages/miles_record_widget.dart';
import 'package:eduardo_personal_app/pages/repetitions_record_widget.dart';
import 'package:eduardo_personal_app/pages/seconds_record_widget.dart';
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
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'Testing if have different input forms for different units',
        (tester) async {
      // Create workout plan instance
      final workoutPlan = WorkoutPlan('Test Plan');

      await tester.pumpWidget(
        ChangeNotifierProvider<WorkoutPlan>.value(
          value: workoutPlan,
          child: MaterialApp(home: WorkoutRecordingPage()),
        ),
      );
      expect(find.byType(SecondsRecordWidget), findsOneWidget);
      expect(find.byType(MilesRecordWidget), findsOneWidget);
      expect(find.byType(RepetitionsRecordWidget), findsOneWidget);
      expect(find.byType(LapsRecordWidget), findsOneWidget);
    },
  );

  testWidgets(
    'Testing adding the Workout to the shared state',
        (WidgetTester tester) async {
      // Create workout plan instance
      final workoutPlan = WorkoutPlan('Test Plan');

      await tester.pumpWidget(
        ChangeNotifierProvider<WorkoutPlan>.value(
          value: workoutPlan,
          child: MaterialApp(home: MyApp()),
        ),
      );

      // Tap on Save Workout button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Start New Workout'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Start New Workout'), findsOneWidget);

      // await tester.tap(find.widgetWithText(ElevatedButton, 'Save Workout'));
      // await tester.pumpAndSettle();
      //
      // // Verify that a workout was added to the state
      expect(workoutPlan.getWorkouts.length, 1);
    },
  );


}