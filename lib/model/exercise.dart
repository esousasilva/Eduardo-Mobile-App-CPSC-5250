import 'dart:convert';

enum ExerciseType {
  seconds('Seconds'),
  repetitions('Repetitions'),
  miles('Miles'),
  laps('Laps'),
  jumps('Jumps'),
  meters('Meters');

  const ExerciseType(this.label);
  final String label;
}

class Exercise {
  final String name;
  late int target_output;
  final ExerciseType unit;

  Exercise(this.name, this.target_output, this.unit);

  // Convert Exercise to a Map (for sqflite)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'target': target_output,
      'unit': unit.name, // Store as string
    };
  }

  // Convert a Map to an Exercise object
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      map['name'],
      map['target'],
      ExerciseType.values.firstWhere((e) => e.name == map['unit']),
    );
  }

  // Convert Exercise to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON to Exercise
  factory Exercise.fromJson(String source) => Exercise.fromMap(json.decode(source));
}
