import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../widgets/progress_meter_widget.dart';

class ProgressReportScreen extends StatelessWidget {
  const ProgressReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('PROGRESS REPORT', 
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400, fontSize: 14)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final meterWidth = math.min(300.0, maxWidth - 48);
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ProgressMeterWidget(width: meterWidth),
                  const SizedBox(height: 48),
                  _buildSectionHeader('Monthly Adherence'),
                  const SizedBox(height: 16),
                  _buildAdherenceCard(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Performance Gains'),
                  const SizedBox(height: 16),
                  _buildPerformanceGrid(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Lifestyle Habits'),
                  const SizedBox(height: 16),
                  _buildHabitList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12, 
          letterSpacing: 1.5, 
          color: Colors.black54, 
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }

  Widget _buildAdherenceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleProgress('Workouts', 0.92, const Color(0xFFDC143C)),
          _buildCircleProgress('Nutrition', 0.85, const Color(0xFF42A5F5)),
          _buildCircleProgress('Sleep', 0.78, Colors.deepPurpleAccent),
        ],
      ),
    );
  }

  Widget _buildCircleProgress(String label, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: color.withOpacity(0.05),
            color: color,
            strokeWidth: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        Text('${(value * 100).toInt()}%', style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }

  Widget _buildPerformanceGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.0,
      children: [
        _buildStatTile('Max Bench', '105 kg', '+5kg this month'),
        _buildStatTile('Avg Pace', '4:52 /km', '-10s improvement'),
        _buildStatTile('Body Fat', '14.2%', '-0.8% change'),
        _buildStatTile('Lean Mass', '68.5 kg', '+1.2kg gain'),
      ],
    );
  }

  Widget _buildStatTile(String label, String val, String trend) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 10)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(val, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 4),
              Text(trend, style: const TextStyle(color: Color(0xFFDC143C), fontSize: 8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHabitList() {
    return Column(
      children: [
        _buildHabitItem('Hydration Goal', '24/30 days', 0.8),
        _buildHabitItem('No Sugar Streak', '12 days', 0.4),
        _buildHabitItem('Daily Steps', '28/30 days', 0.93),
      ],
    );
  }

  Widget _buildHabitItem(String title, String status, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                Text(status, style: const TextStyle(fontSize: 11, color: Colors.black38)),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 2,
                backgroundColor: const Color(0xFFEEEEEE),
                color: const Color(0xFFDC143C).withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
