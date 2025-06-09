// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../domain/entities/meal.dart';
// import '../providers/meal_provider.dart';
// import 'dart:io';

// class MealHistoryScreen extends ConsumerWidget {
//   const MealHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mealsAsync = ref.watch(mealListProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Meal History')),
//       body: mealsAsync.when(
//         data: (meals) {
//           if (meals.isEmpty)
//             return const Center(child: Text('No meals logged.'));

//           Map<String, List<Meal>> grouped = {};
//           for (var meal in meals) {
//             final date = meal.date.toIso8601String().split('T')[0];
//             grouped.putIfAbsent(date, () => []).add(meal);
//           }

//           final sortedKeys = grouped.keys.toList()
//             ..sort((a, b) => b.compareTo(a));

//           return ListView.builder(
//             itemCount: sortedKeys.length,
//             itemBuilder: (context, i) {
//               final date = sortedKeys[i];
//               final dayMeals = grouped[date]!;
//               return ExpansionTile(
//                 title: Text(date),
//                 children: dayMeals
//                     .map((m) => ListTile(
//                           leading: Image.file(File(m.imagePath),
//                               width: 50, height: 50),
//                           title: Text(m.name),
//                           subtitle: Text(m.type),
//                         ))
//                     .toList(),
//               );
//             },
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, st) => Center(child: Text('Error: $e')),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../providers/meal_provider.dart';
import 'dart:io';

class MealHistoryScreen extends ConsumerStatefulWidget {
  const MealHistoryScreen({super.key});

  @override
  ConsumerState<MealHistoryScreen> createState() => _MealHistoryScreenState();
}

class _MealHistoryScreenState extends ConsumerState<MealHistoryScreen> {
  String _searchQuery = '';

  Future<void> _refresh() async {
    ref.refresh(mealListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final mealsAsync = ref.watch(mealListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Meal History',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by meal name',
                prefixIcon: Icon(Icons.search, color: Colors.redAccent),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
              ),
              onChanged:
                  (value) => setState(() => _searchQuery = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: mealsAsync.when(
              data: (meals) {
                if (meals.isEmpty) {
                  return const Center(child: Text('No meals logged.'));
                }

                final filtered =
                    meals
                        .where(
                          (m) => m.name.toLowerCase().contains(_searchQuery),
                        )
                        .toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No results found.'));
                }

                Map<String, List<Meal>> grouped = {};
                for (var meal in filtered) {
                  final date = meal.date.toIso8601String().split('T')[0];
                  grouped.putIfAbsent(date, () => []).add(meal);
                }

                final sortedKeys =
                    grouped.keys.toList()..sort((a, b) => b.compareTo(a));

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: sortedKeys.length,
                    itemBuilder: (context, i) {
                      final date = sortedKeys[i];
                      final dayMeals = grouped[date]!;
                      return ExpansionTile(
                        title: Text(date),
                        children:
                            dayMeals
                                .map(
                                  (m) => ListTile(
                                    leading: Image.file(
                                      File(m.imagePath),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(m.name),
                                    subtitle: Text(m.type),
                                  ),
                                )
                                .toList(),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
