import '../../../domain/entities/movie.dart';

abstract class SectionRepository {

  Future<List<Room>> getRoomSelection();

}