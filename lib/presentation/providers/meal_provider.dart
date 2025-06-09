import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_tracker/data/datasources/local_datasource.dart';
import 'package:meal_tracker/data/repositories/meal_repository_impl.dart';
import 'package:meal_tracker/domain/entities/meal.dart';
import 'package:meal_tracker/domain/usercases/add_meal.dart';
import 'package:meal_tracker/domain/usercases/get_meals.dart';

final localDataSourceProvider = Provider((ref) => LocalDataSource());

final mealRepositoryProvider = Provider(
  (ref) => MealRepositoryImpl(ref.read(localDataSourceProvider)),
);

final addMealProvider = Provider(
  (ref) => AddMeal(ref.read(mealRepositoryProvider)),
);

final getMealsProvider = Provider(
  (ref) => GetMeals(ref.read(mealRepositoryProvider)),
);

final mealListProvider = FutureProvider<List<Meal>>((ref) async {
  ref.keepAlive();
  final getmeals = ref.read(getMealsProvider);
  return await getmeals();
});
