import 'exercise.dart';

class WorkoutPlan{
  final String workoutName;
  final List<Exercise> exercises = [
    Exercise('Squats', 0, ExerciseType.repetitions),
    Exercise('Jogging', 0, ExerciseType.miles),
    Exercise('Bench Press', 0, ExerciseType.seconds),
    Exercise('Swimming', 0, ExerciseType.laps),
  ];

  WorkoutPlan(this.workoutName);

  addOutput(Exercise exercise){
    exercises.add(exercise);
  }

  List<Exercise> get getExercises => [...exercises];
}