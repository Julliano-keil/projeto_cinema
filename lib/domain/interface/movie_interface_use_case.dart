import 'package:projeto_cinema/domain/entities/movie.dart';

abstract class MovieUseCase {
  Future<List<TypeMovie>> getTypeMovie();

  Future<List<Movie>> getMovie();

  /// insert Ticket
  Future<void> insertTicket(SelectPriceMovie? selectPriceMovie);

  /// insert Ticket
  Future<List<SelectPriceMovie>> getMyTickets();
}
