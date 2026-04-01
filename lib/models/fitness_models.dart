enum UserRole { coach, client }

class DailyTask {
  final String title;
  bool isCompleted;

  DailyTask({required this.title, this.isCompleted = false});
}

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class Client {
  final String id;
  final String name;
  final String profileImageUrl;
  final String currentProgram;
  final String dailyStatus;
  final int stepCount;
  final int stepGoal;
  final List<String> alerts;
  final double adherenceRate;
  final double revenue;
  final int caloriesCount;
  final int caloriesGoal;

  Client({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.currentProgram,
    required this.dailyStatus,
    required this.stepCount,
    required this.stepGoal,
    required this.alerts,
    required this.adherenceRate,
    required this.revenue,
    required this.caloriesCount,
    required this.caloriesGoal,
  });
}

class Meal {
  final String name;
  final int calories;
  final String protein;
  final String carbs;
  final String fats;

  Meal({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}

class WorkoutProgram {
  final String id;
  final String name;
  final List<WorkoutSession> sessions;

  WorkoutProgram({required this.id, required this.name, required this.sessions});
}

class WorkoutSession {
  final String day;
  final String focus;
  final List<Exercise> exercises;

  WorkoutSession({required this.day, required this.focus, required this.exercises});
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String? weight;
  final String? videoId;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
    this.videoId,
    this.isCompleted = false,
  });
}
