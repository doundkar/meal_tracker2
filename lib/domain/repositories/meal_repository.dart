import 'package:meal_tracker/domain/entities/meal.dart';

abstract class MealRepository {
  Future<void> addMeal(Meal meal);
  Future<List<Meal>> getMeals();
}
