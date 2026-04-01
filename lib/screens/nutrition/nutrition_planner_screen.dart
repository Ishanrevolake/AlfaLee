import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../services/mock_data_service.dart';
import 'meal_detail_screen.dart';
import 'dart:math' as math;

class NutritionPlannerScreen extends StatefulWidget {
  const NutritionPlannerScreen({super.key});

  @override
  State<NutritionPlannerScreen> createState() => _NutritionPlannerScreenState();
}

class _NutritionPlannerScreenState extends State<NutritionPlannerScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('NUTRITION', 
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400, fontSize: 13)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMacroCards(),
              const SizedBox(height: 16),
              _buildDailyCaloriesCard(),
              const SizedBox(height: 24),
              _buildNutritionCalendar(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
                child: Text('DAILY MEALS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1.5)),
              ),
              _buildVerticalMealList(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text('SUGGESTED RECIPES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              _buildRecipeList(),
              const SizedBox(height: 24),
              _buildNutritionTip(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNewMacroCard('Carbs', '35 / 141g', 0.25, const Color(0xFF00E5FF)),
        _buildNewMacroCard('Fat', '6 / 47g', 0.15, const Color(0xFFAEEA00)),
        _buildNewMacroCard('Protein', '11 / 106g', 0.1, const Color(0xFFFFA726)),
      ],
    );
  }

  Widget _buildNewMacroCard(String title, String value, double progress, Color headerColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: const Color(0xFFEEEEEE),
                      color: headerColor,
                    ),
                  ),
                  Icon(Icons.check, color: const Color(0xFFE0E0E0), size: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyCaloriesCard() {
    String dayLabel = isSameDay(_selectedDay, DateTime.now()) 
        ? 'Today' 
        : '${_selectedDay?.day}/${_selectedDay?.month}';
        
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dayLabel, style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              const Text('255 kcal', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.week, // Force week view
        availableCalendarFormats: const {CalendarFormat.week: 'Week'},
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
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
            color: const Color(0xFFDC143C).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Colors.black54, fontSize: 12),
          weekendStyle: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildVerticalMealList() {
    return Column(
      children: [
        _buildMealCard('Breakfast', '0 kcal'),
        _buildMealCard('Lunch', '0 kcal'),
        _buildMealCard('Snacks', '0 kcal'),
        _buildMealCard('Dinner', '0 kcal'),
      ],
    );
  }

  Widget _buildMealCard(String title, String kcal) {
    // Determine image and meal name based on title to match the mockup
    String imageUrl = 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?q=80&w=200&auto=format&fit=crop';
    String mealName = 'Mango Smoothie';
    if (title.toLowerCase() == 'lunch') {
      imageUrl = 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=200&auto=format&fit=crop';
      mealName = 'Quinoa Bowl';
    } else if (title.toLowerCase() == 'dinner') {
      imageUrl = 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop';
      mealName = 'Avocado Toast';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MealDetailScreen(category: title)),
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 90,
                    color: const Color(0xFFEEEEEE),
                    child: const Icon(Icons.fastfood, color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 10)),
                          const Icon(Icons.favorite, color: Color(0xFF00E5FF), size: 14), // Cyan heart
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        mealName,
                        style: const TextStyle(
                          color: Color(0xFF0F172A), // Dark navy
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.blueGrey),
                onPressed: () => _showMealOptions(context, title),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showMealOptions(BuildContext context, String mealName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetOption('Remove from favourites', Icons.favorite, () {
                Navigator.pop(context);
              }),
              const Divider(color: Color(0xFFE0E0E0), height: 1),
              _buildBottomSheetOption('Switch Recipe', Icons.swap_horiz, () {
                Navigator.pop(context);
              }),
              const Divider(color: Color(0xFFE0E0E0), height: 1),
              _buildBottomSheetOption('Remove from meal plan', Icons.delete, () {
                Navigator.pop(context);
              }),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('DONE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(text, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600, fontSize: 16)),
      trailing: Icon(icon, color: const Color(0xFF0F172A)),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    );
  }

  Widget _buildRecipeList() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRecipeCard('Avocado Toast', '240 kcal', '12 min', 'https://images.unsplash.com/photo-1525351484163-7529414344d8?q=80&w=200&auto=format&fit=crop'),
          _buildRecipeCard('Quinoa Bowl', '350 kcal', '20 min', 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=200&auto=format&fit=crop'),
          _buildRecipeCard('Berry Smoothie', '180 kcal', '5 min', 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?q=80&w=200&auto=format&fit=crop'),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(String title, String kcal, String time, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 80, width: double.infinity, fit: BoxFit.cover, 
              errorBuilder: (c, e, s) => Container(height: 80, color: const Color(0xFFEEEEEE))),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kcal, style: const TextStyle(color: Colors.black38, fontSize: 10)),
                    Text(time, style: const TextStyle(color: Colors.black38, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildNutritionTip() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDC143C).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC143C).withOpacity(0.05)),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Color(0xFFDC143C), size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Drinking 500ml of water before meals can boost metabolism by 30%.',
              style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
