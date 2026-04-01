import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/fitness_models.dart';
import '../workouts/workout_builder_screen.dart';
import '../nutrition/nutrition_planner_screen.dart';

class ClientProfileScreen extends StatelessWidget {
  final Client client;

  const ClientProfileScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
        actions: [
          IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickActions(context),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            _buildPerformanceGraph('Overall Progress'),
            const SizedBox(height: 24),
            _buildMetricGrid(),
            const SizedBox(height: 32),
            const Text('Recent Logs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildLogList(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(context, Icons.add_task, 'Workout'),
        _buildActionButton(context, Icons.restaurant, 'Nutrition'),
        _buildActionButton(context, Icons.photo_library, 'Photos'),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () {
        if (label == 'Workout') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutBuilderScreen()));
        } else if (label == 'Nutrition') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NutritionPlannerScreen()));
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: Icon(icon, color: const Color(0xFFDC143C)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black87)),
      ],
    ),
  );
}

  Widget _buildPerformanceGraph(String title) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87)),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (v) => FlLine(color: Colors.black12)),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 100),
                      const FlSpot(1, 105),
                      const FlSpot(2, 102),
                      const FlSpot(3, 110),
                      const FlSpot(4, 115),
                    ],
                    isCurved: true,
                    color: const Color(0xFFDC143C),
                    barWidth: 4,
                    dotData: FlDotData(show: true, getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(color: Colors.white, strokeWidth: 2, strokeColor: const Color(0xFFDC143C), radius: 4)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDeepDiveCard('Steps (Avg)', '9,200', '+10% vs last week')),
            const SizedBox(width: 12),
            Expanded(child: _buildDeepDiveCard('Calories (Avg)', '${client.caloriesCount}', 'Within limit')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDeepDiveCard('Body Weight', '78.5 kg', '-0.5 kg this week')),
            const SizedBox(width: 12),
            Expanded(child: _buildDeepDiveCard('Sleep (Avg)', '7.2h', 'Needs improvement')),
          ],
        ),
      ],
    );
  }

  Widget _buildDeepDiveCard(String label, String value, String trend) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 10)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(trend, style: TextStyle(color: trend.contains('+') ? const Color(0xFFDC143C) : Colors.black54, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildLogList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.history, color: Colors.black54, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upper Body A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('March 14, 2026', style: TextStyle(color: Colors.black54, fontSize: 10)),
                  ],
                ),
              ),
              const Text('60 mins', style: TextStyle(color: Color(0xFFDC143C), fontSize: 12)),
              const Icon(Icons.chevron_right, color: Colors.black38),
            ],
          ),
        );
      },
    );
  }
}
