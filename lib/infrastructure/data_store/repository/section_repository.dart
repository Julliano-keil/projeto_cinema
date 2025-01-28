import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/movie_tables.dart';

import '../../util/app_log.dart';
import '../interface/section_interface_repository.dart';
import 'data_base/movie_data_base.dart';

SectionRepository newSectionRepository(
  MovieDataBase movieDataBase,
) {
  return _SectionRepository(movieDataBase);
}

class _SectionRepository implements SectionRepository {
  _SectionRepository(this._movieData);

  final MovieDataBase _movieData;

  @override
  Future<List<Room>> getRoomSelection() async {
    try {
      final db = await _movieData.getDatabase();

      var query = '''
    SELECT ${TableRoom.id}     as id,
             ${TableRoom.label}  as label,
             ${TableRoom.local}  as local
      FROM ${TableRoom.tableName}         
      ''';

      final result = await db.rawQuery(query);

      var room = <Room>[];

      for (final item in result) {
        room.add(
          Room(
            id: item['id'] as int?,
            label: item['label'] as String?,
            local: item['local'] as String?,
          ),
        );
      }

      return room;
    } on Exception catch (e) {
      logInfo('Exception', e);
    }
    return [];
  }
}
