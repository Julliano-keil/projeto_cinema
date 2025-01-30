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




logInfo('ÇÇÇÇÇ',selectPriceMovie?.section.toString());

   final idSeat = await db.insert(
        TableSeat.tableName,
        {
          TableSeat.roomId:selectPriceMovie?.section?.idRoom,
          TableSeat.label:selectPriceMovie?.seat?.trim(),

        },
        conflictAlgorithm: ConflictAlgorithm.replace);





    await db.insert(
        TableTicket.tableName,
        TableTicket.toMap(
          selectPriceMovie?.copyWith(
            seatId:idSeat ,
          ) ?? SelectPriceMovie(),
        ),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<SelectPriceMovie>> getMyTickets() async {
    final db = await _movieData.getDatabase();

    var query = '''
    SELECT t.${TableTicket.id}         as id,
           t.${TableTicket.price}      as price,
           t.${TableTicket.idSeat}     as id_seat,
           s.${TableSeat.label}        as label_seat,
           m.${TableMovie.title}       as movie_name,
           m.${TableMovie.id}          as id_movie,
           sc.${TableSection.hours}    as hours,
           tt.${TableType.label}       as type_movie,
           t.${TableTicket.reimbursement} as reimbursement
    FROM ${TableTicket.tableName} t  
    LEFT JOIN ${TableSeat.tableName} s ON t.${TableTicket.idSeat} = s.${TableSeat.id}
    LEFT JOIN ${TableSection.tableName} sc ON t.${TableTicket.idSection} = sc.${TableSection.id}
    LEFT JOIN ${TableMovie.tableName} m ON sc.${TableSection.idMovie} = m.${TableMovie.id}
    LEFT JOIN ${TableType.tableName} tt ON m.${TableMovie.typeId} = tt.${TableType.id}
    ''';

    final result = await db.rawQuery(query);

    final listMyTickets = <SelectPriceMovie>[];

    for (final item in result) {
      final price = (item['price'].toString());

      listMyTickets.add(
        SelectPriceMovie(
          id: item['id'] as int,
          movieId: item['id_movie'] as int,
          type: item['type_movie'] as String,
          price: double.parse(price),
          reimbursement: item['reimbursement'] == 1,
          movieName: item['movie_name'] as String,
          hours: item['hours'] as String,
          seatId: item['id_seat'] as int,
          seat: item['label_seat'] as String?,
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

    await db.update(
      TableSeat.tableName,
      {
        TableSeat.statusCode: 1,
      },
      where: '${TableSeat.id} IN (SELECT id FROM ${TableSeat.tableName} WHERE ${TableSeat.label} = ? AND ${TableSeat.roomId} = ?)',
      whereArgs: [selectPriceMovie.seat, selectPriceMovie.movieId],
    );





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

  @override
  Future<List<String>> getListSeat(SectionEntity section) async{
    final db = await _movieData.getDatabase();

    var query = '''
    SELECT s.${TableSeat.id} as id,
           s.${TableSeat.label}     as label
    FROM ${TableSeat.tableName} s
     LEFT JOIN ${TableSection.tableName} sc ON ${section.id} = sc.${TableSection.id}
    LEFT JOIN ${TableMovie.tableName} m ON sc.${TableSection.idMovie} = m.${TableMovie.id}
    WHERE s.${TableSeat.roomId} = ${section.idMovie} AND sc.${TableSection.id} = ${section.id}    
    AND   s.${TableSeat.statusCode} != 1 
    ''';

    final result = await db.rawQuery(query);

    final listSection = <String>[];
    for (final item in result) {
      listSection.add(
       item['label'] as String,
      );
    }

    return listSection;
  }
}
