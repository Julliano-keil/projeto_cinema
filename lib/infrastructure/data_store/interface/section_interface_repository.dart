import '../../../domain/entities/movie.dart';

abstract class SectionRepository {

  Future<List<Room>> getRoomSelection();

  Future<void> insertSection(SectionEntity sectionEntity);

  Future<List<Room>> getListRoomAndSection(int movieId,{DateTime? search });

  Future<List<DateTime>> getListDateFilter(int movieId);

}