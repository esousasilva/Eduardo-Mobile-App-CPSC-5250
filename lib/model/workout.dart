import 'package:cloud_firestore/cloud_firestore.dart';
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
      'id': id,
      'name': name,
      'exerciseResults': exerciseResults.map((e) => e.toMap()).toList(),
      'dateTimeWhenWasDone': Timestamp.fromDate(dateTimeWhenWasDone),
      'isDownloaded': isDownloaded ? 1 : 0, // Convert bool to int
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      map['id'],
      map['name'],
      (map['exerciseResults'] as List)
          .map((e) => ExerciseResult.fromMap(e as Map<String, dynamic>))
          .toList(),
      (map['dateTimeWhenWasDone'] as Timestamp).toDate(),
      isDownloaded: map['isDownloaded'] == 1, // Convert int to bool
    );
  }
}