import 'exercise.dart';

class WorkoutPlan{
  final String workoutName;
  final List<Exercise> exercises = [
    Exercise('Squats', 0, 'Repetitions'),
    Exercise('Jogging', 0, 'Miles'),
    Exercise('Bench Press', 0, 'Seconds (Held)'),
    Exercise('Swimming', 0, 'Laps'),
    Exercise('Dancing', 0, 'Minutes'),
    Exercise('Climbing Stairs', 0, 'Steps'),
    Exercise('Jumping Rope', 0, 'Jumps')
  ];

  WorkoutPlan(this.workoutName);

  addOutput(Exercise exercise){
    exercises.add(exercise);
  }

  List<Exercise> get getExercises => [...exercises];
}