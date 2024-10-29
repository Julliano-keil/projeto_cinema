
import '../../infrastructure/data_store/interface/movie_interface_repository.dart';
import '../interface/movie_interface_use_case.dart';

///Interface to deal with the benefits
MovieUseCase newMovieUseCase(
    MovieRepository repository,
    ) {
  return _MovieUseCase(repository);
}

class _MovieUseCase implements MovieUseCase {
  _MovieUseCase(this._repository);

  final MovieRepository _repository;


}