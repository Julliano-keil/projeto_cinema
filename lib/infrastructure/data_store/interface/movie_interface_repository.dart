import '../../../domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<TypeMovie>> getTypeMovie();

  Future<List<Movie>> getMovie();
}
