import 'dart:convert';
import 'package:eduardo_personal_app/model/workout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/exercise.dart';
import '../model/workout.dart';
import '../model/exercise_result.dart';

class WorkoutImportPage extends StatefulWidget {
  const WorkoutImportPage({super.key});

  @override
  State<WorkoutImportPage> createState() => _WorkoutImportPageState();
}

class _WorkoutImportPageState extends State<WorkoutImportPage> {
  final TextEditingController _urlController = TextEditingController();
  Future<Map<String, dynamic>>? _jsonContent;
  Map<String, dynamic>? _parsedWorkout;

  Future<Map<String, dynamic>> loadJsonData(String url) async {
    try {
      final httpResponse = await http.get(Uri.parse(url));

      if (httpResponse.statusCode == 200) {
        return json.decode(httpResponse.body);
      } else {
        throw Exception('Failed to load JSON');
      }
    } catch (e) {
      throw Exception('Invalid URL or Network error');
    }
  }

  void _fetchData() {
    setState(() {
      _jsonContent = loadJsonData(_urlController.text);
    });

    _jsonContent?.then((data) {
      setState(() {
        _parsedWorkout = data;
      });
    });
  }

  void _saveWorkout() async {
    if (_parsedWorkout == null) return;

    final workoutViewModel = context.read<WorkoutViewModel>();
    String workoutName = _parsedWorkout!['name'];

    List<ExerciseResult> exerciseResults = (_parsedWorkout!['exercises'] as List)
        .map((exercise) {
      return ExerciseResult(
        Exercise(
          exercise['name'],
          exercise['target'],
          ExerciseType.values.firstWhere(
                  (e) => e.name.toLowerCase() == exercise['unit'].toString().toLowerCase()),
        ),
        0,
      );
    }).toList();

    await workoutViewModel.addWorkout(workoutName, exerciseResults, isDownloaded: true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Workout saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Import')),
      body: Column(
        children: [
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              labelText: 'Enter JSON URL',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: _fetchData,
            child: Text('Load Workout'),
          ),
          Expanded(
            child: _jsonContent == null
                ? Center(child: Text('Enter a URL and press Load Workout button'))
                : FutureBuilder<Map<String, dynamic>>(
              future: _jsonContent,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No Data Found'));
                } else {
                  final jsonData = snapshot.data!;
                  return ListView(
                    children: jsonData.entries.map((entry) {
                      return Card(
                        child: ListTile(
                          title: Text(entry.key),
                          subtitle: Text(entry.value.toString()),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: _saveWorkout,
            child: Text('Save Workout'),
          ),
        ],
      ),
    );
  }
}
