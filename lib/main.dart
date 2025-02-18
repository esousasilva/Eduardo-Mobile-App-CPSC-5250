import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/pages/home_screen.dart';
import 'package:eduardo_personal_app/model/workout_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: HomeScreen(),
    );
  }
}
