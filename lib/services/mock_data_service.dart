import '../models/fitness_models.dart';

class MockDataService {
  static User getCurrentUser() {
    // Toggle this to test different roles
    return User(
      id: 'client_1',
      name: 'Alex Johnson',
      email: 'alex@example.com',
      role: UserRole.client, 
    );
  }

  static final Map<String, List<Meal>> _sessionMeals = {
    'Breakfast': [],
    'Lunch': [],
    'Snacks': [],
    'Dinner': [],
  };

  static final Map<String, int> _sessionStats = {
    'water': 4,
  };

  static final Map<String, int> _workoutProgress = {
    'Monday': 0,
    'Tuesday': 0,
    'Wednesday': 0,
    'Thursday': 0,
    'Friday': 0,
  };

  static List<Meal> getMeals(String category) => _sessionMeals[category] ?? [];
  static void addMeal(String category, Meal meal) => _sessionMeals[category]?.add(meal);
  static void removeMeal(String category, int index) => _sessionMeals[category]?.removeAt(index);

  static int getStat(String key) => _sessionStats[key] ?? 0;
  static void setStat(String key, int value) => _sessionStats[key] = value;

  static int getWorkoutDoneCount(String day) => _workoutProgress[day] ?? 0;
  static void incrementWorkoutDone(String day) {
    if (_workoutProgress.containsKey(day)) {
      _workoutProgress[day] = (_workoutProgress[day] ?? 0) + 1;
    }
  }

  static List<Client> getClients() {
    return [
      Client(
        id: '1',
        name: 'John Doe',
        profileImageUrl: '',
        currentProgram: 'Strength Phase 1',
        dailyStatus: 'Completed [W4 D2]',
        stepCount: 8400,
        stepGoal: 10000,
        alerts: ['PR Achieved!'],
        adherenceRate: 0.95,
        revenue: 150.0,
        caloriesCount: 1850,
        caloriesGoal: 2200,
      ),
      Client(
        id: '2',
        name: 'Jane Smith',
        profileImageUrl: '',
        currentProgram: 'Hypertrophy Split',
        dailyStatus: 'Rest Day',
        stepCount: 4200,
        stepGoal: 8000,
        alerts: ['Nutrition Log Pending'],
        adherenceRate: 0.88,
        revenue: 200.0,
        caloriesCount: 1400,
        caloriesGoal: 1600,
      ),
      Client(
        id: '3',
        name: 'Mike Ross',
        profileImageUrl: '',
        currentProgram: 'Fat Loss GPP',
        dailyStatus: 'Cardio [30 mins]',
        stepCount: 11000,
        stepGoal: 10000,
        alerts: [],
        adherenceRate: 0.92,
        revenue: 175.0,
        caloriesCount: 2100,
        caloriesGoal: 2000,
      ),
    ];
  }
}
