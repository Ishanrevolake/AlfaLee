import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';
import 'exercise_detail_screen.dart';

class WorkoutDayDetailScreen extends StatefulWidget {
  final Map<String, String>? dayData;
  final bool isReadOnly;

  const WorkoutDayDetailScreen({super.key, this.dayData, this.isReadOnly = false});

  @override
  State<WorkoutDayDetailScreen> createState() => _WorkoutDayDetailScreenState();
}

class _WorkoutDayDetailScreenState extends State<WorkoutDayDetailScreen> {
  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Warm Up',
      'hasSkip': true,
      'isSkipActive': false,
      'trailingIcon': null,
      'exercises': [
        {'name': 'Deep Squat To Extension', 'desc': '2 ROUNDS | 20 SECONDS', 'isCompleted': false},
        {'name': 'Low Lateral Lunge', 'desc': '2 ROUNDS | 20 SECONDS', 'isCompleted': false},
        {'name': 'Hip 90/90s', 'desc': '2 ROUNDS | 20 SECONDS', 'isCompleted': false},
        {'name': 'Resistance Band Kick Backs', 'desc': '2 ROUNDS | 20 SECONDS EACH SIDE', 'isCompleted': false},
      ],
    },
    {
      'title': 'Superset',
      'hasSkip': false,
      'trailingIcon': Icons.help_outline,
      'exercises': [
        {'name': 'Dumbbell RDL Deadlift', 'desc': '4 SETS | 10 REPS', 'isCompleted': false},
        {'name': 'Dumbbell Sumo Squat', 'desc': '4 SETS | 10 REPS', 'isCompleted': false},
        {'name': 'Leg Press', 'desc': '3 SETS | 12 REPS', 'isCompleted': false},
        {'name': 'Walking Lunges', 'desc': '3 SETS | 20 STEPS', 'isCompleted': false},
        {'name': 'Seated Calf Raises', 'desc': '4 SETS | 15 REPS', 'isCompleted': false},
      ],
    }
  ];

  bool _isExerciseActive(Map<String, dynamic> targetEx) {
    for (var section in _sections) {
      if (section['isSkipActive'] == true) continue;
      for (var ex in section['exercises']) {
        if (ex['isCompleted'] != true) {
          return ex == targetEx;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFC),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Color(0xFF121B28), size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Lower Body Build',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF121B28),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share, color: Color(0xFF121B28), size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Color(0xFF121B28), size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: _sections.length,
          itemBuilder: (context, index) {
            return _buildSection(_sections[index]);
          },
        ),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    final List exercises = section['exercises'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section['title'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF121B28),
                ),
              ),
              Row(
                children: [
                  if (section['hasSkip'] == true) ...[
                    const Text('SKIP', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 24,
                      width: 40,
                      child: Switch(
                        value: section['isSkipActive'] ?? false,
                        onChanged: (val) {
                          setState(() {
                            section['isSkipActive'] = val;
                          });
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                  if (section['trailingIcon'] != null) ...[
                    Icon(section['trailingIcon'], color: Colors.black54, size: 20),
                  ]
                ],
              ),
            ],
          ),
        ),
        if (exercises.isNotEmpty && section['isSkipActive'] != true)
          Container(
            color: Colors.white,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exercises.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFEEEEEE), indent: 80),
              itemBuilder: (context, index) {
                final ex = exercises[index];
                final isActive = _isExerciseActive(ex);
                return Stack(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ex['isCompleted'] == true 
                            ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
                            : const Icon(Icons.fitness_center, color: Colors.black26),
                      ),
                      title: Text(
                        ex['name'],
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF121B28)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          ex['desc'],
                          style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
                        ),
                      ),
                      trailing: ex['isCompleted'] == true 
                          ? Text('DONE', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700, fontSize: 11))
                          : const Icon(Icons.more_horiz, color: Colors.black38),
                      onTap: () async {
                        // Navigate to exercise detail screen and await true response
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailScreen(
                              exercise: Exercise(
                                name: ex['name'],
                                sets: 4,
                                reps: 10,
                              ),
                              onDone: () {
                                setState(() {
                                  ex['isCompleted'] = true;
                                });
                              },
                            ),
                          ),
                        );
                        if (result == true) {
                          setState(() {
                            ex['isCompleted'] = true;
                          });
                        }
                      },
                    ),
                    if (isActive || ex['isCompleted'] == true)
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        if (exercises.isEmpty)
          const Divider(height: 1, color: Color(0xFFEEEEEE)), // Bottom border for empty sections
      ],
    );
  }
}
