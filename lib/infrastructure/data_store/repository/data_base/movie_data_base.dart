
import 'package:path/path.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/movie_tables.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';
import 'package:sqflite/sqflite.dart';

import 'login_tables.dart';

/// Create all tables of local database and initialize them
class MovieDataBase {
  Future<Database>? _db;

  static const int _version = 1;



  /// Initialize local database
  Future<Database> getDatabase() async {
    if (_db != null) {
      return _db!;
    }

    _db = _onCreateDatabase();

    return _db!;
  }

  Future<Database> _onCreateDatabase() async {
    final databasePath = join(await getDatabasesPath(), 'movie.db');
    return openDatabase(
      databasePath,
      onCreate: (db, version) async {
        try {
          await db.execute(TableUserAccount.createTable);
          await db.execute(TableMovie.createTable);
          await db.execute(TableType.createTable);

        } on Exception catch (e, stack) {
          logInfo('Exception', e);
        }


      },
      onUpgrade: (db, oldVersion, newVersion) async {
       logInfo('Data base','Upgrading database from $oldVersion to $newVersion');

        try {
          if (oldVersion < 2) {
            logInfo('Upgrade to version 2', newVersion);
            await _upgradeToVersion1(db);
          }

        } on Exception catch (e, stack) {
          logInfo('Exception', e);
        }
      },
      version: _version,
    );
  }


  Future<void> _upgradeToVersion1(Database db) async {
    try {
      await db.execute(TableUserAccount.createTable);
      await db.execute(TableMovie.createTable);
      await db.execute(TableType.createTable);


    } on Exception catch (e, stack) {
      logInfo('Exception', e);
    }
  }


}