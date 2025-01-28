import '../entities/movie.dart';

abstract class SectionUseCase {

  Future<List<Room>> getRoomSelection();


}