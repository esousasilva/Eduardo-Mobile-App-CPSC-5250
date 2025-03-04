import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:eduardo_personal_app/pages/workout_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:eduardo_personal_app/services/database_service.dart';

void main() {
  late WorkoutViewModel workoutViewModel;
  late DatabaseHelper dbHelper;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    dbHelper = DatabaseHelper.instance;
    //await dbHelper.deleteDatabaseFile(); // Reset database before each test
    workoutViewModel = WorkoutViewModel();
    //await workoutViewModel.loadWorkouts();
  });

  testWidgets('shows multiple entries when there are multiple workouts', (WidgetTester tester) async {
    await workoutViewModel.addWorkout('Workout 1', []);
    await workoutViewModel.addWorkout('Workout 2', []);
    await workoutViewModel.addWorkout('Workout 3', []);

    // Pump the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<WorkoutViewModel>.value(
          value: workoutViewModel,
          child: Scaffold(
            body: WorkoutHistoryPage(),
          ),
        ),
      ),
    );

    // Ensure UI updates are fully reflected
    await tester.pumpAndSettle();

    expect(find.text('Workout List (3)'), findsOneWidget);
    expect(find.text('Workout 1'), findsOneWidget);
    expect(find.text('Workout 2'), findsOneWidget);
    expect(find.text('Workout 3'), findsOneWidget);
  });
}
