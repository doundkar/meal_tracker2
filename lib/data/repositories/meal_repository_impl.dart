import 'package:meal_tracker/data/datasources/local_datasource.dart';
import 'package:meal_tracker/data/models/meal_models.dart';
import 'package:meal_tracker/domain/entities/meal.dart';
import 'package:meal_tracker/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final LocalDataSource localDataSource;

  MealRepositoryImpl(this.localDataSource);

  @override
  Future<void> addMeal(Meal meal) async {
    final model = MealModel(
      id: meal.id,
      name: meal.name,
      type: meal.type,
      date: meal.date,
      imagePath: meal.imagePath,
    );
    await localDataSource.insertMeal(model);
  }

  @override
  Future<List<Meal>> getMeals() async {
    return await localDataSource.getAllMeals();
  }
}