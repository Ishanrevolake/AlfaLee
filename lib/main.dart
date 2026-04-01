import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/nutrition/nutrition_planner_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/workouts/workout_builder_screen.dart';
import 'screens/client_view/client_dashboard_screen.dart';
import 'screens/client_view/client_workout_plan_screen.dart';
import 'services/mock_data_service.dart';
import 'models/fitness_models.dart';
import 'screens/client_view/client_profile_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/communication/chat_screen.dart';
import 'screens/client_view/progress_report_screen.dart';

void main() {
  runApp(const AlfaFitnessApp());
}

class AlfaFitnessApp extends StatelessWidget {
  const AlfaFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alfa Fitness',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = MockDataService.getCurrentUser();
  }

  List<Widget> _getScreens() {
    if (_currentUser.role == UserRole.coach) {
      return [
        const DashboardScreen(),
        const Center(child: Text('Progress Hub (Coach View)')),
        const WorkoutBuilderScreen(),
        const NutritionPlannerScreen(),
      ];
    } else {
      return [
        const ClientDashboardScreen(),
        const ClientWorkoutPlanScreen(),
        const NutritionPlannerScreen(),
        const ChatScreen(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = _getScreens();
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: const Color(0xFFEEEEEE), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          items: _currentUser.role == UserRole.coach 
            ? [
                const BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
                const BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Progress'),
                const BottomNavigationBarItem(icon: Icon(Icons.fitness_center_outlined), label: 'Workouts'),
                const BottomNavigationBarItem(icon: Icon(Icons.restaurant_outlined), label: 'Nutrition'),
              ]
            : [
                const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'DASHBOARD'),
                const BottomNavigationBarItem(icon: Icon(Icons.fitness_center_outlined), label: 'TRAINING'),
                const BottomNavigationBarItem(icon: Icon(Icons.restaurant_outlined), label: 'NUTRITION'),
                const BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'INBOX'),
              ],
        ),
      ),
    );
  }
}
