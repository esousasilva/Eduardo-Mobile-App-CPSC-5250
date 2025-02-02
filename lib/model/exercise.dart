class Exercise {
  final String name;
  final int target_output;
  final ExerciseType unit;

  const Exercise(this.name, this.target_output, this.unit);
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