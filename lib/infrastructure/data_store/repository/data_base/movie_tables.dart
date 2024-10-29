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

  /// DDL to create the [Movie] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id          INTEGER PRIMARY KEY AUTOINCREMENT,
    $typeId      INTEGER NOT NULL DEFAULT 0,
    $title       TEXT NOT NULL DEFAULT '',
    $date        TEXT NOT NULL DEFAULT '',
    $description TEXT NOT NULL DEFAULT '',
    $showTimes   TEXT NOT NULL DEFAULT ''
  );
  ''';

  /// Convert a [Movie] object into a Map
  static Map<String, dynamic> toMap(Movie movie) {
    return <String, dynamic>{
      id: movie.id,
      title: movie.title,
      date: movie.date.toIso8601String(),
      description: movie.description,
      showTimes: movie.showTimes.join(','), // Convert list to a comma-separated string
    };
  }

  /// Convert a Map into a [Movie] object
  static Movie fromMap(Map<String, dynamic> row) {
    return Movie(
      id: row[id].toString(),
      title: row[title],
      date: DateTime.parse(row[date]),
      description: row[description],
      showTimes: (row[showTimes] as String).split(','), // Convert back to a list
    );
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
    $id    INTEGER PRIMARY KEY AUTOINCREMENT,
    $label TEXT NOT NULL
  );
  ''';

  /// Convert a [Type] object into a Map
  static Map<String, dynamic> toMap(TypeModel type) {
    return <String, dynamic>{
      id: type.id,
      label: type.label,
    };
  }

  /// Convert a Map into a [TypeModel] object
  static TypeModel fromMap(Map<String, dynamic> row) {
    return TypeModel(
      id: row[id],
      label: row[label],
    );
  }
}



