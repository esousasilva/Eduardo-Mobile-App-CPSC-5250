import 'package:eduardo_personal_app/services/app_routes.dart';
import 'package:eduardo_personal_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduardo_personal_app/pages/home_screen.dart';
import 'package:eduardo_personal_app/model/workout_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //DatabaseHelper.instance.deleteDatabaseFile();

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
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
