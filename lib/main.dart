import 'package:eduardo_personal_app/model/workout_plan.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/pages/workout_history_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutPlan('workoutName'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workout History',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const WorkoutHistoryPage(),
      ),
    );
  }
}
