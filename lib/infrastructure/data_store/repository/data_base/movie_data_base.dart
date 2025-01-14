import 'package:path/path.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/movie_tables.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/sharedPreferences_keys.dart';
import 'login_tables.dart';

/// Create all tables of local database and initialize them
class MovieDataBase {
  Future<Database>? _db;

  static const int _version = 3;

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
          await db.insert(TableUserAccount.tableName, {
          TableUserAccount.email: 'julianokeil277@gmail.com',
          TableUserAccount.password: '@Teste123',
          TableUserAccount.isAdm: 1,
          TableUserAccount.userName: 'juliano keil',
          });

          var prefs = await SharedPreferences.getInstance();
          prefs.setString(SharedPreferencesKeys.email,'julianokeil277@gmail.com');
          prefs.setString(SharedPreferencesKeys.password,'@Teste123');

          await db.execute(TableMovie.createTable);
          await db.execute(TableType.createTable);
          db.insert(
            TableType.tableName,
            {
              TableType.id: 1,
              TableType.label: 'Comedia',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          db.insert(
            TableType.tableName,
            {
              TableType.id: 2,
              TableType.label: 'Terror',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          db.insert(
            TableType.tableName,
            {
              TableType.id: 3,
              TableType.label: 'Ação',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          await db.execute(TableTicket.createTable);
        } on Exception catch (e) {
          logInfo('Exception', e);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        logInfo(
            'Data base', 'Upgrading database from $oldVersion to $newVersion');

        try {
          if (oldVersion < 1) {
            logInfo('Upgrade to version 1', newVersion);
            await _upgradeToVersion1(db);
          }
          if (oldVersion < 2) {
            logInfo('Upgrade to version 2', newVersion);
            await _upgradeToVersion2(db);
          }
          if (oldVersion < 3) {
            logInfo('Upgrade to version 3', newVersion);
            await _upgradeToVersion3(db);
          }
        } on Exception catch (e) {
          logInfo('Exception', e);
        }
      },
      version: _version,
    );
  }

  Future<void> _upgradeToVersion3(Database db) async {
    try {
      await db.execute('''
        ALTER TABLE ${TableUserAccount.tableName}
        ADD COLUMN ${TableUserAccount.isAdm} INTEGER NOT NULL DEFAULT 0;
    ''');

    } on Exception catch (e) {
      logInfo('Exception', e);
    }
  }

  Future<void> _upgradeToVersion2(Database db) async {
    try {
      await db.execute(TableTicket.createTable);
    } on Exception catch (e) {
      logInfo('Exception', e);
    }
  }

  Future<void> _upgradeToVersion1(Database db) async {
    try {
      await db.execute(TableUserAccount.createTable);
      await db.execute(TableMovie.createTable);
      await db.execute(TableType.createTable);
    } on Exception catch (e) {
      logInfo('Exception', e);
    }
  }
}
