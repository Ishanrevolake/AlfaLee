import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'workout_day_detail_screen.dart';

class WorkoutBuilderScreen extends StatefulWidget {
  const WorkoutBuilderScreen({super.key});

  @override
  State<WorkoutBuilderScreen> createState() => _WorkoutBuilderScreenState();
}

class _WorkoutBuilderScreenState extends State<WorkoutBuilderScreen> {
  final List<String> _templates = ['Strength Base', 'Hypertrophy PPL', 'GPP Fat Loss', 'Olympic Weightlifting'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddWorkoutDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressChart(),
            const SizedBox(height: 32),
            const Text('Template Library', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTemplateCarousel(),
            const SizedBox(height: 32),
            const Text('Current Split', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildSplitEditor(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Training Volume (Last 7 Days)', style: TextStyle(color: Colors.black87, fontSize: 13)),
          const SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: const Color(0xFF42A5F5), width: 12)]),
                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: const Color(0xFF42A5F5), width: 12)]),
                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: const Color(0xFF42A5F5), width: 12)]),
                  BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 6, color: const Color(0xFF42A5F5), width: 12)]),
                  BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 12, color: const Color(0xFF42A5F5), width: 12)]),
                  BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 9, color: const Color(0xFF42A5F5), width: 12)]),
                  BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 11, color: const Color(0xFF42A5F5), width: 12)]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('New Workout Day', style: TextStyle(color: Colors.black)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Day Name',
                labelStyle: TextStyle(color: Colors.black54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
              ),
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Focus',
                labelStyle: TextStyle(color: Colors.black54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.black54))),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plan added')));
              Navigator.pop(context);
            },
            child: const Text('Add', style: TextStyle(color: Color(0xFFDC143C))),
          ),
        ],
      ),
    );
  }

  void _showEditDayDialog(BuildContext context, Map<String, String> day) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Edit ${day['day']}', style: const TextStyle(color: Colors.black)),
        content: TextField(
          decoration: InputDecoration(
            labelText: 'Update Focus',
            labelStyle: const TextStyle(color: Colors.black54),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
            hintText: day['focus'],
            hintStyle: const TextStyle(color: Colors.black12),
          ),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.black54))),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plan updated')));
              Navigator.pop(context);
            },
            child: const Text('Update', style: TextStyle(color: Color(0xFFDC143C))),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCarousel() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _templates.length,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.description, color: Colors.black, size: 18),
                const SizedBox(height: 8),
                Text(_templates[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSplitEditor() {
    final List<Map<String, String>> split = [
      {'day': 'Monday', 'focus': 'Upper Body Power'},
      {'day': 'Tuesday', 'focus': 'Lower Body Power'},
      {'day': 'Wednesday', 'focus': 'Rest / Active Recovery'},
      {'day': 'Thursday', 'focus': 'Upper Body Hypertrophy'},
      {'day': 'Friday', 'focus': 'Lower Body Hypertrophy'},
    ];

    return Column(
      children: split.map((day) => _buildDayTile(day)).toList(),
    );
  }

  Widget _buildDayTile(Map<String, String> day) {
    final bool isRest = day['focus']!.contains('Rest');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutDayDetailScreen(dayData: day),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: isRest ? Colors.black38 : const Color(0xFF66BB6A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day['day']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(day['focus']!, style: TextStyle(color: isRest ? Colors.black38 : Colors.black87, fontSize: 13)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.black38),
              onPressed: () => _showEditDayDialog(context, day),
            ),
          ],
        ),
      ),
    );
  }
}
