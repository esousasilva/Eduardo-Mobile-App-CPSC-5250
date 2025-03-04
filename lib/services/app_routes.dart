import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:eduardo_personal_app/pages/workout_details.dart';
import 'package:eduardo_personal_app/pages/workout_history_page.dart';
import 'package:eduardo_personal_app/pages/workout_import_page.dart';
import 'package:eduardo_personal_app/pages/workout_recording_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eduardo_personal_app/pages/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/history',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/history',
          builder: (context, state) => WorkoutHistoryPage(),
        ),
        GoRoute(
          path: '/import',
          builder: (context, state) => WorkoutImportPage(),
        ),
        GoRoute(
          path: '/user',
          builder: (context, state) => Placeholder(),
        )
      ]
    ),
    GoRoute(
      name: '/workout_detail',
      path: '/workout_detail',
      builder: (context, state) {
        final List<ExerciseResult> exerciseResult  = state.extra as List<ExerciseResult>;
        return WorkoutDetails(exerciseResult: exerciseResult);
      }
    ),
    GoRoute(
      name: "/start_workout",
      path: "/start_workout",
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return WorkoutRecordingPage(
          listOfExercises: extra['listOfExercises'],
          imported: extra['imported']
        );
      }
    ),
  ]
);