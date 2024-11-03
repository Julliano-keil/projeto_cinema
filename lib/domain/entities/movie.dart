class Movie {
  final int id;
  final int idType;
  final String title;
  final String date;
  final String description;
  final List<String> showTimes;
  final List<String> showSeat;

  Movie({
    required this.id,
    required this.idType,
    required this.title,
    required this.description,
    required this.showTimes,
    required this.showSeat,
    required this.date,
  });
}

/// Entity representing a type with id and label.
class TypeMovie {
  final int id;
  final String label;

  TypeMovie({
    required this.id,
    required this.label,
  });
}

class DetailArguments {
  final Movie movie;
  final String hours;

  DetailArguments({required this.movie, required this.hours});
}

class SelectPriceMovie {
  SelectPriceMovie({
    this.price,
    this.type,
    this.seat,
    this.movieName,
    this.hours,
  });

  final String? type;
  final double? price;
  final String? seat;
  final String? movieName;
  final String? hours;
}
