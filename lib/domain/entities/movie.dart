class Movie {
  final int? id;
  final int? idType;
  final String? title;
  final String? date;
  final String? description;
  final List<String>? showTimes;
  final List<String>? showSeat;

  Movie({
     this.id,
     this.idType,
     this.title,
     this.description,
     this.showTimes,
     this.showSeat,
     this.date,
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
    this.reimbursement,
    this.movieId,
    this.hours,
    this.movie,
    this.id,
  });

  final int? id;
  final int? movieId;
  final String? type;
  final double? price;
  final bool? reimbursement;
  final Movie? movie;
  final String? seat;
  final String? movieName;
  final String? hours;


  /// Creates a new instance of [SelectPriceMovie] with updated values.
  /// If a property is not specified, it retains the current value.
  SelectPriceMovie copyWith({
    int? id,
    String? type,
    double? price,
    bool? reimbursement,
    int? movieId,
    Movie? movie,
    String? seat,
    String? movieName,
    String? hours,
  }) {
    return SelectPriceMovie(
      id: id ?? this.id,
      type: type ?? this.type,
      price: price ?? this.price,
      movieId:movieId ?? this.movieId,
      reimbursement: reimbursement ?? this.reimbursement,
      movie: movie ?? this.movie,
      seat: seat ?? this.seat,
      movieName: movieName ?? this.movieName,
      hours: hours ?? this.hours,
    );
  }
}
