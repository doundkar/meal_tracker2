class Meal {
  final int? id;
  final String name;
  final String type;
  final DateTime date;
  final String imagePath;

  Meal({
    this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.imagePath,
  });
}
