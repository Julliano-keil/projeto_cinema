import '../../../../domain/entities/movie.dart';

/// Movie table definitions
class TableMovie {
  /// Table name 'movie'
  static const tableName = 'movie';

  /// ID column 'id' (integer, primary key)
  static const id = 'id';

  /// ID column 'id' (integer, primary key)
  static const typeId = 'type_id';

  /// Title column 'title' (text)
  static const title = 'title';

  /// Date column 'date' (text in ISO format)
  static const date = 'date';

  /// Description column 'description' (text)
  static const description = 'description';

  /// Show times column 'show times' (text, stores JSON-encoded list of times)
  static const showTimes = 'show_times';

  /// Show times column 'show times' (text, stores JSON-encoded list of times)
  static const showSeat = 'show_seat';

  /// DDL to create the [Movie] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id          INTEGER PRIMARY KEY AUTOINCREMENT,
    $typeId      INTEGER NOT NULL DEFAULT 0,
    $title       TEXT NOT NULL DEFAULT '',
    $date        TEXT NOT NULL DEFAULT '',
    $description TEXT NOT NULL DEFAULT '',
    $showTimes   TEXT NOT NULL DEFAULT '',
    $showSeat   TEXT NOT NULL DEFAULT '' ,
    UNIQUE($id)
  );
  ''';

  /// Convert a [Movie] object into a Map
  static Map<String, dynamic> toMap(Movie movie) {
    return <String, dynamic>{
      id: movie.id,
      typeId: movie.idType,
      title: movie.title,
      date: movie.date,
      description: movie.description,
      showTimes: movie.showTimes.join(','), // Convert list to a comma-separated string
    };
  }

}


/// Type table definitions
class TableType {
  /// Table name 'type'
  static const tableName = 'type';

  /// ID column 'id' (integer, primary key)
  static const id = 'id';

  /// Label column 'label' (text)
  static const label = 'label';

  /// DDL to create the [Type] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id    INTEGER NOT NULL,
    $label TEXT NOT NULL,
    UNIQUE($label) 
  );
  ''';

  /// Convert a [Type] object into a Map
  static Map<String, dynamic> toMap(TypeMovie type) {
    return <String, dynamic>{
      id: type.id,
      label: type.label,
    };
  }

  /// Convert a Map into a [TypeMovie] object
  static TypeMovie fromMap(Map<String, dynamic> row) {
    return TypeMovie(
      id: row[id],
      label: row[label],
    );
  }
}

/// Ticket table definitions
class TableTicket {
  /// Table name 'ticket'
  static const tableName = 'ticket';

  /// ID column 'id' (integer, primary key)
  static const id = 'id';

  /// Type column 'type' (text)
  static const type = 'type';

  /// Price column 'price' (real)
  static const price = 'price';

  /// Seat column 'seat' (text)
  static const seat = 'seat';

  /// Movie Name column 'movieName' (text)
  static const movieName = 'movieName';

  /// Hours column 'hours' (text)
  static const hours = 'hours';

  /// DDL to create the [Ticket] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id           INTEGER PRIMARY KEY AUTOINCREMENT,
    $type         TEXT NOT NULL DEFAULT '',
    $price        INTEGER NOT NULL DEFAULT 0,
    $seat         TEXT NOT NULL DEFAULT '',
    $movieName    TEXT NOT NULL DEFAULT '',
    $hours        TEXT NOT NULL DEFAULT ''
  );
  ''';

  /// Convert a [Ticket] object into a Map
  static Map<String, dynamic> toMap(SelectPriceMovie ticket) {
    return <String, dynamic>{
      type: ticket.type,
      price: ticket.price,
      seat: ticket.seat,
      movieName: ticket.movieName,
      hours: ticket.hours,
    };
  }

  /// Convert a Map into a [Ticket] object
  static SelectPriceMovie fromMap(Map<String, dynamic> row) {
    return SelectPriceMovie(    type: row[type],
      price: row[price],
      seat: row[seat],
      movieName: row[movieName],
      hours: row[hours],
    );
  }
}





