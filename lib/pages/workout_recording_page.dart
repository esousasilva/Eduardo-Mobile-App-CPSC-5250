import 'package:eduardo_personal_app/model/exercise.dart';
import 'package:eduardo_personal_app/model/sample_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eduardo_personal_app/model/workout_plan.dart';


enum RepetitionUnitValues{
  five('5', 5),
  ten('10', 10),
  fifteen('15', 15),
  twenty('20', 20),
  twentyFive('25', 25),
  thirty('30', 30);

  const RepetitionUnitValues(this.label, this.unit);
  final String label;
  final int unit;
}

class WorkoutRecordingPage extends StatefulWidget{
  const WorkoutRecordingPage({super.key});

  @override
  State<WorkoutRecordingPage> createState() => _WorkoutRecordingPageState();
}

class _WorkoutRecordingPageState extends State<WorkoutRecordingPage> {
  final TextEditingController repetitionUnitController = TextEditingController();
  int? repetitionUnitSelected;

  @override
  Widget build(BuildContext context) {
    final workoutExercises = WorkoutPlan('Workout1Default');
    return Scaffold(
        appBar: AppBar(
          title: Text('Workout Recording'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Text('Exercises',
              style: TextStyle(fontSize: 21)),
              SizedBox(height: 15),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: workoutExercises.exercises.length,
                  itemBuilder: (context, index) => _WorkoutRecordingPage(workoutExercises.exercises[index], repetitionUnitController, repetitionUnitSelected))
            ],
          ),
        )
    );
  }
}

class _WorkoutRecordingPage extends StatelessWidget {
  final TextEditingController repetitionUnitController;
  final int? repetitionUnitSelected;

  final Exercise exercise;
  const _WorkoutRecordingPage(this.exercise, this.repetitionUnitController, this.repetitionUnitSelected);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(exercise.name),
        subtitle: Text('Unit: ${exercise.unit}'),
        trailing: DropdownMenu(
        controller: repetitionUnitController,
        initialSelection: RepetitionUnitValues.five.label,
        dropdownMenuEntries: RepetitionUnitValues.values
            .map((unit) => DropdownMenuEntry(value: unit.label, label: unit.label))
            .toList(),
        onSelected: (value) {
          repetitionUnitController.text = value!;
        },
      ),
      ),
    );
  }
}