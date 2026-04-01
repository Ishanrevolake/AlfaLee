import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../services/mock_data_service.dart';
import '../../models/fitness_models.dart';
import 'client_workout_plan_screen.dart';
import 'stat_detail_screen.dart';
import 'progress_report_screen.dart';
import 'client_profile_screen.dart';
import '../../widgets/progress_meter_widget.dart';
import 'dart:math' as math;

class ClientDashboardScreen extends StatefulWidget {
  const ClientDashboardScreen({super.key});

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final List<DailyTask> _dailyTasks = [
    DailyTask(title: 'Complete Monday Workout'),
    DailyTask(title: 'Meet Calorie Goal'),
    DailyTask(title: 'Hit Step Goal (10k)'),
    DailyTask(title: 'Morning Mobility Flow'),
  ];

  double get _completionRate {
    if (_dailyTasks.isEmpty) return 0;
    final completed = _dailyTasks.where((t) => t.isCompleted).length;
    return completed / _dailyTasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildExpandableCalendar(),
              const SizedBox(height: 20),
              _buildTodaysWorkoutCard(),
              const SizedBox(height: 32),
              _buildProgressMeterSection(),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('DAILY STATS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black54, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildStatsGrid(),
              const SizedBox(height: 12),
              _buildAdditionalStatsGrid(),
              const SizedBox(height: 24),
              _buildWeeklyProgressCard(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text("COACH'S TIP", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black54, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildCoachTip(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('RECENTLY COMPLETED', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black54, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildRecentlyCompleted(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientProfileScreen()));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: const Icon(Icons.person_outline, color: Color(0xFFDC143C), size: 24),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'John',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Sunday, 15 March',
                style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, size: 24, color: Colors.black87),
              onPressed: () {},
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFDC143C),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandableCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: const HeaderStyle(
          formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 12),
          formatButtonDecoration: BoxDecoration(
            color: Color(0xFFDC143C),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: const TextStyle(color: Colors.black87),
          weekendTextStyle: const TextStyle(color: Colors.black54),
          selectedDecoration: const BoxDecoration(
            color: Color(0xFFDC143C),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Color(0xFFDC143C),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: const TextStyle(color: Colors.white),
          todayTextStyle: const TextStyle(color: Colors.white),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.black54, fontSize: 12),
          weekendStyle: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }

 

 

  Widget _buildProgressMeterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OVERALL PROGRESS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black54, letterSpacing: 1.5)),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final meterWidth = math.min(300.0, maxWidth);
              return Center(child: ProgressMeterWidget(width: meterWidth));
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProgressReportScreen()));
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: const Color(0xFFE0E0E0)),
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('VIEW ALL ANALYTICS', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1.0, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysWorkoutCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's workout",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFF3B4856), // Base slate color
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Workout Image
              Image.network(
                'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    width: double.infinity,
                    color: const Color(0xFF2C3E50),
                    child: const Icon(Icons.fitness_center, size: 50, color: Colors.white24),
                  );
                },
              ),
              // Card Details
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4A5568), Color(0xFF2D3748)],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Functional Full Body',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Week 6 | 45-60 mins',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientWorkoutPlanScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A), // Dark navy for button
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('START', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Steps', '8,432', Icons.directions_walk, Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Calories', '1,240', Icons.local_fire_department, Colors.orange)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.03),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatDetailScreen(
                  title: title,
                  value: value,
                  icon: icon,
                  color: color,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: color, size: 20),
                    const Icon(Icons.arrow_forward_ios, color: Colors.black12, size: 10),
                  ],
                ),
                const SizedBox(height: 12),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: -0.5)),
                Text(title, style: TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalStatsGrid() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Sleep', '7h 45m', Icons.bedtime_outlined, Colors.deepPurpleAccent)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Active', '42 min', Icons.timer_outlined, const Color(0xFFDC143C))),
      ],
    );
  }

  Widget _buildWeeklyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Workout Streak', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black87)),
              Text('${(_completionRate * 100).toInt()}%', 
                style: const TextStyle(color: Color(0xFFDC143C), fontWeight: FontWeight.w300)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
              final isDone = day == 'M' || day == 'T' || day == 'W';
              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? const Color(0xFFDC143C) : Colors.transparent,
                      border: Border.all(color: isDone ? const Color(0xFFDC143C) : Colors.black12),
                    ),
                    child: isDone ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                  ),
                  const SizedBox(height: 8),
                  Text(day, style: const TextStyle(color: Colors.black54, fontSize: 10)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCoachTip() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFDC143C).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC143C).withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFDC143C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.lightbulb_outline, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pro Tip', style: TextStyle(color: Color(0xFFDC143C), fontWeight: FontWeight.w400, fontSize: 11)),
                SizedBox(height: 4),
                Text(
                  'Focus on eccentric control during your Lat Pulldowns today for better muscle fiber engagement.',
                  style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyCompleted() {
    return Column(
      children: [
        _buildRecentItem('Bench Press', '4 sets • 80kg', '2h ago'),
        _buildRecentItem('Protein Shake', '350 kcal • 30g P', '4h ago'),
      ],
    );
  }

  Widget _buildRecentItem(String title, String subtitle, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Color(0xFFDC143C), size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                Text(subtitle, style: TextStyle(color: Colors.black54, fontSize: 11)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.black38, fontSize: 11)),
        ],
      ),
    );
  }
}
