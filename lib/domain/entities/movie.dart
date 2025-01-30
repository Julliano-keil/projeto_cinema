import 'package:projeto_cinema/infrastructure/util/text_form.dart';

class Movie {
  final int? id;
  final int? idType;
  final String? title;
  final String? date;
  final String? description;
  final String? labelType;
  final List<String>? showTimes;
  final List<String>? showSeat;

  Movie({
    this.id,
    this.idType,
    this.title,
    this.description,
    this.labelType,
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
  final SectionEntity section;

  DetailArguments({required this.movie, required this.section});
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
    this.seatId,
    this.section,
  });

  final int? id;
  final int? movieId;
  final int? seatId;
  final SectionEntity? section;
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
    int? seatId,
    String? type,
    double? price,
    bool? reimbursement,
    int? movieId,
    Movie? movie,
    String? seat,
    String? movieName,
    String? hours,
    SectionEntity? section,
  }) {
    return SelectPriceMovie(
      id: id ?? this.id,
      seatId: seatId ?? this.seatId,
      section: section ?? this.section,
      type: type ?? this.type,
      price: price ?? this.price,
      movieId: movieId ?? this.movieId,
      reimbursement: reimbursement ?? this.reimbursement,
      movie: movie ?? this.movie,
      seat: seat ?? this.seat,
      movieName: movieName ?? this.movieName,
      hours: hours ?? this.hours,
    );
  }
}

class SectionEntity {
  /// Properties
  final int? id;
  final int? idMovie;
  final int? idRoom;
  final bool? reserved;
  final String? date;

  /// Constructor
  SectionEntity({
    this.id,
    this.idMovie,
    this.idRoom,
    this.date,
    this.reserved,
  });

  String? get hoursFormat {
    final dateNotFormat = tryParseDate('dd/MM/yyyy HH:mm', date);

    return tryFormatDate('HH:mm', dateNotFormat);
  }

  @override
  String toString() {
    return 'SectionEntity(id: $id, idMovie: $idMovie, idRoom: $idRoom, reserved: $reserved, date: $date, hoursFormat: $hoursFormat,)';
  }
}

class Room {
  final int? id;
  final String? label;
  final String? local;
  final List<SectionEntity>? sections;

  /// Constructor
  Room({
    this.id,
    this.label,
    this.local,
    this.sections,
  });
}
