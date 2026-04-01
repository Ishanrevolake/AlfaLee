import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';
import '../../services/mock_data_service.dart';
import 'exercise_detail_screen.dart';

class WorkoutDayDetailScreen extends StatefulWidget {
  final Map<String, String> dayData;
  final bool isReadOnly;

  const WorkoutDayDetailScreen({super.key, required this.dayData, this.isReadOnly = false});

  @override
  State<WorkoutDayDetailScreen> createState() => _WorkoutDayDetailScreenState();
}

class _WorkoutDayDetailScreenState extends State<WorkoutDayDetailScreen> {
  final List<Exercise> _exercises = [
    Exercise(name: 'Bench Press', sets: 4, reps: 8, weight: '80kg'),
    Exercise(name: 'Incline DB Press', sets: 3, reps: 12, weight: '30kg'),
    Exercise(name: 'Lat Pulldown', sets: 4, reps: 10, weight: '65kg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text('${widget.dayData['day']!.toUpperCase()} - ${widget.dayData['focus']!.toUpperCase()}', 
          style: const TextStyle(fontSize: 13, letterSpacing: 1, fontWeight: FontWeight.w400)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _exercises.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fitness_center, size: 64, color: const Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),
                  const Text('No exercises added yet', style: TextStyle(color: Colors.black54)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _exercises.length + 1,
              itemBuilder: (context, index) {
                if (index == _exercises.length) {
                  return const SizedBox(height: 40); // Bottom padding
                }
                final exercise = _exercises[index];
                return _buildExerciseCard(exercise);
              },
            ),
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    IconData exerciseIcon = Icons.fitness_center;
    if (exercise.name.contains('Press')) exerciseIcon = Icons.unfold_more;
    if (exercise.name.contains('Lat')) exerciseIcon = Icons.back_hand;
    if (exercise.name.contains('Squat')) exerciseIcon = Icons.airline_seat_legroom_extra;

    final int setsRemaining = exercise.isCompleted ? 0 : exercise.sets;
    final int repsRemaining = exercise.isCompleted ? 0 : (exercise.sets * exercise.reps);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: exercise.isCompleted ? const Color(0xFF66BB6A).withOpacity(0.3) : const Color(0xFFEEEEEE)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: exercise.isCompleted ? const Color(0xFF66BB6A).withOpacity(0.1) : const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(exerciseIcon, color: exercise.isCompleted ? const Color(0xFF66BB6A) : Colors.black87, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exercise.name, 
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)),
                    const SizedBox(height: 4),
                    Text(
                      exercise.isCompleted 
                        ? 'All sets completed' 
                        : '$setsRemaining sets / $repsRemaining reps to go',
                      style: TextStyle(
                        color: exercise.isCompleted ? const Color(0xFF66BB6A).withOpacity(0.5) : Colors.black87, 
                        fontSize: 13
                      ),
                    ),
                  ],
                ),
              ),
              if (exercise.isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF66BB6A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('DONE', 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10)),
                ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                final bool wasCompleted = exercise.isCompleted;
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetailScreen(exercise: exercise),
                  ),
                );
                if (!wasCompleted && exercise.isCompleted) {
                  MockDataService.incrementWorkoutDone(widget.dayData['day']!);
                }
                setState(() {}); // Refresh to show completed state
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: exercise.isCompleted ? Colors.black38 : const Color(0xFFDC143C)),
                foregroundColor: exercise.isCompleted ? Colors.black87 : const Color(0xFFDC143C),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(exercise.isCompleted ? 'VIEW DETAILS' : 'START EXERCISE', 
                style: const TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
