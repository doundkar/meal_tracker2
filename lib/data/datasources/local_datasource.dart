import 'package:meal_tracker/data/models/meal_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataSource {
  static final LocalDataSource _instance = LocalDataSource._internal();
  factory LocalDataSource() => _instance;
  LocalDataSource._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'meals.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE meals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            type TEXT,
            date TEXT,
            imagePath TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertMeal(MealModel meal) async {
    final db = await database;
    await db.insert('meals', meal.toMap());
  }

  Future<List<MealModel>> getAllMeals() async {
    final db = await database;
    final result = await db.query('meals');
    return result.map((map) => MealModel.fromMap(map)).toList();
  }
}
