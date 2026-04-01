import 'package:flutter/material.dart';

class ClientWorkoutView extends StatelessWidget {
  const ClientWorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Workouts')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 64, color: Color(0xFFDC143C)),
            SizedBox(height: 16),
            Text('No Workout for Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Check your schedule for tomorrow.', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
