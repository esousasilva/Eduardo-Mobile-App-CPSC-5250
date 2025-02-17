import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/workout_viewmodel.dart';
import 'pages/workout_history_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkoutViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout Tracker',
      home: WorkoutHistoryPage(),
    );
  }
}
