class Movie {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final List<String> showTimes;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.showTimes,
    required this.date,
  });
}


/// Entity representing a type with id and label.
class TypeModel {
  final int id;
  final String label;

  TypeModel({
    required this.id,
    required this.label,
  });
}