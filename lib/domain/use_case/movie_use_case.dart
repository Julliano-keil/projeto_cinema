import 'package:projeto_cinema/domain/entities/movie.dart';

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

  @override
  Future<List<Movie>> getMovie() => _repository.getMovie();

  @override
  Future<List<TypeMovie>> getTypeMovie() => _repository.getTypeMovie();

  @override
  Future<void> insertTicket(SelectPriceMovie? selectPriceMovie) =>
      _repository.insertTicket(selectPriceMovie);

  @override
  Future<List<SelectPriceMovie>> getMyTickets() => _repository.getMyTickets();

  @override
  Future<void> solicitationReimbursement(SelectPriceMovie selectPriceMovie) =>
      _repository.solicitationReimbursement(selectPriceMovie);

  @override
  Future<void> insertMovie(Movie movie) => _repository.insertMovie(movie);

  @override
  Future<List<String>> getListSeat(SectionEntity section) => _repository.getListSeat(section);
}
