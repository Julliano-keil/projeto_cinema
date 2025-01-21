import 'package:projeto_cinema/domain/entities/sharedPreferences_keys.dart';
import 'package:projeto_cinema/domain/entities/user.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/login_tables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../interface/login_interface_repository.dart';
import 'data_base/movie_data_base.dart';

LoginInterfaceRepository newLoginInterfaceRepository(
  MovieDataBase movieDataBase,
) {
  return _LoginInterfaceRepository(movieDataBase);
}

class _LoginInterfaceRepository implements LoginInterfaceRepository {
  _LoginInterfaceRepository(this._movieData);

  final MovieDataBase _movieData;

  @override
  Future<void> registerUser(UserAccount userAccount) async {
    final db = await _movieData.getDatabase();

    db.insert(TableUserAccount.tableName, TableUserAccount.toMap(userAccount),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<UserAccount?> getUser(UserAccount userAccount) async {
    final db = await _movieData.getDatabase();

    var query = '''
    SELECT ${TableUserAccount.id} as id,
    ${TableUserAccount.userName} as name,
    ${TableUserAccount.email} as email,
    ${TableUserAccount.isAdm} as adm,
    ${TableUserAccount.password} as password
    FROM ${TableUserAccount.tableName} 
    WHERE ${TableUserAccount.email} = '${userAccount.email}' AND ${TableUserAccount.password} = '${userAccount.password}';
    ''';

    final result = await db.rawQuery(query);

    UserAccount? userAccountQuery;

    for (final item in result) {
      userAccountQuery = UserAccount(
          name: item['name'] as String,
          email: item['email'] as String,
          isAdm: item['adm'] == 1,
          password: item['password'] as String);
    }
    var prefs = await SharedPreferences.getInstance();

    if (userAccountQuery?.isAdm ?? false) {
      await prefs.setBool(SharedPreferencesKeys.isAdm, true);
    }
    if (!(userAccountQuery?.isAdm ?? false)) {
      await prefs.setBool(SharedPreferencesKeys.isAdm, false);
    }

    return userAccountQuery;
  }
}
