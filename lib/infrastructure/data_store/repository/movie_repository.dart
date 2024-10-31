import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/movie_tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
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

    final db = await _movieData.getDatabase();


//     db.insert(TableMovie.tableName,
//     {
//       TableMovie.typeId: 1,
//       TableMovie.title: 'Um maluco no pedaço',
//       TableMovie.description: 'comedia',
//       TableMovie.showTimes: '19:00 , 20:30 ,22:00',
//       TableMovie.date: '23/02/2024',
//     }
// ,
// conflictAlgorithm: ConflictAlgorithm.replace,    );
//     db.insert(TableMovie.tableName,
//         {
//           TableMovie.typeId: 2,
//           TableMovie.title: 'O grito',
//           TableMovie.description: 'terror',
//           TableMovie.showTimes: '19:00 , 20:30 ,22:00',
//           TableMovie.date: '23/02/2024',
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     db.insert(TableMovie.tableName,
//         {
//           TableMovie.typeId: 3,
//           TableMovie.title: 'Homem aranha',
//           TableMovie.description: 'filme de açao',
//           TableMovie.showTimes: '19:00 , 20:30 ,22:00',
//           TableMovie.date: '23/02/2024',
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     db.insert(TableMovie.tableName,
//         {
//           TableMovie.typeId: 3,
//           TableMovie.title: 'Planeta dos macacos',
//           TableMovie.description: 'filme de açao',
//           TableMovie.showTimes: '19:00 , 20:30 ,22:00',
//           TableMovie.date: '23/02/2024',
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     db.insert(TableMovie.tableName,
//         {
//           TableMovie.typeId: 2,
//           TableMovie.title: 'A Frera',
//           TableMovie.description: 'filme de terror',
//           TableMovie.showTimes: '19:00 , 20:30 ,22:00',
//           TableMovie.date: '23/02/2024',
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     db.insert(TableMovie.tableName,
//         {
//           TableMovie.typeId: 1,
//           TableMovie.title: 'Gente grande',
//           TableMovie.description: 'comedia',
//           TableMovie.showTimes: '19:00 , 20:30 ,22:00',
//           TableMovie.date: '23/02/2024',
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//     );


    var query = '''
    SELECT ${TableMovie.id}            as id,
    ${TableMovie.typeId}               as id_type,
    ${TableMovie.description}          as description,
    ${TableMovie.date}                 as date,
    ${TableMovie.title}                as title,
    ${TableMovie.showTimes}            as show_times
    FROM ${TableMovie.tableName} 
    ''';

    final result = await db.rawQuery(query);

    final listMovie = <Movie>[];

    for (final item in result) {
      final listString = item['show_times'] as String;

      listMovie.add(
        Movie(
          id: item['id'] as int,
          idType: item['id_type'] as int,
          title: item['title'] as String,
          description: item['description'] as String,
          date: item['date'] as String,
          showTimes: listString.split(','),
        ),
      );
    }

    return listMovie;
  }

  @override
  Future<List<TypeMovie>> getTypeMovie() async {
    final db = await _movieData.getDatabase();

    //
    // db.insert(TableType.tableName,
    //     {
    //       TableType.id: 1,
    //       TableType.label: 'Comedia',
    //     },
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    // db.insert(TableType.tableName,
    //     {
    //       TableType.id: 2,
    //       TableType.label: 'Terror',
    //     },
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    //
    // db.insert(TableType.tableName,
    //     {
    //       TableType.id: 3,
    //       TableType.label: 'Ação',
    //     },
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );


    var query = '''
    SELECT ${TableType.id} as id,
    ${TableType.label} as label
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
}
