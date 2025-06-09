import 'package:meal_tracker/domain/entities/meal.dart';
import 'package:meal_tracker/domain/repositories/meal_repository.dart';

class AddMeal {
  final MealRepository repository;

  AddMeal(this.repository);

  Future<void> call(Meal meal) => repository.addMeal(meal);
}
