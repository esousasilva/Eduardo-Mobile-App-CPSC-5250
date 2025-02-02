import 'package:eduardo_personal_app/main.dart';
import 'package:eduardo_personal_app/pages/laps_record_widget.dart';
import 'package:eduardo_personal_app/pages/miles_record_widget.dart';
import 'package:eduardo_personal_app/pages/repetitions_record_widget.dart';
import 'package:eduardo_personal_app/pages/seconds_record_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/pages/workout_recording_page.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';

void main() {
  group('WorkoutRecordingPage Tests', () {
    testWidgets(
      'Testing if have different input forms for different units in the workout record page',
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
      'Testing adding the Workout to the shared state data',
          (WidgetTester tester) async {
        // Create workout plan instance
        final workoutPlan = WorkoutPlan('Test Plan');

        await tester.pumpWidget(
          ChangeNotifierProvider<WorkoutPlan>.value(
            value: workoutPlan,
            child: MaterialApp(
              home: WorkoutRecordingPage(),
            ),
          ),
        );

        // Ensure the "Save Workout" button is visible by scrolling to it
        final buttonFinder = find.widgetWithText(ElevatedButton, 'Save Workout');
        await tester.ensureVisible(buttonFinder);

        // Ensure the button is enabled
        expect(buttonFinder, findsOneWidget);
        expect(tester.widget<ElevatedButton>(buttonFinder).enabled, isTrue);

        // Tap on Save Workout button
        await tester.tap(buttonFinder);
        await tester.pumpAndSettle();

        // Verify that a workout was added to the state
        int num = workoutPlan.getNum();
        expect(num, equals(1));
      },
    );
  });
}