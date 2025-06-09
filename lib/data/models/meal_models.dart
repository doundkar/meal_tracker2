import 'package:meal_tracker/domain/entities/meal.dart';

class MealModel extends Meal {
  MealModel({
    int? id,
    required String name,
    required String type,
    required DateTime date,
    required String imagePath,
  }) : super(id: id, name: name, type: type, date: date, imagePath: imagePath);

  factory MealModel.fromMap(Map<String, dynamic> map) => MealModel(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        date: DateTime.parse(map['date']),
        imagePath: map['imagePath'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'date': date.toIso8601String(),
        'imagePath': imagePath,
      };
}