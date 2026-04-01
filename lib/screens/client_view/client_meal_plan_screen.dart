import 'package:flutter/material.dart';
import '../nutrition/meal_detail_screen.dart';

class ClientMealPlanScreen extends StatelessWidget {
  const ClientMealPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Nutrition Plan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daily Meals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _buildMealCategoryCard(context, 'Breakfast', Icons.wb_sunny_outlined),
                _buildMealCategoryCard(context, 'Lunch', Icons.light_mode_outlined),
                _buildMealCategoryCard(context, 'Dinner', Icons.nights_stay_outlined),
                _buildMealCategoryCard(context, 'Snacks', Icons.cookie_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCategoryCard(BuildContext context, String title, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealDetailScreen(category: title, isReadOnly: true)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFDC143C), size: 24),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            const Text('View meals', style: TextStyle(color: Colors.black38, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
