import 'package:meal_tracker/domain/entities/meal.dart';
import 'package:meal_tracker/domain/repositories/meal_repository.dart';

class GetMeals {
  final MealRepository repository;

  GetMeals(this.repository);

  Future<List<Meal>> call() => repository.getMeals();
}
