import 'package:flutter/material.dart';

class StatDetailScreen extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatDetailScreen({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text('${title.toUpperCase()} DETAIL',
          style: const TextStyle(fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.w400)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewCard(),
              const SizedBox(height: 24),
              _buildInsightCard(),
              const SizedBox(height: 32),
              const Text('Weekly Comparison', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
              const SizedBox(height: 16),
              _buildChartPlaceholder(),
              const SizedBox(height: 32),
              const Text('Achievements', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
              const SizedBox(height: 16),
              _buildAchievementList(),
              const SizedBox(height: 32),
              const Text('Recent History', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
              const SizedBox(height: 16),
              _buildHistoryItem('Yesterday', value, '+2% from average'),
              _buildHistoryItem('2 days ago', value, '-1% from average'),
              _buildHistoryItem('3 days ago', value, '+5% from average'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('HEALTH INSIGHT', style: TextStyle(color: color, fontWeight: FontWeight.w400, fontSize: 10, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(
                  'Your $title is trending upwards. Keep this pace to reach your goal 3 days earlier!',
                  style: const TextStyle(color: Colors.black87, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAchievementItem(Icons.workspace_premium, 'Daily Master'),
        _buildAchievementItem(Icons.bolt, 'Fast Pace'),
        _buildAchievementItem(Icons.stars, 'Record Breaker'),
      ],
    );
  }

  Widget _buildAchievementItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: Icon(icon, color: color.withOpacity(0.5), size: 20),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 10)),
      ],
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 48),
          const SizedBox(height: 24),
          Text(
            value,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w300, letterSpacing: -1),
          ),
          Text(
            'Current $title',
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final double heightFactor = (0.4 + (index * 0.1)) % 1.0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 30,
                height: 120 * heightFactor,
                decoration: BoxDecoration(
                  color: index == 6 ? color : color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                style: const TextStyle(color: Colors.black38, fontSize: 12),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHistoryItem(String day, String val, String trend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(trend, style: const TextStyle(color: Colors.black38, fontSize: 12)),
            ],
          ),
          Text(val, style: TextStyle(color: color, fontWeight: FontWeight.w300, fontSize: 18)),
        ],
      ),
    );
  }
}
