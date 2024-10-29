
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


}