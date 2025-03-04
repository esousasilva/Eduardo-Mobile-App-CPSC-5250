import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.child});

  final Widget child; // The dynamic body content

  final List<String> _routes = [
    '/history',
    '/import',
    '/user',
  ];

  @override
  Widget build(BuildContext context) {
    String currentRoute = GoRouterState.of(context).uri.toString();

    /// Ensure valid index
    int currentIndex = _routes.contains(currentRoute) ? _routes.indexOf(currentRoute) : 0;

    return Scaffold(
      body: child, // This dynamically updates
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.go(_routes[index]); // Navigate but keep HomeScreen
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Workout History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Import Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
