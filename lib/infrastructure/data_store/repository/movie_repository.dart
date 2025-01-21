import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/movie_tables.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';
import 'package:sqflite/sqflite.dart';

import '../interface/movie_interface_repository.dart';
import 'data_base/movie_data_base.dart';

MovieRepository newMovieRepository(
  MovieDataBase movieDataBase,
) {
  return _MovieRepository(movieDataBase);
}

class _MovieRepository implements MovieRepository {
  _MovieRepository(this._movieData);

  final MovieDataBase _movieData;

  @override
  Future<List<Movie>> getMovie() async {
    try {
      final db = await _movieData.getDatabase();


      var query = '''
    SELECT m.${TableMovie.id}          as id,
           m.${TableMovie.title}       as title,
           m.${TableMovie.description} as description,
           m.${TableMovie.date}        as date,
           m.${TableMovie.typeId}      as type_id,
           t.${TableType.label}        as type_label
      FROM ${TableMovie.tableName} m
     INNER JOIN ${TableType.tableName} t ON t.${TableType.id} = m.${TableMovie.typeId}
       ''';

      final result = await db.rawQuery(query);

      final listMovie = <Movie>[];

      for (final item in result) {

        listMovie.add(
          Movie(
            id: item['id'] as int,
            idType: item['type_id'] as int,
            title: item['title'] as String,
            date: item['date'] as String,
            description: item['description'] as String,
            labelType: item['type_label'] as String,
          ),
        );
      }

      return listMovie;
    } on Exception catch (e) {
      logInfo('Error in select movie', e);
    }
    return [];
  }

  @override
  Future<List<TypeMovie>> getTypeMovie() async {
    final db = await _movieData.getDatabase();

    var query = '''
    SELECT ${TableType.id} as id,
    ${TableType.label}     as label
    FROM ${TableType.tableName} 
    ''';

    final result = await db.rawQuery(query);

    final listTypeMovie = <TypeMovie>[];

    for (final item in result) {
      listTypeMovie.add(
        TypeMovie(
          id: item['id'] as int,
          label: item['label'] as String,
        ),
      );
    }

    return listTypeMovie;
  }

  @override
  Future<void> insertTicket(SelectPriceMovie? selectPriceMovie) async {
    final db = await _movieData.getDatabase();

    final listStr = <String>[];

    final list = (selectPriceMovie?.movie?.showSeat ?? <String>[]);

    list.remove(selectPriceMovie?.seat);

    listStr.addAll(list);

    final string = listStr.join(',');

    // db.update(
    //     TableMovie.tableName,
    //     {
    //       TableMovie.showSeat: string,
    //     },
    //     where: '${TableMovie.id} = ?',
    //     whereArgs: [selectPriceMovie?.movie?.id],
    //     conflictAlgorithm: ConflictAlgorithm.replace);

    db.insert(
        TableTicket.tableName,
        TableTicket.toMap(
          selectPriceMovie ?? SelectPriceMovie(),
        ),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<SelectPriceMovie>> getMyTickets() async {
    final db = await _movieData.getDatabase();

    var query = '''
    SELECT ${TableTicket.id} as id,
    ${TableTicket.price} as price,
    ${TableTicket.reimbursement} as reimbursement,
    ${TableTicket.type} as type
    FROM ${TableTicket.tableName} 
    ''';

    final result = await db.rawQuery(query);

    final listMyTickets = <SelectPriceMovie>[];

    for (final item in result) {
      final price = (item['price'].toString());

      listMyTickets.add(
        SelectPriceMovie(
          id: item['id'] as int,
          movieId: item['movie_id'] as int,
          type: item['type'] as String,
          price: double.parse(price),
          reimbursement: item['reimbursement'] == 1,
          movieName: item['movie_name'] as String,
          hours: item['hours'] as String,
          seat: item['seat'] as String,
        ),
      );
    }

    return listMyTickets;
  }

  @override
  Future<void> solicitationReimbursement(
      SelectPriceMovie selectPriceMovie) async {
    final db = await _movieData.getDatabase();

    db.update(
      TableTicket.tableName,
      {
        TableTicket.reimbursement: 1,
      },
      where: '${TableTicket.id} = ?',
      whereArgs: [selectPriceMovie.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    var query = '''
    SELECT ${TableMovie.id}            as id,
    FROM ${TableMovie.tableName} 
    INNER JOIN ${TableMovie.id}  =  ${TableSection.idMovie} 
    WHERE ${TableMovie.id} = ${selectPriceMovie.movieId};
    ''';

    final result = await db.rawQuery(query);

    final listMovie = <Movie>[];

    for (final item in result) {
      final listString = item['show_times'] as String;
      final listSeat = item['seat'] as String;

      listMovie.add(
        Movie(
          id: item['id'] as int,
          showTimes: listString.split(','),
          showSeat: listSeat.split(','),
        ),
      );
    }

    var string;

    for (final (index, item) in listMovie.indexed) {
      final listStr = <String>[];

      final list = (item.showSeat);

      list?.insert(index, selectPriceMovie.seat ?? '');

      listStr.addAll(list ?? []);

      string = listStr.join(',');
    }
    db.update(
        TableMovie.tableName,
        {
        },
        where: '${TableMovie.id} = ?',
        whereArgs: [selectPriceMovie.movieId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    try {
      final db = await _movieData.getDatabase();

      db.insert(
        TableMovie.tableName,
        {
          TableMovie.typeId: movie.idType,
          TableMovie.title: movie.title,
          TableMovie.date: movie.date,
          TableMovie.description: movie.description,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception catch (e) {
      logInfo('Error in insert movie', e);
    }
  }
}
