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

  /// Title column 'title' (text)
  static const date = 'date';

  /// Description column 'description' (text)
  static const description = 'description';

  /// DDL to create the [Movie] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id          INTEGER PRIMARY KEY AUTOINCREMENT,
    $typeId      INTEGER NOT NULL DEFAULT 0,
    $title       TEXT NOT NULL DEFAULT '',
    $date       TEXT NOT NULL DEFAULT '',
    $description TEXT NOT NULL DEFAULT '',
    UNIQUE($id)
  );
  ''';

  /// Convert a [Movie] object into a Map
  static Map<String, dynamic> toMap(Movie movie) {
    return <String, dynamic>{
      id: movie.id,
      typeId: movie.idType,
      title: movie.title,
      description: movie.description,
      // showTimes: movie.showTimes?.join(','), // Convert list to a comma-separated string
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

  /// ID column 'id' (integer, primary key)
  static const idSeat = 'id_seat';

  /// Type column 'type' (text)
  static const idSection = 'id_section';

  /// Price column 'price' (real)
  static const price = 'price';

  /// Seat column 'seat' (text)
  static const reimbursement = 'reimbursement';

  /// DDL to create the [Ticket] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id                   INTEGER PRIMARY KEY AUTOINCREMENT,
    $price                INTEGER NOT NULL DEFAULT 0,
    $idSeat               INTEGER NOT NULL DEFAULT 0,
    $idSection            INTEGER NOT NULL DEFAULT 0,
    $reimbursement        INTEGER NOT NULL DEFAULT 0,
    UNIQUE($id) 
  );
  ''';

  /// Convert a [Ticket] object into a Map
  static Map<String, dynamic> toMap(SelectPriceMovie ticket) {
    return <String, dynamic>{
      price: ticket.price,
      idSection: ticket.section?.id,
      idSeat: ticket.seatId,
      reimbursement: ticket.reimbursement,
    };
  }
}

/// Type table definitions
class TableSection {

  /// Table name 'type'
  static const tableName = 'section';

  /// ID column 'id' (integer, primary key)
  static const id = 'id';

  /// ID column 'id' (integer, primary key)
  static const idMovie = 'id_movie';

  /// ID column 'id' (integer, primary key)
  ///
  static const roomId = 'room_id';

  /// Show times column 'show times' (text, stores JSON-encoded list of times)
  static const hours = 'hours';

  /// DDL to create the [Type] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id                INTEGER PRIMARY KEY AUTOINCREMENT,
    $idMovie           INTEGER NOT NULL,
    $roomId            INTEGER NOT NULL,
    $hours             TEXT NOT NULL DEFAULT '',
    UNIQUE($id) 
  );
  ''';

  /// Convert a [Type] object into a Map
  static Map<String, dynamic> toMap(SectionEntity section) {
    return <String, dynamic>{
      id: section.id,
      hours: section.date
    };
  }

}

/// Type table definitions
class TableSeat {

  /// Table name 'seat'
  static const tableName = 'seat';

  /// ID column 'id' (integer, primary key)
  static const id = 'id';

  /// ID column 'id' (integer, primary key)
  static const roomId = 'room_id';

  /// Label column 'label' (text)
  static const label = 'label';

  /// Label column 'label' (text)
  static const statusCode = 'status_code';

  /// DDL to create the [seat] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id                INTEGER PRIMARY KEY AUTOINCREMENT,
    $label             TEXT NOT NULL,
    $roomId            INTEGER NOT NULL,
    $statusCode        INTEGER NOT NULL DEFAULT 0,
    UNIQUE($id) 
  );
  ''';

}

/// Type table definitions
class TableRoom{
  /// Table name 'seat'
  static const tableName = 'room';

  /// ID column 'id' (integer, primary key)
  static const id = 'id';

  /// Label column 'label' (text)
  static const label = 'label';

  /// Label column 'label' (text)
  static const local = 'local';

  /// DDL to create the [Type] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id         INTEGER PRIMARY KEY AUTOINCREMENT,
    $label      TEXT NOT NULL,
    $local      TEXT NOT NULL,
    UNIQUE($id) 
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






