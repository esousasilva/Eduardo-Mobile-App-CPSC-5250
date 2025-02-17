class Exercise {
  final String name;
  late int target_output;
  final ExerciseType unit;

  Exercise(this.name, this.unit);
}

enum ExerciseType {
  seconds('Seconds'),
  repetitions('Repetitions'),
  miles('Miles'),
  laps('Laps'),
  jumps('Jumps');

  const ExerciseType(this.label);
  final String label;
}