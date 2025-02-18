import 'package:eduardo_personal_app/model/exercise_result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

import '../model/exercise.dart';
import '../model/workout.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('workout.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        exercises TEXT NOT NULL,
        dateTimeWhenWasDone TEXT NOT NULL
      )
    ''');
  }

  // Insert Workout
  Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    return await db.insert('workouts', {
      'name': workout.name,
      'exercises': json.encode(workout.exerciseResults.map((e) => e.toMap()).toList()), // Convert ExerciseResult to JSON
      'dateTimeWhenWasDone': workout.dateTimeWhenWasDone.toIso8601String(),
    });
  }


  // Retrieve all workouts
  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('workouts');

    return List.generate(maps.length, (i) {
      return Workout(
        maps[i]['name'],
        List<ExerciseResult>.from(
            json.decode(maps[i]['exercises']).map((e) => ExerciseResult.fromMap(e))
        ), // Convert back to ExerciseResult list
        DateTime.parse(maps[i]['dateTimeWhenWasDone']),
      );
    });
  }


  // Delete a workout
  Future<int> deleteWorkout(int id) async {
    final db = await database;
    return await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }

  // Future<void> deleteDatabaseFile() async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, 'workout.db');
  //   await deleteDatabase(path); // Deletes the existing database
  //   print('Database deleted successfully.');
  // }
}
