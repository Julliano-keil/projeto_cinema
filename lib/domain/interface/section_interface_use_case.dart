import '../entities/movie.dart';

abstract class SectionUseCase {

  Future<List<Room>> getRoomSelection();

  Future<List<Room>> getListRoomAndSection(int movieId,{DateTime? search });

  Future<List<DateTime>> getListDateFilter(int movieId);

  Future<void> insertSection(SectionEntity sectionEntity);

}