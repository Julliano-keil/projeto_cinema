import '../../../../domain/entities/user.dart';

/// UserAccount table definitions
class TableUserAccount {
  /// Table name 'user_account'
  static const tableName = 'user_account';

  /// Email column 'email' (text)
  static const id = 'id';

  /// Email column 'email' (text)
  static const email = 'email';

  /// Password column 'password' (text)
  static const password = 'password';

  /// Password column 'name' (text)
  static const userName = 'name';

  /// DDL to create the [UserAccount] table
  static const createTable = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    $id       INTEGER  PRIMARY KEY AUTOINCREMENT,
    $email    TEXT NOT NULL DEFAULT '',
    $password TEXT NOT NULL DEFAULT '',
    $userName TEXT NOT NULL DEFAULT ''
  );
  ''';

  /// Convert a [UserAccount] object into a Map
  static Map<String, dynamic> toMap(UserAccount account) {
    return <String, dynamic>{
      email: account.email,
      password: account.password,
      userName: account.name
    };
  }

  // /// Convert a map into a [UserAccount] object
  // static UserAccount fromMap(Map<String, dynamic> row) {
  //   return UserAccount(
  //     email: row[email] as String,
  //     password: row[password] as String,
  //     name: row[userName] as String,
  //   );
  // }
}
