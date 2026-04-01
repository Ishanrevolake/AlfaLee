import 'package:flutter/material.dart';
import '../../models/fitness_models.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock food database (kcal per 100g)
  final List<Map<String, dynamic>> _foodDb = [
    {'name': 'Chicken Breast', 'kcal': 165, 'p': 31, 'c': 0, 'f': 3.6},
    {'name': 'Brown Rice', 'kcal': 111, 'p': 2.6, 'c': 23, 'f': 0.9},
    {'name': 'Avocado', 'kcal': 160, 'p': 2, 'c': 8.5, 'f': 14.7},
    {'name': 'Greek Yogurt', 'kcal': 59, 'p': 10, 'c': 3.6, 'f': 0.4},
    {'name': 'Egg (Large)', 'kcal': 155, 'p': 13, 'c': 1.1, 'f': 11},
    {'name': 'Oats', 'kcal': 389, 'p': 16.9, 'c': 66, 'f': 6.9},
    {'name': 'Salmon', 'kcal': 208, 'p': 20, 'c': 0, 'f': 13},
    {'name': 'Sweet Potato', 'kcal': 86, 'p': 1.6, 'c': 20, 'f': 0.1},
    {'name': 'Broccoli', 'kcal': 34, 'p': 2.8, 'c': 7, 'f': 0.4},
    {'name': 'Almonds', 'kcal': 579, 'p': 21, 'c': 22, 'f': 49},
  ];

  List<Map<String, dynamic>> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _filteredFoods = _foodDb;
  }

  void _filterSearch(String query) {
    setState(() {
      _filteredFoods = _foodDb
          .where((food) => food['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showAmountSheet(Map<String, dynamic> food) {
    final TextEditingController gramsController = TextEditingController(text: '100');
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(food['name'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close, color: Colors.black54), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 8),
            Text('${food['kcal']} kcal per 100g', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 32),
            const Text('Amount in Grams', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDC143C))),
            const SizedBox(height: 12),
            TextField(
              controller: gramsController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                suffixText: 'g',
                suffixStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.all(24),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final double grams = double.tryParse(gramsController.text) ?? 0;
                  final double ratio = grams / 100;
                  
                  final meal = Meal(
                    name: '${food['name']} (${grams.toInt()}g)',
                    calories: (food['kcal'] * ratio).toInt(),
                    protein: (food['p'] * ratio).toStringAsFixed(1),
                    carbs: (food['c'] * ratio).toStringAsFixed(1),
                    fats: (food['f'] * ratio).toStringAsFixed(1),
                  );
                  
                  Navigator.pop(context); // Close sheet
                  Navigator.pop(context, meal); // Return meal to detail screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC143C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('ADD TO MEAL', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('SEARCH FOOD', style: TextStyle(fontSize: 16, letterSpacing: 1, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSearch,
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search foods (e.g. Chicken)',
                hintStyle: const TextStyle(color: Colors.black38),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFDC143C)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredFoods.length,
              separatorBuilder: (context, index) => Divider(color: const Color(0xFFEEEEEE), height: 1),
              itemBuilder: (context, index) {
                final food = _filteredFoods[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  title: Text(food['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${food['kcal']} kcal / 100g', style: const TextStyle(color: Colors.black54, fontSize: 12)),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDC143C).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Color(0xFFDC143C)),
                      onPressed: () => _showAmountSheet(food),
                    ),
                  ),
                  onTap: () => _showAmountSheet(food),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
