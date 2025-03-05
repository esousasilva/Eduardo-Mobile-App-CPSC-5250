import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/workout.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseHelper._init();

  CollectionReference get _workoutsCollection => _firestore.collection('workouts');

  // Insert Workout
  Future<void> insertWorkout(Workout workout) async {
    await _workoutsCollection.doc(workout.id.toString()).set(workout.toMap());
  }

  // Retrieve all workouts
  Future<List<Workout>> getWorkouts() async {
    QuerySnapshot snapshot = await _workoutsCollection.get();
    return snapshot.docs.map((doc) => Workout.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  // Delete a workout
  Future<void> deleteWorkout(int id) async {
    await _workoutsCollection.doc(id.toString()).delete();
  }

  // Stream Workouts (for real-time updates)
  Stream<List<Workout>> streamWorkouts() {
    return _workoutsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Workout.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
