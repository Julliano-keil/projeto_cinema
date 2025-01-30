import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/data_base/movie_tables.dart';
import 'package:projeto_cinema/infrastructure/util/text_form.dart';
import 'package:sqflite/sqflite.dart';

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

  @override
  Future<void> insertSection(SectionEntity sectionEntity) async {
    try {
      final db = await _movieData.getDatabase();

      db.insert(
          TableSection.tableName,
          {
            TableSection.roomId: sectionEntity.idRoom,
            TableSection.idMovie: sectionEntity.idMovie,
            TableSection.hours: sectionEntity.date,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    } on Exception catch (e) {
      logInfo('Exception', e);
    }
  }

  @override
  Future<List<Room>> getListRoomAndSection(int movieId, {DateTime? search}) async {
    try {
      final db = await _movieData.getDatabase();
      
      final dateSearch = tryFormatDate('dd/MM/yyyy',search);


      final dateSearchFormat = tryParseDate('dd/MM/yyyy',dateSearch );

 
      var query = '''
    SELECT 
        r.${TableRoom.id}            AS room_id,
        r.${TableRoom.label}         AS room_label,
        r.${TableRoom.local}         AS room_local,
        s.${TableSection.id}         AS section_id,
        s.${TableSection.hours}      AS section_hours,
        s.${TableSection.idMovie}    AS section_id_movie
    FROM ${TableRoom.tableName} r
    LEFT JOIN ${TableSection.tableName} s ON s.${TableSection.roomId} = r.${TableRoom.id}
    AND s.${TableSection.idMovie} = $movieId
    ''';

      final result = await db.rawQuery(query);

      if (result.isEmpty) {
        return []; 
      }

      
      final Map<int, Room> roomsMap = {};
      for (final row in result) {
        final roomId = row['room_id'] as int?;
        if (roomId == null) continue;

        
        final room = roomsMap.putIfAbsent(
          roomId,
              () => Room(
            id: roomId,
            label: row['room_label'] as String?,
            local: row['room_local'] as String?,
            sections: [],
          ),
        );

       
        final sectionId = row['section_id'] as int?;
        if (sectionId != null) {
          

          if (search != null) {
          final dateFormat = tryParseDate('dd/MM/yyyy HH:mm', row['section_hours'] as String?);

          final dateFormat2 = tryFormatDate('dd/MM/yyyy', dateFormat);

          final dateFormat3 = tryParseDate('dd/MM/yyyy', dateFormat2);



            if(dateFormat3 == dateSearchFormat){
              room.sections?.add(
                SectionEntity(
                  id: sectionId,
                  idMovie: row['section_id_movie'] as int?,
                  date: row['section_hours'] as String?,
                  idRoom: row['room_id'] as int?,
                ),
              );
            }
            continue;
          }
          
          
          room.sections?.add(
            SectionEntity(
              id: sectionId,
              idMovie: row['section_id_movie'] as int?,
              date: row['section_hours'] as String?,
              idRoom: row['room_id'] as int?,
            ),
          );
        }
      }

      
      return roomsMap.values.toList();
    } catch (e, stackTrace) {
      logInfo('Error while fetching rooms and sections', e, );
      return [];
    }
  }


  @override
  Future<List<DateTime>> getListDateFilter(int movieId) async {
    final db = await _movieData.getDatabase();

    var querySection = '''
    SELECT   s.${TableSection.id}          as id,
             s.${TableSection.hours}       as label
      FROM   ${TableSection.tableName} s
      WHERE  s.${TableSection.idMovie} = $movieId
      ''';

    final result = await db.rawQuery(querySection);

    final dateSet = <DateTime>{};

    for (final item in result) {
      var date = tryParseDate('dd/MM/yyyy HH:mm', item['label'] as String?) ??
          DateTime.now();

      var dateFormat = tryFormatDate('dd/MM/yyyy', date);
      var format = tryParseDate('dd/MM/yyyy', dateFormat);

      dateSet.add(format!);
    }

    return dateSet.toList();
  }
}
