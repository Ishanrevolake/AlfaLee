import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';
import '../../services/mock_data_service.dart';
import 'food_search_screen.dart';

class MealDetailScreen extends StatefulWidget {
  final String category;
  final bool isReadOnly;

  const MealDetailScreen({super.key, required this.category, this.isReadOnly = false});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  late List<Meal> _meals;

  @override
  void initState() {
    super.initState();
    _meals = MockDataService.getMeals(widget.category);
  }

  Future<void> _addMeal() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FoodSearchScreen()),
    );

    if (result != null && result is Meal) {
      setState(() {
        MockDataService.addMeal(widget.category, result);
        _meals = MockDataService.getMeals(widget.category);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text('${widget.category.toUpperCase()} DETAILS', 
          style: const TextStyle(fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.w400)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _meals.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Icon(Icons.restaurant_menu, size: 64, color: const Color(0xFFDC143C).withOpacity(0.5)),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _meals.isEmpty && widget.isReadOnly 
                        ? 'No meals assigned for ${widget.category}' 
                        : 'Track your ${widget.category.toLowerCase()} here',
                      style: const TextStyle(color: Colors.black38, fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 32),
                    if (!widget.isReadOnly)
                      SizedBox(
                        width: 180,
                        child: ElevatedButton.icon(
                          onPressed: _addMeal,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('ADD FOOD', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 1)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDC143C),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : Column(
                children: [
                  _buildMealSummary(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _meals.length,
                      itemBuilder: (context, index) {
                        final meal = _meals[index];
                        return _buildMealTile(meal, index);
                      },
                    ),
                  ),
                  if (!widget.isReadOnly) _buildBottomAddButton(),
                ],
              ),
      ),
    );
  }

  Widget _buildMealSummary() {
    int totalCalories = 0;
    int totalProtein = 0;
    int totalCarbs = 0;
    int totalFats = 0;

    if (_meals.isEmpty) {
      // Dummy data for when no meals are added yet, as requested
      totalCalories = 450;
      totalProtein = 32;
      totalCarbs = 45;
      totalFats = 12;
    } else {
      for (var meal in _meals) {
        totalCalories += meal.calories;
        totalProtein += int.tryParse(meal.protein.replaceAll('g', '')) ?? 0;
        totalCarbs += int.tryParse(meal.carbs.replaceAll('g', '')) ?? 0;
        totalFats += int.tryParse(meal.fats.replaceAll('g', '')) ?? 0;
      }
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFDC143C).withOpacity(0.15), Colors.transparent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDC143C).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Meal Total', style: TextStyle(color: Colors.black87, fontSize: 14)),
              Text('$totalCalories kcal', 
                style: const TextStyle(color: Color(0xFFDC143C), fontWeight: FontWeight.w300, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryMacro('Protein', '${totalProtein}g'),
              _buildSummaryMacro('Carbs', '${totalCarbs}g'),
              _buildSummaryMacro('Fats', '${totalFats}g'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMacro(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        Text(label, style: TextStyle(color: Colors.black38, fontSize: 11, fontWeight: FontWeight.w300)),
      ],
    );
  }

  Widget _buildMealTile(Meal meal, int index) {
    final mealCard = Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFDC143C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.fastfood, color: Color(0xFFDC143C), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal.name, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(
                  'P:${meal.protein}g C:${meal.carbs}g F:${meal.fats}g',
                  style: const TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${meal.calories}',
                style: const TextStyle(color: Color(0xFFDC143C), fontWeight: FontWeight.w300, fontSize: 16),
              ),
              const Text('kcal', style: TextStyle(color: Colors.black54, fontSize: 10)),
            ],
          ),
        ],
      ),
    );

    if (widget.isReadOnly) return mealCard;

    return Dismissible(
      key: ValueKey('${meal.name}_${meal.calories}_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Color(0xFFDC143C).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Color(0xFFDC143C), size: 28),
      ),
      onDismissed: (direction) {
        setState(() {
          MockDataService.removeMeal(widget.category, index);
          _meals = MockDataService.getMeals(widget.category);
        });
      },
      child: mealCard,
    );
  }

  Widget _buildBottomAddButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _addMeal,
          icon: const Icon(Icons.add),
          label: const Text('ADD ANOTHER ITEM', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDC143C),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }
}
