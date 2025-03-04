import 'dart:convert';

import 'package:eduardo_personal_app/model/exercise_result.dart';

class Workout {
  final int id;
  final String name;
  final List<ExerciseResult> exerciseResults;
  final DateTime dateTimeWhenWasDone;
  final bool isDownloaded;

  Workout(this.id, this.name, this.exerciseResults, this.dateTimeWhenWasDone, {this.isDownloaded = false});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': json.encode(exerciseResults.map((e) => e.toMap()).toList()),
      'dateTimeWhenWasDone': dateTimeWhenWasDone.toIso8601String(),
      'isDownloaded': isDownloaded ? 1 : 0,  // Store as integer in database
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      map['id'],
      map['name'],
      List<ExerciseResult>.from(
        json.decode(map['exercises']).map((e) => ExerciseResult.fromMap(e)),
      ),
      DateTime.parse(map['dateTimeWhenWasDone']),
      isDownloaded: map['isDownloaded'] == 1,  // Convert from integer
    );
  }
}